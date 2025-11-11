# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install JDK, bash, and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-17-jdk-headless \
        bash curl unzip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME and PATH
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-riscv64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Open Liberty version and paths
ENV OPENLIBERTY_HOME=/opt/openliberty
ENV OPENLIBERTY_VERSION=24.0.0.11
ENV OPENLIBERTY_FLAVOR=wlp-webProfile8
ENV OPENLIBERTY_URL="https://public.dhe.ibm.com/ibmdl/export/pub/software/openliberty/runtime/release/${OPENLIBERTY_VERSION}/${OPENLIBERTY_FLAVOR}-${OPENLIBERTY_VERSION}.zip"

# Download and install Open Liberty
RUN mkdir -p ${OPENLIBERTY_HOME} && \
    echo "Downloading Open Liberty from ${OPENLIBERTY_URL}" && \
    curl -fSL --retry 5 --retry-delay 5 ${OPENLIBERTY_URL} -o /tmp/openliberty.zip && \
    unzip -q /tmp/openliberty.zip -d /opt && \
    mv /opt/wlp ${OPENLIBERTY_HOME} && \
    rm /tmp/openliberty.zip

# Make server script executable
RUN chmod +x ${OPENLIBERTY_HOME}/bin/server

# Create default server
RUN ${OPENLIBERTY_HOME}/bin/server create defaultServer

# Expose HTTP and HTTPS ports
EXPOSE 9080 9443

WORKDIR ${OPENLIBERTY_HOME}

# Run default server
CMD ["bin/server", "run", "defaultServer"]
