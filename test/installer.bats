#!/usr/bin/env bats

load test_helper

@test "installs nodenv-npm-rehash into PREFIX" {
  cd "$TMP"
  PREFIX="${PWD}/usr" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  cd usr

  assert [ -x libexec/npm ]
  assert [ -f etc/nodenv.d/exec/npm.bash ]
}

@test "overwrites old installation" {
  cd "$TMP"
  mkdir -p libexec
  touch libexec/npm

  PREFIX="$PWD" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  assert [ -x libexec/npm ]
  run grep "nodenv-rehash" libexec/npm
  assert_success
}

@test "unrelated files are untouched" {
  cd "$TMP"
  mkdir -p libexec share/bananas
  chmod g-w libexec
  touch libexec/bananas

  PREFIX="$PWD" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  assert [ -e libexec/bananas ]

  run ls -ld libexec
  assert_equal "r-x" "${output:4:3}"
}
