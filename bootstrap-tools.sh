#!/usr/bin/env bash
set -euo pipefail

# Install LSP tools managed outside Mason.
# npm registry/auth should be configured per machine via npm config.

if ! command -v npm >/dev/null 2>&1; then
  echo 'error: npm is required but was not found in PATH' >&2
  exit 1
fi

npm install -g typescript typescript-language-server yaml-language-server

echo
printf 'typescript-language-server: '
typescript-language-server --version || true
printf 'yaml-language-server: '
yaml-language-server --version || true
