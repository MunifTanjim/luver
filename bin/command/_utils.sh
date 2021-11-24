function luver_get_lua_versions() {
  curl -fSsL https://www.lua.org/ftp | sed -n "s/.*>lua-\(.*\..*\).tar.gz<.*/\1/p" | sort
}
