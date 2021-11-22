# luver

Version manage for Lua with :heart:


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

## License

Licensed under the MIT License. Check the [LICENSE](./LICENSE) file for details.
