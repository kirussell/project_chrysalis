#!/bin/bash

set -e

# GitHub Actions Runner Entrypoint
# Mirrors official GitHub setup instructions

echo "Starting GitHub Actions Runner..."

# Validate required environment variables
if [ -z "$GITHUB_URL" ]; then
    echo "Error: GITHUB_URL not set"
    echo "Example: https://github.com/your-org/your-repo"
    exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN not set"
    exit 1
fi

# Set runner name
RUNNER_NAME=${RUNNER_NAME:-"docker-runner-$(hostname)"}

# Configure runner (mirrors: ./config.sh --url <URL> --token <TOKEN>)
echo "Configuring runner: $RUNNER_NAME"
./config.sh \
    --url "$GITHUB_URL" \
    --token "$GITHUB_TOKEN" \
    --name "$RUNNER_NAME" \
    --work "_work" \
    --labels "docker,arm64" \
    --replace \
    --unattended

# Trap signals for graceful shutdown
cleanup() {
    echo "Runner shutting down..."
    exit 0
}

trap cleanup SIGTERM SIGINT

# Run the runner (mirrors: ./run.sh)
echo "Runner starting..."
./run.sh
