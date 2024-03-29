# luver

Version manager for Lua, built with :heart:

Luver supports:

- [Lua](https://github.com/lua/lua)
- [LuaJIT](https://github.com/LuaJIT/LuaJIT)
- [LuaRocks](https://github.com/luarocks/luarocks)
- [luvi](https://github.com/luvit/luvi)
- [luvit](https://github.com/luvit/luvit)
- [lit](https://github.com/luvit/lit)

## Installation

**Requirements**:

- Bash v4 or newer _(MacOS ships with older version by default)_.

### Git Clone

```sh
export LUVER_DIR="${HOME}/.local/share/luver"
mkdir -p "${LUVER_DIR}"
git clone https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
```

### Bash

#### Manual Installation

After doing [Git Clone](#git-clone), source the entrypoint:

```sh
source "${LUVER_DIR}/self/luver.bash"
```

or just put this in your `.bashrc` file:

```sh
export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"

if [[ ! -d "${LUVER_DIR}/self" ]]; then
  git clone --quiet https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
fi

source "${LUVER_DIR}/self/luver.bash"
```

#### Shell Completion

`luver` comes with shell completion script for Bash.

Make sure you have `"bash-completion"` package installed on your system.

To generate the shell completion script and store it, run:

```sh
luver completion bash | tee "${XDG_DATA_HOME:-"${HOME}/.local/share"}/bash-completion/completions/luver"
```

### Fish

#### Using Plugin Manger (recommended)

**Using [fisher](https://github.com/jorgebucaran/fisher)**:

```sh
fisher install MunifTanjim/luver
```

#### Shell Completion

`luver` comes with shell completion script for Fish.

If you installed it using _fisher_, you don't need to do anything else.

To generate the shell completion script and store it, run:

```sh
luver completion fish | tee $__fish_config_dir/completions/luver.fish
```

### Zsh

#### Using Plugin Manager (recommended)

**Using [zed](https://github.com/MunifTanjim/zed)**:

```sh
zed load github.com/MunifTanjim/luver
```

#### Manual Installation

After doing [Git Clone](#git-clone), source the entrypoint:

```sh
source "${LUVER_DIR}/self/luver.plugin.zsh"
```

or just put this in your `.zshrc` file:

```sh
export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"

if [[ ! -d "${LUVER_DIR}/self" ]]; then
  git clone --quiet https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
fi

source "${LUVER_DIR}/self/luver.plugin.zsh"
```

#### Shell Completion

`luver` comes with shell completion script for Zsh.

To generate the shell completion script `_luver`, run:

```sh
luver completion zsh > _luver
```

Then store the `_luver` file in one of the directories present in `$fpath` variable:

```sh
# print the list of fpath directories
echo ${(j.\n.)fpath}
```

## Command Usage

Run `luver help` to get started.

### Lua

**Install a Lua version**:

```sh
luver install lua 5.1.5
```

**Create a Lua version alias**:

```sh
luver alias 5.4.3 latest
# default version
luver alias 5.1.5 default
```

Lua version set to `default` alias is used automatically when you open a new shell.

**Use a specific Lua version (or alias)**:

```sh
# version
luver use 5.3.6

# alias
luver use latest
```

**Get currently used Lua version**:

```sh
luver current lua
```

**List currently installed Lua versions**:

```sh
luver list lua
```

**Uninstall a Lua version**:

```sh
luver uninstall lua 5.3.6
```

### LuaJIT

If your currently used Lua is at least `v5`, you can install LuaJIT alongside it:

```sh
# released version
luver install luajit 2.0.5

# latest git version
luver install luajit 2.1.0-git
```

The other commands are similar to Lua.

### LuaRocks

You can install LuaRocks for you currently used Lua version:

```sh
luver install luarocks 3.8.0
```

The other commands are similar to Lua.

## GitHub Action

You can also use Luver in GitHub Actions workflow!

Check: [MunifTanjim/luver-action](https://github.com/MunifTanjim/luver-action)

## License

Licensed under the MIT License. Check the [LICENSE](./LICENSE) file for details.
