#!/usr/bin/env zsh

setopt ERR_EXIT
setopt ERR_RETURN
setopt PIPE_FAIL

declare root_dir="$(git rev-parse --show-toplevel)"
source ${root_dir}/luver.plugin.zsh

echo "should set LUVER_SRC"
test -n "${LUVER_SRC}"

echo "should set LUVER_SRC to repository root"
test "${LUVER_SRC}" = "${root_dir}"

echo "should set LUVER_DIR"
test -n "${LUVER_DIR}"

echo "should set LUVER_CURRENT_DIR"
test -n "${LUVER_CURRENT_DIR}"

echo "should include current pid in LUVER_CURRENT_DIR"
echo "${LUVER_CURRENT_DIR}" | grep -q ${$}

echo "should add LUVER_CURRENT_DIR/bin to PATH"
echo "${PATH}" | tr ':' '\n' | grep -q "${LUVER_CURRENT_DIR}/bin"

echo "should make luver command available"
type luver >/dev/null
