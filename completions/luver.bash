_luver() {
  local i cur prev opts cmds
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  cmd=""
  opts=""

  function __luver_tools() {
    opts="$(luver help install | sed '1,/TOOLS:/d' | sed '/^$/,$d' | sed 's/^  //')"
    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
  }

  function __luver_install_versions() {
    local -r tool="${1}"

    # cache for 12 hours
    local -r cache_filename="/tmp/__luver_${tool}_versions.$(date +%Y-%m-%d-%p).cache.completion.bash"

    if ! test -f "${cache_filename}"; then
      luver list-remote "${tool}" > "${cache_filename}"
    fi

    COMPREPLY=( $(compgen -W "$(cat "${cache_filename}" | tac)" -- "${cur}" ) )
  }

  for i in ${COMP_WORDS[@]}; do
    case "${i}" in
      luver)
        cmd="luver"
        ;;

      alias|completion|current|help|install|list|list-remote|unalias|uninstall|use)
        cmd+="__${i}"
        ;;

      *)
        ;;
    esac
  done

  # echo "COMP_CWORD=${COMP_CWORD} | prev=${prev} | cur=${cur}"
  case "${cmd}" in
    luver)
      if [[ ${COMP_CWORD} -eq 1 ]] ; then
        opts="$(luver help help | sed '1,/COMMANDS:/d' | sed '/^$/,$d' | sed 's/^  //')"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi
      ;;

    luver__alias)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        opts="$(echo $LUVER_DIR/lua-versions/* | xargs -n1 basename)"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi

      COMPREPLY=()
      return 0
      ;;
    luver__completion)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        opts="$(luver help completion | sed '1,/SHELLS:/d' | sed '/^$/,$d' | sed 's/^  //')"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi
      ;;
    luver__current)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        __luver_tools
        return 0
      fi
      ;;
    luver__help)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        opts="$(luver help help | sed '1,/COMMANDS:/d' | sed '/^$/,$d' | sed 's/^  //')"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi
      ;;
    luver__install)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        __luver_tools
        return 0
      fi

      if [[ ${COMP_CWORD} -eq 3 ]] ; then
        case "${prev}" in
          lua|luajit|luarocks|luvi|luvit|lit)
            __luver_install_versions "${prev}"
            return 0
            ;;
        esac
      fi
      ;;
    luver__list|luver__list-remote)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        __luver_tools
        return 0
      fi
      ;;
    luver__unalias)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        opts="$(echo $LUVER_DIR/lua-aliases/* | xargs -n1 basename)"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi
      ;;
    luver__uninstall)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        __luver_tools
        return 0
      fi

      if [[ ${COMP_CWORD} -eq 3 ]] ; then
        case "${prev}" in
          lua)
            opts="$(echo $LUVER_DIR/lua-versions/* | xargs -n1 basename)"
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        esac
      fi
      ;;
    luver__use)
      if [[ ${COMP_CWORD} -eq 2 ]] ; then
        opts="$(echo $LUVER_DIR/lua-{aliases,versions}/* | xargs -n1 basename)"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
      fi
      ;;
  esac

  COMPREPLY=()
  return 0
}

complete -F _luver -o nosort luver
