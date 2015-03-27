#!/usr/bin/env bats

load test_helper

setup() {
  export NODENV_NPM_REHASH_ROOT="$(abs_dirname "${BATS_TEST_DIRNAME}/../..")"
  stub nodenv-which "npm : echo \"${TMP}/bin/npm\"" \
                   "npm : echo \"${TMP}/bin/npm\""
}

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

@test "should not invoke rehash after npm list" {
  stub npm "echo \"npm \$@\""

  run nodenv-exec npm list

  unstub npm

  assert_success
  assert_output <<EOS
NODENV_BIN_PATH=${NODENV_NPM_REHASH_ROOT}/libexec exec -a npm ${NODENV_NPM_REHASH_ROOT}/libexec/npm list
npm list
EOS
}

@test "should invoke rehash after successful npm install" {
  stub nodenv-rehash "echo rehashed"
  stub npm "echo \"npm \$@\""

  run nodenv-exec npm install -g jshint

  unstub nodenv-rehash
  unstub npm

  assert_success
  assert_output <<EOS
NODENV_BIN_PATH=${NODENV_NPM_REHASH_ROOT}/libexec exec -a npm ${NODENV_NPM_REHASH_ROOT}/libexec/npm install -g jshint
npm install -g jshint
rehashed
EOS
}

@test "should not invoke rehash after unsuccessful npm install" {
  stub npm "echo \"npm \$@\"; false"

  run nodenv-exec npm install -g jshint

  unstub npm

  assert_failure
  assert_output <<EOS
NODENV_BIN_PATH=${NODENV_NPM_REHASH_ROOT}/libexec exec -a npm ${NODENV_NPM_REHASH_ROOT}/libexec/npm install -g jshint
npm install -g jshint
EOS
}

@test "should invoke rehash after successful npm uninstall" {
  stub nodenv-rehash "echo rehashed"
  stub npm "echo \"npm \$@\""

  run nodenv-exec npm uninstall -g jshint

  unstub nodenv-rehash
  unstub npm

  assert_success
  assert_output <<EOS
NODENV_BIN_PATH=${NODENV_NPM_REHASH_ROOT}/libexec exec -a npm ${NODENV_NPM_REHASH_ROOT}/libexec/npm uninstall -g jshint
npm uninstall -g jshint
rehashed
EOS
}

@test "should not invoke rehash after unsuccessful npm uninstall" {
  stub npm "echo \"npm \$@\"; false"

  run nodenv-exec npm uninstall -g jshint

  unstub npm

  assert_failure
  assert_output <<EOS
NODENV_BIN_PATH=${NODENV_NPM_REHASH_ROOT}/libexec exec -a npm ${NODENV_NPM_REHASH_ROOT}/libexec/npm uninstall -g jshint
npm uninstall -g jshint
EOS
}
