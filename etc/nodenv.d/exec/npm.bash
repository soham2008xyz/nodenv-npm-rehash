#!/usr/bin/env bash

resolve_link() {
  $(type -p greadlink readlink | head -1) "$1"
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(resolve_link "$name" || true)"
  done

  pwd
  cd "$cwd"
}

NODENV_NPM_REHASH_ROOT="$(abs_dirname "$(abs_dirname "${BASH_SOURCE[0]}")/../../../..")"

if [ -x "${NODENV_NPM_REHASH_ROOT}/libexec/${NODENV_COMMAND##*/}" ]; then
  NODENV_COMMAND_PATH="${NODENV_NPM_REHASH_ROOT}/libexec/${NODENV_COMMAND##*/}"
  NODENV_BIN_PATH="${NODENV_NPM_REHASH_ROOT}/libexec"
fi
