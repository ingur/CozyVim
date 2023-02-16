# CozyVim

<p align="center">
  <img src="https://user-images.githubusercontent.com/45173070/219077440-6572a179-5a81-4ecd-b205-d42d91f3e8d1.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/45173070/219077688-9d3d252a-8961-4c86-8b8c-bd815e25c5d2.png" />
</p>

My personal, modern and easily extendable configuration for nvim. Basically my own minimalistic take on LunarVim/LazyVim.

## Features

- Preconfigured base config for NeoVim
- Easily extendable and customizable
- Very fast lazy plugin loading using [lazy.nvim](https://github.com/folke/lazy.nvim)
- Multiple Treesitter supported Colorthemes preinstalled
- Default configs for LSP, linting, formatting, autocompletions, integrated terminals and more

## Requirements

- Neovim >= 0.8.0
- `git`, `make`, `pip`, `python`, `npm`, `node`, `cargo`
- `tree-sitter` (optional) (`cargo install tree-sitter-cli`)
- `lazygit` (recommended)

## Getting Started

- Make a backup of your existing config if it exists:
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```
- CozyVim can be installed like so:
```bash
git clone https://github.com/ingur/CozyVim ~/.config/nvim && nvim
```
> NOTE: missing dependencies/plugins are mostly installed automatically, in case something does not work immediately, you might need to restart Neovim

- Be sure to run `:checkhealth` whenever you get stuck
- If you ever run into other errors, you can always reset CozyVim like so:
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim/lazy ~/.config/nvim/lua/custom/lazy-lock.json
```

## TODO
- Document default keymappings here
- Document customization options here
