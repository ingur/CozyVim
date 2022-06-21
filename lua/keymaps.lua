local wk = require("which-key")

-- basic keybindings
wk.register({
    ["<C-s>"] = { "<cmd>w<cr>", "Save current file" },
    ["<C-c>"] = { "<cmd>q<cr>", "Quit" }
})

wk.register({
    ["<C-s>"] = { "<esc><cmd>w<cr>", "Save current file", mode = 'i' },
    ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit", mode = 'i' }
})

wk.register({
    ["<C-s>"] = { "<esc><cmd>w<cr>", "Save current file", mode = 'v' },
    ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit", mode = 'v' }
})

-- telescope keybindings
wk.register({
    ["<leader>f"] = { name = "+File" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["<leader>fb"] = { "<cmd>Telescope file_browser<cr>", "File Browser" },
    ["<leader>fp"] = { "<cmd>Telescope project<cr>", "Project Browser" },
})

-- move/indent lines with alt (normal mode)
wk.register({
    ["<A-j>"] = { "<cmd>m .+1<cr>==", "Move Line Down" },
    ["<A-k>"] = { "<cmd>m .-2<cr>==", "Move Line Up" },
    ["<A-h>"] = { "<<", "Move Left" },
    ["<A-l>"] = { ">>", "Move Right" },
})

-- move/indent lines with alt (insert mode)
wk.register({
    ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move Line Down", mode = 'i' },
    ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move Line Up", mode = 'i' },
    ["<A-h>"] = { "<Esc><<gi", "Move Left", mode = 'i' },
    ["<A-l>"] = { "<Esc>>>gi", "Move Right", mode = 'i' },
})

-- move/indent lines with alt (visual mode)
wk.register({
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move Selection Down", mode = 'v' },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move Selection Up", mode = 'v' },
    ["<A-h>"] = { "<<cr>gv", "Move Selection Left", mode = 'v' },
    ["<A-l>"] = { "><cr>gv", "Move Selection Right", mode = 'v' },
})

-- hop keybinds

wk.register({
    ["S"] = { ":HopWord<cr>", "Jump to desired word" },
    ["s"] = { ":HopChar2<cr>", "Jump to desired character" },
})


-- terminal keybinds
wk.register({
    ["<C-t>"] = { "Toggle Terminal" },
    ["<C-g>"] = { "<cmd>lua ToggleLazygit()<cr>", "Toggle Lazygit" },
})
