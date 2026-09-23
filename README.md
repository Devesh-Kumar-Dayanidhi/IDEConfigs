## Installation — macOS

This configuration is intended for macOS.

### 1. Install Xcode Command Line Tools

macOS provides the core development tools required by Neovim and C/C++ development.

```bash
xcode-select --install
```

If the tools are already installed, macOS will notify you.

---

### 2. Install Homebrew

If Homebrew is not already installed, install it from:

https://brew.sh/

Then update Homebrew:

```bash
brew update
```

---

### 3. Install Dependencies

Install the tools used by this configuration:

```bash
brew install neovim ripgrep fd tree-sitter-cli
```

If you use CMake projects:

```bash
brew install cmake
```

#### Dependencies

| Package           | Purpose                                 |
| ----------------- | --------------------------------------- |
| `neovim`          | Neovim editor                           |
| `ripgrep`         | Fast project-wide search                |
| `fd`              | Fast file searching                     |
| `tree-sitter-cli` | Tree-sitter CLI used by nvim-treesitter |
| `cmake`           | CMake project support, if needed        |

---

### 4. Install vim-plug

This configuration uses vim-plug as its plugin manager.

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

### 5. Install Neovim Plugins

Start Neovim:

```bash
nvim
```

Then run:

```vim
:PlugInstall
```

Restart Neovim after the plugins finish installing.

---

### 6. Install Tree-sitter Parsers

Inside Neovim:

```vim
:TSInstall c cpp asm lua bash json yaml cmake make
```

---

### 7. Install Language Servers

Open Mason:

```vim
:Mason
```

Install the language servers you need, if they are not already installed, such as:

```text
clangd
lua_ls
bashls
jsonls
yamlls
cmake
```

---

## Quick Install

For a fresh macOS setup:

```bash
xcode-select --install

brew install neovim ripgrep fd tree-sitter-cli

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

For CMake projects:

```bash
brew install cmake
```

Then launch Neovim:

```bash
nvim
```

Run:

```vim
:PlugInstall
:TSInstall all
:Mason
```
