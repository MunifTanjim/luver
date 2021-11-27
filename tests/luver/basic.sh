#/usr/bin/env bash

set -euo pipefail

cleanup() {
  rm -rf ${LUVER_DIR}/lua-aliases
  rm -rf ${LUVER_DIR}/lua-versions
}

should_pass() {
  local -r cmd="${1}"
  local code output

  echo "should pass: ${cmd}"

  set +e
  output=$(eval "${cmd}" >/dev/stdout 2>&1)
  code=$?
  set -e

  if test $code -ne 0; then
    echo "${output}"
    exit 1
  fi
}

should_fail() {
  local -r cmd="${1}"
  local code output

  echo "should fail: ${cmd}"

  set +e
  output=$(eval "${cmd}" >/dev/stdout 2>&1)
  code=$?
  set -e

  if test $code -eq 0; then
    echo "${output}"
    exit 1
  fi
}


declare root_dir="$(git rev-parse --show-toplevel)"
source ${root_dir}/luver.bash

cleanup

should_fail 'luver current lua'

should_pass 'luver install lua 5.3.0'

should_pass 'luver use 5.3.0'
should_pass 'test "$(luver current lua)" = "5.3.0"'

should_pass 'luver install luajit 2.1.0-git'
should_pass 'test "$(luver current luajit)" = "2.1.0-git"'

should_pass 'luver alias 5.3.0 default'

should_pass 'luver install lua 4.0.1'

should_pass 'luver use 4.0.1'
should_pass 'test "$(luver current lua)" = "4.0.1"'

should_fail 'luver install luajit 2.1.0-beta3'

should_pass 'luver use default'
should_pass 'test "$(luver current lua)" = "5.3.0"'

should_pass 'luver install luarocks 3.8.0'
should_pass 'test "$(luver current luarocks)" = "3.8.0"'

should_pass 'luver use 4.0.1'
should_pass 'test "$(luver current lua)" = "4.0.1"'

should_fail 'luver current luajit'
should_fail 'luver current luarocks'
