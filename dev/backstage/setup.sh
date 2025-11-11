#!/usr/bin/env bash
set -euo pipefail

# ------------------------
# Configuration
# ------------------------
APP_NAME="backstage"
APP_DIR="$PWD/$APP_NAME"
BACKSTAGE_RELEASE="1.42.1"
NODE_VERSION_MIN=18

echo
echo "=== Backstage automated setup script ==="
echo "App dir: $APP_DIR"
echo "Target Backstage release: $BACKSTAGE_RELEASE"
echo

# Quick environment checks
command -v node >/dev/null 2>&1 || echo "Warning: node not found (need >= ${NODE_VERSION_MIN})"
command -v yarn >/dev/null 2>&1 || echo "Warning: yarn not found"

# ------------------------
# 1) Create Backstage app
# ------------------------
if [ -d "$APP_DIR" ]; then
  echo "Directory $APP_DIR already exists — aborting to avoid overwriting."
  exit 1
fi

echo "=== 1) Creating Backstage app ==="
npx --ignore-existing @backstage/create-app@latest "$APP_DIR"
cd "$APP_DIR"

# ------------------------
# 2) Bump Backstage versions
# ------------------------
echo "=== 2) Bumping Backstage packages to release $BACKSTAGE_RELEASE ==="
yarn backstage-cli versions:bump --release "$BACKSTAGE_RELEASE"

# ------------------------
# 3) Install backend plugins
# ------------------------
echo "=== 3) Installing backend plugins ==="
yarn --cwd packages/backend add \
  @backstage/plugin-catalog-backend \
  @backstage/plugin-catalog-backend-module-scaffolder-entity-model \
  @backstage/plugin-catalog-backend-module-unprocessed \
  @backstage/plugin-catalog-backend-module-github \
  @backstage/plugin-catalog-backend-module-gitea \
  @backstage/plugin-scaffolder-backend \
  @backstage/plugin-scaffolder-backend-module-github \
  @backstage/plugin-scaffolder-backend-module-notifications \
  @backstage/plugin-auth-backend \
  @backstage/plugin-auth-backend-module-guest-provider \
  @backstage/plugin-techdocs-backend \
  @backstage/plugin-kubernetes-backend \
  @backstage/plugin-devtools-backend \
  @backstage/plugin-app-backend \
  @backstage/plugin-proxy-backend \
  @backstage/plugin-permission-backend \
  @backstage/plugin-permission-backend-module-allow-all-policy \
  @backstage/plugin-notifications-backend \
  @backstage/plugin-events-backend \
  @backstage/plugin-search-backend \
  @backstage/plugin-search-backend-module-catalog \
  @backstage/plugin-search-backend-module-techdocs

# ------------------------
# 4) Install frontend plugins
# ------------------------
echo "=== 4) Installing frontend plugins ==="
yarn --cwd packages/app add \
  @backstage/plugin-catalog \
  @backstage/plugin-catalog-graph \
  @backstage/plugin-catalog-import \
  @backstage/plugin-techdocs \
  @backstage/plugin-techdocs-module-addons-contrib \
  @backstage/plugin-scaffolder \
  @backstage/plugin-user-settings \
  @backstage/plugin-search \
  @backstage/plugin-api-docs \
  @backstage/plugin-org

# ------------------------
# 5) Patch backend index.ts with static imports
# ------------------------
echo "=== 5) Patching backend index.ts ==="
BACKEND_FILE="packages/backend/src/index.ts"

mkdir -p "$(dirname "$BACKEND_FILE")"

cat > "$BACKEND_FILE" <<'EOF'
import { createBackend } from '@backstage/backend-defaults';
import { createBackendFeatureLoader } from '@backstage/backend-plugin-api';

import appBackend from '@backstage/plugin-app-backend';
import catalogBackend from '@backstage/plugin-catalog-backend';
import catalogScaffolderEntityModel from '@backstage/plugin-catalog-backend-module-scaffolder-entity-model';
import catalogUnprocessed from '@backstage/plugin-catalog-backend-module-unprocessed';
import catalogGithub from '@backstage/plugin-catalog-backend-module-github';
import catalogGitea from '@backstage/plugin-catalog-backend-module-gitea';
import scaffolderBackend from '@backstage/plugin-scaffolder-backend';
import scaffolderGithub from '@backstage/plugin-scaffolder-backend-module-github';
import scaffolderNotifications from '@backstage/plugin-scaffolder-backend-module-notifications';
import authBackend from '@backstage/plugin-auth-backend';
import guestProvider from '@backstage/plugin-auth-backend-module-guest-provider';
import techdocsBackend from '@backstage/plugin-techdocs-backend';
import kubernetesBackend from '@backstage/plugin-kubernetes-backend';
import devtoolsBackend from '@backstage/plugin-devtools-backend';
import proxyBackend from '@backstage/plugin-proxy-backend';
import permissionBackend from '@backstage/plugin-permission-backend';
import allowAllPolicy from '@backstage/plugin-permission-backend-module-allow-all-policy';
import notificationsBackend from '@backstage/plugin-notifications-backend';
import eventsBackend from '@backstage/plugin-events-backend';

const backend = createBackend();

backend.add(appBackend);
backend.add(catalogBackend);
backend.add(catalogScaffolderEntityModel);
backend.add(catalogUnprocessed);
backend.add(catalogGithub);
backend.add(catalogGitea);

backend.add(scaffolderBackend);
backend.add(scaffolderGithub);
backend.add(scaffolderNotifications);

backend.add(authBackend);
backend.add(guestProvider);

backend.add(techdocsBackend);
backend.add(kubernetesBackend);

backend.add(devtoolsBackend);
backend.add(proxyBackend);
backend.add(permissionBackend);
backend.add(allowAllPolicy);
backend.add(notificationsBackend);
backend.add(eventsBackend);

const searchLoader = createBackendFeatureLoader({
  *loader() {
    yield import('@backstage/plugin-search-backend');
    yield import('@backstage/plugin-search-backend-module-catalog');
    yield import('@backstage/plugin-search-backend-module-techdocs');
  },
});
backend.add(searchLoader);

backend.start();
EOF

echo "✓ Backend index.ts patched."

# ------------------------
# 6) Do NOT overwrite App.tsx
# ------------------------
echo "=== 6) Preserving existing App.tsx ==="

# ------------------------
# 7) Install workspace dependencies
# ------------------------
echo "=== 7) Installing workspace dependencies ==="
yarn install

# ------------------------
# 8) Build backend bundle
# ------------------------
echo "=== 8) Building backend bundle ==="
yarn workspace backend build

# ------------------------
# 9) Build Docker image
# ------------------------
echo "=== 9) Building backend Docker image ==="
yarn workspace backend build-image

echo "=== DONE ==="
echo "Backstage app created at: $APP_DIR"
echo "Docker image built successfully. Run with: docker run -p 7007:7007 <image_name>"
