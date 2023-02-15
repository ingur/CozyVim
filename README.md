# CozyVim

<p align="center">
  <img src="https://user-images.githubusercontent.com/45173070/212475520-0b73fb92-4f87-479d-8abf-a6f80f19b9d5.png" />
</p>

My personal, modern and easily extendable configuration for nvim. Basically my own more minimalistic take on LunarVim.

## Features

- Preconfigured base config for NeoVim
- Easily extendable and customizable
- Very fast lazy plugin loading using [lazy.nvim](https://github.com/folke/lazy.nvim)
- Multiple Treesitter supported Colorthemes preinstalled
- Default configs for LSP, linting, formatting, autocompletions, integrated terminals and more

## Requirements

- Neovim >= 0.8.0
- `git`, `make`, `pip`, `python`, `npm`, `node`, `cargo`
- `tree-sitter` (`cargo install tree-sitter-cli`)
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
> NOTE: missing dependencies/plugins are mostly installed automatically, in case something does not work immediately, you might need to restart Neovim a couple of times

- Be sure to run `:checkhealth` whenever you get stuck
- If you ever run into other errors, you can always reset CozyVim like so:
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim/lazy ~/.config/nvim/lazy-lock.json
```

## TODO
- Document default keymappings here
- Document customization options here
