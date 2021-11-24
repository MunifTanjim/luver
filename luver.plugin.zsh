export LUVER_SRC="${0:A:h}"
export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"
export LUVER_CURRENT_DIR="$(mktemp --dry-run /tmp/luver_current_${$}_$(date +%s)_XXX)"
export PATH="${LUVER_CURRENT_DIR}/bin:${LUVER_SRC}/bin:${PATH}"

if test -d ${LUVER_DIR}/lua-aliases/default; then
  ln -s ${LUVER_DIR}/lua-aliases/default/installation ${LUVER_CURRENT_DIR}
fi

rehash
