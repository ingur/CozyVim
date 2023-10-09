local opt = vim.opt

opt.autowrite = true            -- enable auto write
opt.clipboard = "unnamedplus"   -- sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3            -- hide * markup for bold and italic
opt.confirm = true              -- confirm to save changes before exiting modified buffer
opt.cursorline = false          -- disables highlighting of the current line
opt.expandtab = true            -- use spaces instead of tabs
opt.formatoptions = "jcroqlnt"  -- tcqj
opt.fillchars = { eob = " " }   -- disables tilde on end of buffer
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true       -- ignore case
opt.inccommand = "nosplit"  -- preview incremental substitute
opt.laststatus = 0
opt.list = true             -- show some invisible characters (tabs etc.)
opt.mouse = "a"             -- enable mouse mode
opt.number = true           -- print line number
opt.pumblend = 10           -- popup blend
opt.pumheight = 10          -- maximum number of entries in a popup
opt.relativenumber = true   -- relative line numbers
opt.scrolloff = 4           -- lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true       -- round indent
opt.shiftwidth = 2          -- size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false        -- dont show mode since we have a statusline
opt.sidescrolloff = 8       -- columns of context
opt.signcolumn = "yes"      -- always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true        -- don't ignore case with capitals
opt.smartindent = true      -- insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true       -- put new windows below current
opt.splitright = true       -- put new windows right of current
opt.tabstop = 2             -- number of spaces tabs count for
opt.termguicolors = true    -- true color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200                -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full"  -- command-line completion mode
opt.winminwidth = 5                 -- minimum window width
opt.wrap = false                    -- disable line wrap

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.maplocalleader = " "
vim.g.mapleader = " "
