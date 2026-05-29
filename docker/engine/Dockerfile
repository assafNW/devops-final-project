# =============================================================
# SeyoAWE Engine — Dockerfile
# Location in repo: docker/engine/Dockerfile
# Build context: repo root
#
# The engine is a pre-compiled binary (seyoawe.linux) that
# runs a Flask-based workflow automation server on port 8080.
# Persistent data (lifetimes, logs, workdir) is stored on a
# persistant volume.
# =============================================================

FROM ubuntu:24.04

# Only need curl for the health check + ca-certificates for outbound TLS
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        python3 \
        git \
    && rm -rf /var/lib/apt/lists/*

# Create a system group (for services) called seyoawe.
RUN groupadd -r -g 10001 seyoawe
# Create a new system user          - seyoawe (for services, not login) 
# Attaches it to the new group      - seyoawe 
# Create and set new home directory - /app
RUN useradd -r -u 10001 -g seyoawe -m -d /app seyoawe

WORKDIR /app

VOLUME ["/app/logs", "/app/lifetimes"]

# Copy engine source:
#   Assumes build context is the repo root:
#       docker build -f ./docker/engine/Dockerfile .
COPY ./engine/seyoawe.linux /app/seyoawe.linux
COPY ./engine/run.sh /app/run.sh
COPY ./engine/configuration/ /app/configuration/
# COPY ./engine/modules/ /app/modules/
# COPY ./engine/workflows/ /app/workflows

RUN mkdir -p /app/lifetimes \
             /app/logs \
             /app/modules \
             /app/workflows

# Granting executable permissions for engine's files, 
# and making the new user the owner of the /app directory.
RUN chmod +x ./seyoawe.linux ./run.sh \
    && chown -R seyoawe:seyoawe /app

EXPOSE 8080
EXPOSE 9000

USER seyoawe

# Matches livenessProbe / readinessProbe in k8s/engine/statefulset.yaml
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# run.sh selects the binary by platform — always 'linux' in a container
ENTRYPOINT ["/app/run.sh", "linux"]