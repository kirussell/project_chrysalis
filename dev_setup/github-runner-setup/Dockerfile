# GitHub Actions Runner - Ubuntu Jammy (22.04)
# ARM64 (M1 Mac) compatible
# Based on official GitHub instructions

FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create runner user (non-root)
RUN useradd -m -d /home/runner -s /bin/bash runner && \
    usermod -aG sudo runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Download and extract GitHub Actions Runner
# Version must match your needs - check: https://github.com/actions/runner/releases
ARG RUNNER_VERSION=2.331.0
WORKDIR /home/runner

RUN curl -o actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    chown -R runner:runner /home/runner

# Install runner dependencies (as root)
RUN /home/runner/bin/installdependencies.sh

# Copy and set up entrypoint
COPY entrypoint.sh /home/runner/entrypoint.sh
RUN chmod +x /home/runner/entrypoint.sh && chown runner:runner /home/runner/entrypoint.sh

# Switch to runner user
USER runner

ENTRYPOINT ["/home/runner/entrypoint.sh"]
