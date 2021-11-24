function luver_get_lua_versions() {
  curl -fSsL https://www.lua.org/ftp | sed -n "s/.*>lua-\(.*\..*\).tar.gz<.*/\1/p" | sort
}

function luver_is_version_installed() {
  local -r version="${1}"
  test -d "${LUVER_DIR}/lua-versions/${version}"
}

function luver_list_version() {
  if test -d "${LUVER_DIR}/lua-versions"; then
    local version_dir version

    for version_dir in ${LUVER_DIR}/lua-versions/*; do
      version="$(basename "${version_dir}")"

      if test "${version}" = "*"; then
        continue
      fi
      
      echo "${version}"
    done
  fi
}

function luver_list_aliasmap() {
  if test -d "${LUVER_DIR}/aliases"; then
    local alias_dir alias version

    for alias_dir in ${LUVER_DIR}/aliases/*; do
      alias="$(basename "${alias_dir}")"

      if test "${alias}" = "*"; then
        continue
      fi

      version="$(basename $(realpath "${alias_dir}"))"

      echo "${alias}:${version}"
    done
  fi
}
