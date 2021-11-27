#/usr/bin/env sh

run_test() {
  local test_runner="${1}"
  local test_file="${2}"
  local root_dir="$(git rev-parse --show-toplevel)"

  echo "running ${test_runner} ${test_file}"

  env -i \
    HOME="${root_dir}/tests/.temp/home" \
    ${test_runner} ${root_dir}/tests/${test_file}

  if test $? -ne 0; then
    echo "failed ${test_runner} ${test_file}"
    exit 1
  fi

  echo
}

run_test 'bash' entrypoint/bash.sh
