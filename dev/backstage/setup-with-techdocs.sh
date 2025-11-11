#!/bin/bash
set -e

# ------------------------
# Load NVM
# ------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Use Node 20
nvm use 20

# ------------------------
# Configuration
# ------------------------
APP_NAME="backstage"
APP_DIR="$PWD/$APP_NAME"

echo "=== 1. Creating Backstage app ==="
# Use --ignore-existing to avoid cached/missing binaries
npx --ignore-existing @backstage/create-app@latest "$APP_DIR"

cd "$APP_DIR"

echo "=== 2. Bumping Backstage version to 1.42.1 ==="
yarn backstage-cli versions:bump --release 1.42.1

echo "=== 3. Installing plugin dependencies (Yarn 4 compatible) ==="
# Backend plugins
yarn --cwd packages/backend add \
  @backstage/plugin-techdocs-backend \
  @backstage/plugin-catalog-backend-module-github \
  @backstage/plugin-catalog-backend-module-gitea \
  @backstage/plugin-devtools-backend
# Frontend plugins
yarn --cwd packages/app add \
  @backstage/plugin-techdocs \
  @backstage/plugin-catalog \
  @backstage/plugin-catalog-graph \
  @backstage/plugin-techdocs-module-addons-contrib

echo "=== 4. Patching backend/src/index.ts ==="
BACKEND_FILE=packages/backend/src/index.ts
cat > "$BACKEND_FILE" <<'EOF'
import { createBackend } from '@backstage/backend-defaults';
import { createBackendFeatureLoader } from '@backstage/backend-plugin-api';

const backend = createBackend();

// Catalog
backend.add(import('@backstage/plugin-catalog-backend'));
backend.add(import('@backstage/plugin-catalog-backend-module-scaffolder-entity-model'));
backend.add(import('@backstage/plugin-catalog-backend-module-unprocessed'));
backend.add(import('@backstage/plugin-catalog-backend-module-github'));
backend.add(import('@backstage/plugin-catalog-backend-module-gitea'));
backend.add(import('@backstage/plugin-devtools-backend'));
// Scaffolder
backend.add(import('@backstage/plugin-scaffolder-backend'));
backend.add(import('@backstage/plugin-scaffolder-backend-module-github'));
backend.add(import('@backstage/plugin-scaffolder-backend-module-notifications'));

// Auth
backend.add(import('@backstage/plugin-auth-backend'));
backend.add(import('@backstage/plugin-auth-backend-module-guest-provider'));

// TechDocs
backend.add(import('@backstage/plugin-techdocs-backend'));

// Kubernetes
backend.add(import('@backstage/plugin-kubernetes-backend'));

// Search
const searchLoader = createBackendFeatureLoader({
  *loader() {
    yield import('@backstage/plugin-search-backend');
    yield import('@backstage/plugin-search-backend-module-catalog');
    yield import('@backstage/plugin-search-backend-module-techdocs');
  },
});
backend.add(searchLoader);

// Misc
backend.add(import('@backstage/plugin-devtools-backend'));
backend.add(import('@backstage/plugin-app-backend'));
backend.add(import('@backstage/plugin-proxy-backend'));
backend.add(import('@backstage/plugin-permission-backend'));
backend.add(import('@backstage/plugin-permission-backend-module-allow-all-policy'));
backend.add(import('@backstage/plugin-notifications-backend'));
backend.add(import('@backstage/plugin-events-backend'));

backend.start();
EOF
echo "✓ Backend patched."

echo "=== 5. Patching packages/app/src/App.tsx ==="
APP_FILE=packages/app/src/App.tsx
cat > "$APP_FILE" <<'EOF'
import React from 'react';
import { createApp } from '@backstage/app-defaults';
import { FlatRoutes } from '@backstage/core-app-api';
import { Route, Navigate } from 'react-router-dom';

import { CatalogIndexPage, CatalogEntityPage } from '@backstage/plugin-catalog';
import { CatalogGraphPage } from '@backstage/plugin-catalog-graph';
import { ApiExplorerPage } from '@backstage/plugin-api-docs';

import { TechDocsIndexPage, TechDocsReaderPage } from '@backstage/plugin-techdocs';
import { ScaffolderPage } from '@backstage/plugin-scaffolder';
import { SearchPage } from '@backstage/plugin-search';
import { UserSettingsPage } from '@backstage/plugin-user-settings';

const app = createApp();

const routes = (
  <FlatRoutes>
    <Route path="/" element={<Navigate to="/catalog" />} />

    <Route path="/catalog" element={<CatalogIndexPage />} />
    <Route path="/catalog/:namespace/:kind/:name" element={<CatalogEntityPage />} />

    <Route path="/catalog-graph" element={<CatalogGraphPage />} />

    <Route path="/api-docs" element={<ApiExplorerPage />} />

    <Route path="/docs" element={<TechDocsIndexPage />} />
    <Route path="/docs/:namespace/:kind/:name/*" element={<TechDocsReaderPage />} />

    <Route path="/search" element={<SearchPage />} />

    <Route path="/create" element={<ScaffolderPage />} />

    <Route path="/settings" element={<UserSettingsPage />} />
  </FlatRoutes>
);

export default app.createRoot(routes);
EOF
echo "✓ App.tsx patched."

echo "=== 6. Installing all dependencies ==="
# Yarn 4 uses --immutable instead of --frozen-lockfile
yarn install --immutable

echo "=== 7. Building backend artifacts ==="
yarn workspace backend build

# Verify the build output
if [ ! -f packages/backend/dist/bundle.tar.gz ] || [ ! -f packages/backend/dist/skeleton.tar.gz ]; then
  echo "❌ Backend build failed: required files not found!"
  exit 1
fi
echo "✓ Backend build complete."

# -----------------------------
# 8a. Patch backend Dockerfile to include TechDocs/MkDocs + Yarn 4 support
# -----------------------------
DOCKERFILE=packages/backend/Dockerfile
cat > "$DOCKERFILE" <<'EOF'
# This dockerfile builds an image for the backend package.
# It should be executed with the root of the repo as docker context.
#
# Before building this image, be sure to have run the following commands in the repo root:
#
# yarn install
# yarn tsc
# yarn build:backend
#
# Once the commands have been run, you can build the image using `yarn build-image`

FROM node:20-bookworm-slim

# Install sqlite3 dependencies. You can skip this if you don't use sqlite3 in the image,
# in which case you should also move better-sqlite3 to "devDependencies" in package.json.
# Additionally, we install dependencies for `techdocs.generator.runIn: local`.
# https://backstage.io/docs/features/techdocs/getting-started#disabling-docker-in-docker-situation-optional
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y --no-install-recommends libsqlite3-dev python3 python3-pip python3-venv build-essential && \
    yarn config set python /usr/bin/python3

# Set up a virtual environment for mkdocs-techdocs-core.
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install mkdocs-techdocs-core==1.1.7

# From here on we use the least-privileged `node` user to run the backend.
WORKDIR /app
RUN chown node:node /app
RUN mkdir -p /home/node/.yarn && chown -R node:node /home/node/.yarn
USER node


# This switches many Node.js dependencies to production mode.
ENV NODE_ENV=production

# Copy over Yarn 3 configuration, release, and plugins
COPY --chown=node:node .yarn ./.yarn
COPY --chown=node:node .yarnrc.yml ./

# Copy repo skeleton first, to avoid unnecessary docker cache invalidation.
# The skeleton contains the package.json of each package in the monorepo,
# and along with yarn.lock and the root package.json, that's enough to run yarn install.
COPY --chown=node:node yarn.lock package.json packages/backend/dist/skeleton.tar.gz ./
RUN tar xzf skeleton.tar.gz && rm skeleton.tar.gz

RUN --mount=type=cache,target=/home/node/.yarn/berry/cache,sharing=locked,uid=1000,gid=1000 \
    yarn workspaces focus --all --production

# Then copy the rest of the backend bundle, along with any other files we might want.
COPY --chown=node:node packages/backend/dist/bundle.tar.gz app-config*.yaml ./
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

CMD ["node", "packages/backend", "--config", "app-config.yaml"]
EOF
echo "✓ Backend Dockerfile patched with TechDocs + Yarn 4 support."
echo "=== 8. Building backend Docker image ==="
yarn workspace backend build-image

echo "✅ Backstage 1.42.1 setup complete with TechDocs!"
echo "Run with: docker run -p 7007:7007 <image_name>"
