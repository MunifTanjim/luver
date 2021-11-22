function luver_get_lua_versions() {
  curl -fSsL https://www.lua.org/ftp | sed -n "s/.*>lua-\(.*\..*\).tar.gz<.*/\1/p" | sort
}

function luver_get_lua_archive_url() {
  local -r version="${1}"
  echo "https://www.lua.org/ftp/lua-${version}.tar.gz"
}

function luver_get_platform_target() {
  local -r os=$(uname -s)

  if [[ "${os}" = "Darwin" ]]; then
    echo "macosx"
  elif [[ "${os}" = "Linux" ]]; then
    echo "linux"
  fi
}

function luver_is_version_installed() {
  local -r version="${1}"
  test -d "${LUVER_DIR}/lua-versions/${version}"
}
