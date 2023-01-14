local opt = vim.opt
local g = vim.g

g.mapleader = " " -- set leader key to space

opt.clipboard = "unnamedplus" -- allows system clipboard to be used
opt.cmdheight = 2 -- allows more spaced for neovim command line

opt.title = true -- enable window title
opt.cul = true -- enable cursor line

opt.termguicolors = true -- enable terminal colors

-- indenting
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.hlsearch = false -- disables search highlights

opt.fillchars = { eob = " " } -- disables tilde on end of buffer

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- don't ignore case with capitals
opt.mouse = "a" -- enables mouse support

opt.number = true -- enable line numbers
opt.rnu = true -- enable relative line numbers

opt.shortmess:append({ s = true, I = true }) -- disable nvim intro

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true

opt.timeoutlen = 400 -- timeout for which-key popups
opt.undofile = true -- static undo buffer

-- small optimizations
opt.shadafile = "NONE"
opt.shadafile = ""
opt.lazyredraw = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- opt.colorcolumn = "90" -- adds a ruler

opt.showmode = false -- status bar already shows mode

opt.completeopt = { "menu", "menuone", "noselect" }

opt.scrolloff = 8 -- keeps cursor in the middle of the screen
opt.sidescrolloff = 8

opt.title = true
opt.titlestring = "CozyVim - %f"

-- set shada path
vim.schedule(function()
	vim.opt.shadafile = vim.fn.expand("$HOME") .. "/.local/share/nvim/shada/main.shada"
	vim.cmd([[ silent! rsh ]])
end)
