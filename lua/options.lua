local opt = vim.opt
local g = vim.g

g.did_load_filetypes = 1 -- do not source default filetypes
g.mapleader = " " -- set leader key to space

opt.clipboard = "unnamedplus" -- allows system clipboard to be used
opt.cmdheight = 2 -- allows more spaced for neovim command line

opt.title = true -- enable window title
opt.cul = true -- enable cursor line

vim.opt.termguicolors = true -- enable terminal colors

-- indenting
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.hlsearch = false -- disables search highlights

opt.fillchars = { eob = " " } -- disables tilde on end of buffer

opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a" -- enables mouse support

opt.number = true -- enable line numbers
opt.rnu = true -- enable relative line numbers

opt.shortmess:append "sI" -- disable nvim intro

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
opt.whichwrap:append "<>[]hl"

opt.colorcolumn = "90" -- adds a ruler

opt.showmode = false -- status bar already shows mode

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- disable some builtin vim plugins
local default_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "python3_provider",
    "python_provider",
    "node_provider",
    "ruby_provider",
    "perl_provider",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(default_plugins) do
    g["loaded_" .. plugin] = 1
end

-- set shada path
vim.schedule(function()
    vim.opt.shadafile = vim.fn.expand "$HOME" .. "/.local/share/nvim/shada/main.shada"
    vim.cmd [[ silent! rsh ]]
end)
