LUVER_SRC="$(realpath "${BASH_SOURCE[0]}")"
LUVER_SRC="${LUVER_SRC%/*}"

export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"
export LUVER_MULTISHELL_PATH="$(mktemp --dry-run /tmp/luver_multishells/${$}_$(date +%s%3N)_XXXXXXX)"
export PATH="${LUVER_MULTISHELL_PATH}/bin:${LUVER_SRC}/bin:${PATH}"

if ! test -d /tmp/luver_multishells; then
  mkdir /tmp/luver_multishells
fi

if test -d ${LUVER_DIR}/aliases/default; then
  ln -s ${LUVER_DIR}/aliases/default/installation ${LUVER_MULTISHELL_PATH}
fi

export LUVER_SRC

hash -r
