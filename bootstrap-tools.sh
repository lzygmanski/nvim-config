#!/usr/bin/env bash
set -euo pipefail

# Install external tools that are intentionally managed outside Mason.

if ! command -v tree-sitter >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    brew install tree-sitter-cli
  else
    echo 'error: tree-sitter-cli is required but was not found in PATH' >&2
    echo 'install it with your system package manager before running Neovim' >&2
    exit 1
  fi
fi

if ! command -v npm >/dev/null 2>&1; then
  echo 'error: npm is required but was not found in PATH' >&2
  exit 1
fi

npm install -g prettier pyright typescript typescript-language-server yaml-language-server

echo
printf 'tree-sitter: '
tree-sitter --version || true
printf 'prettier: '
prettier --version || true
printf 'pyright: '
pyright --version || true
printf 'typescript-language-server: '
typescript-language-server --version || true
printf 'yaml-language-server: '
yaml-language-server --version || true
