# luver

Version manager for Lua, built with :heart:

Luver supports:

- [Lua](https://github.com/lua/lua)
- [LuaJIT](https://github.com/LuaJIT/LuaJIT)
- [LuaRocks](https://github.com/luarocks/luarocks)

## Installation

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

## License

Licensed under the MIT License. Check the [LICENSE](./LICENSE) file for details.
