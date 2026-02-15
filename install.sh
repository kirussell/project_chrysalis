#!/usr/bin/env bash
set -euo pipefail

# Navigate to the project root (parent of the directory containing this script)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SUBMODULE_NAME="$(basename "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Create symlinks for directories managed by the submodule
for dir in .github .gemini; do
  target="$SUBMODULE_NAME/$dir"

  if [ ! -d "$target" ]; then
    echo "Warning: $target does not exist in submodule, skipping"
    continue
  fi

  if [ -L "$dir" ]; then
    echo "$dir symlink already exists, skipping"
  elif [ -e "$dir" ]; then
    echo "Error: $dir already exists and is not a symlink. Remove it first."
    exit 1
  else
    ln -s "$target" "$dir"
    echo "Created symlink $dir -> $target"
  fi
done

echo "Done. Symlinks are in place."
