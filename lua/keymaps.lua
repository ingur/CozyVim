local wk = require("which-key")
local has_custom, custom = pcall(require, "custom")

-- basic keybindings
wk.register({
    ["<C-s>"] = { "<cmd>w<cr>", "Save Current File" },
    ["<C-c>"] = { "<cmd>q<cr>", "Quit" }
})

wk.register({
    ["<C-s>"] = { "<esc><cmd>w<cr>", "Save Current File", mode = 'i' },
    ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit", mode = 'i' }
})

wk.register({
    ["<C-s>"] = { "<esc><cmd>w<cr>", "Save Current File", mode = 'v' },
    ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit", mode = 'v' }
})

-- window management keybindings
wk.register({
    ["<C-h>"] = { "<C-w>h", "Move to Left Window" },
    ["<C-j>"] = { "<C-w>j", "Move to Bottom Window" },
    ["<C-k>"] = { "<C-w>k", "Move to Top Window" },
    ["<C-l>"] = { "<C-w>l", "Move to Right Window" },
    ["<C-Up>"] = { "<cmd>resize +2<cr>", "Resize Window Up" },
    ["<C-Down>"] = { "<cmd>resize -2<cr>", "Resize Window Down" },
    ["<C-Left>"] = { "<cmd>vertical resize +2<cr>", "Resize Window Left" },
    ["<C-Right>"] = { "<cmd>vertical resize -2<cr>", "Resize Window Right" },
})

-- lsp keybindings
wk.register({
    ["K"] = { function() vim.lsp.buf.hover() end, "Show Lsp Hover" },
    ["gD"] = { function() vim.lsp.buf.declaration() end, "Go to Lsp Declaration" },
    ["gd"] = { function() vim.lsp.buf.definition() end, "Go to Lsp Definition" },
    -- ["<C-k>"] = { function() vim.lsp.buf.signature_help() end, "Show Lsp Signature Help" },
    ["gi"] = { function() vim.lsp.buf.implementation() end, "Go to Lsp Implementation" },
    ["gr"] = { function() vim.lsp.buf.references() end, "Show Lsp References" },
    ["<leader>w"] = { name = "+Workspace" },
    ["<leader>wa"] = { function() vim.lsp.buf.add_workspace_folder() end, "Add Lsp Workspace Folder" },
    ["<leader>wr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove Lsp Workspace Folder" },
    ["<leader>wl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        "List Lsp Workspace Folders" },
    ["<leader>D"] = { function() vim.lsp.buf.type_definition() end, "Go to Lsp Type Definition" },
    ["<leader>r"] = { name = "+Rename" },
    ["<leader>rn"] = { function() vim.lsp.buf.rename() end, "Rename Lsp Symbol" },
    ["<leader>c"] = { name = "+Code" },
    ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "Code Action" },
    ["[d"] = { function() vim.diagnostic.goto_prev() end, "Go to Previous Lsp Diagnostic" },
    ["]d"] = { function() vim.diagnostic.goto_next() end, "Go to Next Lsp Diagnostic" },
    ["gp"] = { name = "+Goto Preview" },
    ["gpd"] = { function() require("goto-preview").goto_preview_definition() end, "Goto Preview Definition" },
    ["gpt"] = { function() require("goto-preview").goto_preview_type_definition() end, "Goto Preview Type Definition" },
    ["gpi"] = { function() require("goto-preview").goto_preview_implementation() end, "Goto Preview Implementation" },
    ["gpr"] = { function() require("goto-preview").goto_preview_references() end, "Goto Preview References" },
    ["gP"] = { function() require("goto-preview").close_all_win() end, "Close all Goto Preview Windows" },
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
    ["<C-g>"] = { function() ToggleLazygit() end, "Toggle Lazygit" },
})

-- barbar tab manager keybinds
wk.register({
    ["<C-p>"] = { "<cmd>BufferPick<cr>", "Magic Buffer-picking Mode" },

    ["<A-,>"] = { "<cmd>BufferPrevious<cr>", "Move to Previous Buffer" },
    ["<A-.>"] = { "<cmd>BufferNext<cr>", "Move to Next Buffer" },

    ["<A-<>"] = { "<cmd>BufferMovePrevious<cr>", "Re-order to Previous" },
    ["<A->>"] = { "<cmd>BufferMoveNext<cr>", "Re-order to Next" },

    ["<A-1>"] = { "<cmd>BufferGoto 1<cr>", "Jump to Buffer 1" },
    ["<A-2>"] = { "<cmd>BufferGoto 2<cr>", "Jump to Buffer 2" },
    ["<A-3>"] = { "<cmd>BufferGoto 3<cr>", "Jump to Buffer 3" },
    ["<A-4>"] = { "<cmd>BufferGoto 4<cr>", "Jump to Buffer 4" },
    ["<A-5>"] = { "<cmd>BufferGoto 5<cr>", "Jump to Buffer 5" },
    ["<A-6>"] = { "<cmd>BufferGoto 6<cr>", "Jump to Buffer 6" },
    ["<A-7>"] = { "<cmd>BufferGoto 7<cr>", "Jump to Buffer 7" },
    ["<A-8>"] = { "<cmd>BufferGoto 8<cr>", "Jump to Buffer 8" },
    ["<A-9>"] = { "<cmd>BufferGoto 9<cr>", "Jump to Buffer 9" },
    ["<A-0>"] = { "<cmd>BufferLast<cr>", "Jump to Last Buffer" },

    ["<A-p>"] = { "<cmd>BufferPin<cr>", "Pin Buffer" },
    ["<A-c>"] = { "<cmd>BufferClose<cr>", "Close Buffer" },

    ["<leader>b"] = { "+TabsOrder" },
    ["<leader>bb"] = { "<cmd>BufferOrderByBufferNumber<cr>", "Order By Buffer Number" },
    ["<leader>bd"] = { "<cmd>BufferOrderByDirectory<cr>", "Order By Directory" },
    ["<leader>bl"] = { "<cmd>BufferOrderByLanguage<cr>", "Order By Language" },
    ["<leader>bw"] = { "<cmd>BufferOrderByWindowNumber<cr>", "Order By Window Number" },
})

-- session manager keybinds
wk.register({
    ["<leader>s"] = { "+Sessions" },
    ["<leader>ss"] = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session for Current Directory" },
    ["<leader>sl"] = { [[<cmd>lua require("persistence").load({ last = true })<cr>]], "Restore Last Session" },
    ["<leader>sd"] = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Persistence => Don't Save Session on Exit" },
})

-- load custom keymaps
if has_custom and custom["keymaps"] then
    custom.keymaps(wk)
end
