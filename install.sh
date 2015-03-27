#!/bin/sh
# Usage: PREFIX=/usr/local ./install.sh
#
# Installs nodenv-npm-rehash under $PREFIX.

set -e

cd "$(dirname "$0")"

if [ -z "${PREFIX}" ]; then
  PREFIX="/usr/local"
fi

ETC_PATH="${PREFIX}/etc/nodenv.d"
LIBEXEC_PATH="${PREFIX}/libexec"

mkdir -p "$ETC_PATH"
mkdir -p "$LIBEXEC_PATH"

cp -RPp etc/nodenv.d/* "$ETC_PATH"
install -p libexec/* "$LIBEXEC_PATH"
