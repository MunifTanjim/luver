function __luver_arguments_match
  set -l cmd (commandline -co)
  set -e cmd[1]

  if test (count $cmd) -eq 0
    return 1
  end

  if string match $argv (string join ' ' $cmd)
    return 0
  end

  return 1
end

set -l match __luver_arguments_match

function __luver_install_versions
  set -l tool $argv[1]

  # cache for 12 hours
  set -l cache_filename (printf '/tmp/__luver_%s_versions.%s.cache.completion.fish' $tool (date +%Y-%m-%d-%p))

  if ! test -f $cache_filename
    luver list-remote $tool > $cache_filename
  end

  cat $cache_filename | tac
end

set -l commands (luver help help | sed '1,/COMMANDS:/d' | sed '/^$/,$d' | sed 's/^  //')
set -l tools (luver help install | sed '1,/TOOLS:/d' | sed '/^$/,$d' | sed 's/^  //')
set -l shells (luver help completion | sed '1,/SHELLS:/d' | sed '/^$/,$d' | sed 's/^  //')

set -l commands_condition (printf "not %s -r '(%s)'" $match (string join '|' (string trim $commands)))

for command_desc in (luver help | sed '1,/COMMANDS:/d' | sed '/^$/,$d' | sed 's/^  //' | sed 's/^\([^ ]*\) */\1:/g')
  complete -c luver -n $commands_condition -f -a (string split -m2 : "$command_desc")[1] -d (string split -m2 : "$command_desc")[2]
end

complete -c luver -n "$match 'alias'" -x -a "(echo $LUVER_DIR/lua-versions/* | xargs -n1 basename)"
complete -c luver -n "$match -r 'alias .+'" -f

complete -c luver -n "$match 'completion'" -x -a (string join ' ' $shells)
complete -c luver -n "$match -r 'completion .+'" -f

complete -c luver -n "$match 'current'" -x -a (string join ' ' $tools)
complete -c luver -n "$match -r 'current .+'" -f

complete -c luver -n "$match 'help'" -x -a (string join ' ' $commands)
complete -c luver -n "$match -r 'help .+'" -f

complete -c luver -n "$match 'install'" -x -a (string join ' ' $tools)
complete -c luver -n "$match 'install lua'" -f -k -a "(__luver_install_versions lua)"
complete -c luver -n "$match 'install luajit'" -f -k -a "(__luver_install_versions luajit)"
complete -c luver -n "$match 'install luarocks'" -f -k -a "(__luver_install_versions luarocks)"
complete -c luver -n "$match 'install luvi'" -f -k -a "(__luver_install_versions luvi)"
complete -c luver -n "$match 'install luvit'" -f -k -a "(__luver_install_versions luvit)"
complete -c luver -n "$match 'install lit'" -f -k -a "(__luver_install_versions lit)"
complete -c luver -n "$match -r 'install .+ .+'" -f

complete -c luver -n "$match 'list'" -x -a (string join ' ' $tools)
complete -c luver -n "$match -r 'list .+'" -f

complete -c luver -n "$match 'list-remote'" -x -a (string join ' ' $tools)
complete -c luver -n "$match -r 'list-remote .+'" -f

complete -c luver -n "$match 'unalias'" -x -a "(echo $LUVER_DIR/lua-aliases/* | xargs -n1 basename)"
complete -c luver -n "$match -r 'unalias .+'" -f

complete -c luver -n "__luver_arguments_match 'uninstall'" -x -a (string join ' ' $tools)
complete -c luver -n "__luver_arguments_match 'uninstall lua'" -x -a "(echo $LUVER_DIR/lua-versions/* | xargs -n1 basename)"
complete -c luver -n "__luver_arguments_match -r 'uninstall lua(jit|rocks)'" -f
complete -c luver -n "__luver_arguments_match -r 'uninstall l(uvi|uvit|it)'" -f

complete -c luver -n "$match 'use'" -x -a "(echo $LUVER_DIR/lua-{aliases,versions}/* | xargs -n1 basename)"
complete -c luver -n "$match -r 'use .+'" -f
