# Custom GitHub Actions Runner for Docker (M1 Mac)

A minimal, ARM64-compatible Docker image for running GitHub Actions self-hosted runners on your M1 MacBook Pro.

## Quick Start

### 1. Build the image

```bash
docker build -t my-github-runner:latest .
```

### 2. Run with your project details

```bash
docker run -d \
  --name github-runner \
  --restart unless-stopped \
  -e GITHUB_URL=https://github.com/kirussell/project_healer \
  -e GITHUB_TOKEN=<your-token-here> \
  -e RUNNER_NAME=m1-runner \
  my-github-runner:latest
```

Replace:
- `<your-token-here>` with your token from GitHub
- `RUNNER_NAME` with whatever you want to call this runner (optional)

### 3. Verify

Go to your GitHub repo → **Settings** → **Actions** → **Runners**

Your runner should appear within seconds.

## Getting Your Token

1. Go to your repo: **Settings** → **Actions** → **Runners**
2. Click **New self-hosted runner**
3. Copy the token from the setup instructions (the long string after `--token`)

## Testing

Create a test workflow in your repo:

```yaml
# .github/workflows/test.yml
name: Test

on: [push]

jobs:
  test:
    runs-on: [self-hosted]
    steps:
      - run: echo "Runner working!"
      - run: uname -a
```

## Docker Commands

### View logs
```bash
docker logs -f github-runner
```

### Stop runner
```bash
docker stop github-runner
```

### Remove runner
```bash
docker rm github-runner
```

### Restart runner
```bash
docker restart github-runner
```

## Environment Variables

Pass these with `-e` flag:

| Variable | Required | Example |
|----------|----------|---------|
| `GITHUB_URL` | Yes | `https://github.com/kirussell/project_healer` |
| `GITHUB_TOKEN` | Yes | Your token from GitHub |
| `RUNNER_NAME` | No | `m1-runner` (default: `docker-runner-<hostname>`) |

## Multiple Runners

Run multiple instances with different names:

```bash
# Runner 1
docker run -d \
  --name runner-1 \
  --restart unless-stopped \
  -e GITHUB_URL=https://github.com/kirussell/project_healer \
  -e GITHUB_TOKEN=token1 \
  -e RUNNER_NAME=m1-runner-1 \
  my-github-runner:latest

# Runner 2
docker run -d \
  --name runner-2 \
  --restart unless-stopped \
  -e GITHUB_URL=https://github.com/kirussell/project_healer \
  -e GITHUB_TOKEN=token2 \
  -e RUNNER_NAME=m1-runner-2 \
  my-github-runner:latest
```

## With Docker Support

If your workflows need to build Docker images:

```bash
docker run -d \
  --name github-runner \
  --restart unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e GITHUB_URL=https://github.com/kirussell/project_healer \
  -e GITHUB_TOKEN=<your-token> \
  -e RUNNER_NAME=m1-runner \
  my-github-runner:latest
```

⚠️ This reduces isolation—only add if needed.

## Troubleshooting

### Runner not appearing in GitHub

```bash
# Check logs
docker logs github-runner

# Common issues:
# - Invalid token
# - Wrong URL
# - Network issue
```

### Container exits

```bash
docker logs github-runner
```

Check that `GITHUB_URL` and `GITHUB_TOKEN` are set correctly.

## What's Inside

- **Ubuntu 22.04 (Jammy)** base image
- **GitHub Actions Runner 2.331.0** (ARM64 version)
- **Non-root runner user** for security
- **No host filesystem access** by default
- **ARM64 native** (M1 Mac optimized)

## Version Updates

To use a different runner version, build with:

```bash
docker build --build-arg RUNNER_VERSION=2.340.0 -t my-github-runner:latest .
```

Check available versions: https://github.com/actions/runner/releases


