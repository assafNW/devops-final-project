# =============================================================
# SeyoAWE CLI — Dockerfile
# Location in repo: docker/cli/Dockerfile
# Build context: repo root
#
# The cli is a pre-compiled binary (cli/binaries/linux/sawctl) 
# that runs a workflow automation cli tool (controller).
# Usage:
#   docker run --rm seyoawe-cli:1.2.0 --help
#   docker run --rm -v $(pwd)/workflows:/workflows \
#       seyoawe-cli:1.2.0 run /workflows/hello-world.yaml
# =============================================================

FROM ubuntu:24.04

# Only need curl for the health check + ca-certificates for outbound TLS
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        python3 \
        git \
    && rm -rf /var/lib/apt/lists/*

# Installing ttyd binary from GitHub releases
RUN curl -fsSL https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 \
    -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Create a system group (for services) called sawectl.
RUN groupadd -r -g 10001 sawectl
# Create a new system user          - sawectl (for services, not login) 
# Attaches it to the new group      - sawectl
# Create and set new home directory - /home/sawectl
RUN useradd -r -u 10001 -g sawectl -m -d /home/sawectl -s /bin/bash sawectl

# Copy the pre-compiled linux binary from the repo
# Build context: repo root - docker build -f docker/cli/Dockerfile .
COPY ./cli/binaries/linux/sawectl /usr/local/bin/sawectl
# COPY ./engine/modules /home/sawectl/modules
# COPY ./engine/workflows /home/sawectl/workflows

RUN mkdir -p /home/sawectl/modules /home/sawectl/workflows

VOLUME [ "/home/sawectl/modules", "/home/sawectl/workflows" ]

# Set the `ENGINE_URL` environment variable for the CLI container using
# `docker run ... -e ENGINE_URL="..." ...` to simplify the execution of SeyoAWE workflows.
# ENV ENGINE_URL=""

# Granting executable permissions for cli's binary file
RUN chmod +x ./usr/local/bin/sawectl

# Creating folders for the persistent storage
RUN chown -R sawectl:sawectl /home/sawectl

# Working directory — users mount their workflow files here
WORKDIR /home/sawectl

USER sawectl

# Web terminal port
EXPOSE 8081

# Matches livenessProbe / readinessProbe in k8s/engine/statefulset.yaml
HEALTHCHECK --interval=60s --timeout=5s --retries=2 \
    CMD curl -f http://localhost:8081 || exit 1

# Entrypoint
# ttyd serves a bash shell — sawectl is on PATH so users can
# run: sawectl run workflows/hello.yaml  directly in the browser
ENTRYPOINT ["ttyd", "--writable", "--port", "8081", "bash", "-i", "-c", "sawectl; exec bash"]