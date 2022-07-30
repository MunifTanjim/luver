set -q XDG_DATA_HOME || set -l XDG_DATA_HOME $HOME/.local/share
set -q LUVER_DIR || set -gx LUVER_DIR $XDG_DATA_HOME/luver
set -q LUVER_SRC || set -gx LUVER_SRC $XDG_DATA_HOME/luver/self

set -gx LUVER_CURRENT_DIR (mktemp -u /tmp/luver_current_{$fish_pid}_(date +%s)_XXX)

set -gxp PATH $LUVER_CURRENT_DIR/bin $LUVER_SRC/bin

if test -d $LUVER_DIR/lua-aliases/default
  ln -s $LUVER_DIR/lua-aliases/default/installation $LUVER_CURRENT_DIR
end

function _luver_on_pull
  if test -d $LUVER_SRC
    git -C $LUVER_SRC pull --quiet https://github.com/MunifTanjim/luver.git
  else
    git clone --quiet --depth 1 https://github.com/MunifTanjim/luver.git $LUVER_SRC
  end

  for file in (echo $LUVER_SRC/completions/* | xargs -n1 basename | grep -v '.fish')
    rm -f $__fish_config_dir/completions/$file
  end
end

function _luver_on_install --on-event luver_install
  _luver_on_pull
end

function _luver_on_update --on-event luver_update
  _luver_on_pull
end
