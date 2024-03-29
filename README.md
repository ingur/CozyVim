# CozyVim

<p align="center">
  <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/45173070/273734086-771e98dc-0a30-419d-be97-af587ce28ef1.png"/>
</p>
<p align="center">
  <img src="https://github-production-user-asset-6210df.s3.amazonaws.com/45173070/273744812-291c6b8a-b7a0-449e-a860-93fd5f52950b.png"/>
</p>

My personal, modern and cozy configuration for NeoVim. The `main` branch is currently optimized for my personal use, but will rework it
for easy extendability/customizability when I finish reimplementing the final missing features.

## Features

- Preconfigured base config for NeoVim
- Able to automatically keep itself up to date
- Very fast lazy plugin loading using [lazy.nvim](https://github.com/folke/lazy.nvim)
- Default configs for LSP, linting, formatting, autocompletions, integrated terminals and more

## Requirements

- Neovim >= 0.9.0
- `git`, `make`, `pip`, `python`, `npm`, `node`, `cargo`, `sshfs (optional)`
- [lazygit](https://github.com/jesseduffield/lazygit) (hightly recommended)
- a [Nerd Font](https://www.nerdfonts.com/) (highly recommended)
- [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd) for telescope (recommended)
- a terminal with true color and _undercurl_ support:
  - [kitty](https://github.com/kovidgoyal/kitty) **_(Linux & Macos)_**
  - [wezterm](https://github.com/wez/wezterm) **_(Linux, Macos & Windows)_**
  - [alacritty](https://github.com/alacritty/alacritty) **_(Linux, Macos & Windows)_**
  - [iterm2](https://iterm2.com/) **_(Macos)_**

## Getting Started

- Make a backup of your existing config (if it exists):
```bash
# required
mv ~/.config/nvim ~/.config/nvim.bak

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```
- CozyVim can be now be installed like so:
```bash
git clone --depth 1 https://github.com/ingur/CozyVim ~/.config/nvim && nvim
```
> NOTE: missing dependencies/plugins are mostly installed automatically, in case something does not work immediately, you might need to restart Neovim

- Be sure to run `:checkhealth` whenever you get stuck
- If you ever run into other errors, you can always reset CozyVim like so:
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim/lazy ~/.config/nvim/lua/custom/lazy-lock.json
```

## TODO
- Documentation
