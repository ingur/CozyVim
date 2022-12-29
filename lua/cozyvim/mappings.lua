local wk = require("which-key")

local mappings = cozyvim.keys

local mode_adapters = {
    insert_mode = "i",
    normal_mode = "n",
    term_mode = "t",
    visual_mode = "v",
    visual_block_mode = "x",
    command_mode = "c",
    operator_pending_mode = "o",
}

local defaults = {
    insert_mode = {
        -- save/quit with ctrl
        ["<C-s>"] = { "<esc><cmd>w<cr>", "Save Current File" },
        ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit" },

        -- move/indent lines with alt
        ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Move Line Down" },
        ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Move Line Up" },
        ["<A-h>"] = { "<Esc><<gi", "Move Left" },
        ["<A-l>"] = { "<Esc>>>gi", "Move Right" },
    },
    normal_mode = {
        -- save/quit with ctrl
        ["<C-s>"] = { "<cmd>w<cr>", "Save Current File" },
        ["<C-c>"] = { "<cmd>q<cr>", "Quit" },

        -- move/indent lines with alt
        ["<A-j>"] = { "<cmd>m .+1<cr>==", "Move Line Down" },
        ["<A-k>"] = { "<cmd>m .-2<cr>==", "Move Line Up" },
        ["<A-h>"] = { "<<", "Move Left" },
        ["<A-l>"] = { ">>", "Move Right" },

        -- window keybindings
        ["<C-h>"] = { "<C-w>h", "Move to Left Window" },
        ["<C-j>"] = { "<C-w>j", "Move to Bottom Window" },
        ["<C-k>"] = { "<C-w>k", "Move to Top Window" },
        ["<C-l>"] = { "<C-w>l", "Move to Right Window" },
        ["<C-Up>"] = { "<cmd>resize -2<cr>", "Resize Window Up" },
        ["<C-Down>"] = { "<cmd>resize +2<cr>", "Resize Window Down" },
        ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Resize Window Left" },
        ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Resize Window Right" },

        -- lsp keybindings
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

        -- telescope keybindings
        ["<leader>f"] = { name = "+File" },
        ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
        ["<leader>fb"] = { "<cmd>Telescope file_browser<cr>", "File Browser" },
        ["<leader>fp"] = { "<cmd>Telescope project<cr>", "Project Browser" },

        -- hop keybindings
        ["S"] = { ":HopWord<cr>", "Jump to desired word" },
        ["s"] = { ":HopChar2<cr>", "Jump to desired character" },

        -- todo-comments keybindings
        ["]t"] = { function() require("todo-comments").jump_next() end, "Next Todo Comment" },
        ["[t"] = { function() require("todo-comments").jump_prev() end, "Previous Todo Comment" },

        -- toggleterm keybindings
        ["<C-t>"] = { "Toggle Terminal" },
        ["<C-g>"] = { function() ToggleLazygit() end, "Toggle Lazygit" },
        ["<leader>t"] = { name = "+ToggleTerm" },
        ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<cr>", "Toggle Terminal Vertical" },
        ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle Terminal horizontal" },

        -- bufferline tab manager keybindings
        ["<C-p>"] = { "<cmd>BufferLinePick<cr>", "Magic Buffer-picking Mode" },
        ["<A-,>"] = { "<cmd>BufferLineCyclePrev<cr>", "Move to Previous Buffer" },
        ["<A-.>"] = { "<cmd>BufferLineCycleNext<cr>", "Move to Next Buffer" },
        ["<A-<>"] = { "<cmd>BufferLineMovePrev<cr>", "Re-order to Previous" },
        ["<A->>"] = { "<cmd>BufferLineMoveNext<cr>", "Re-order to Next" },
        ["<A-1>"] = { "<cmd>BufferLineGotoBuffer 1<cr>", "Jump to Buffer 1" },
        ["<A-2>"] = { "<cmd>BufferLineGotoBuffer 2<cr>", "Jump to Buffer 2" },
        ["<A-3>"] = { "<cmd>BufferLineGotoBuffer 3<cr>", "Jump to Buffer 3" },
        ["<A-4>"] = { "<cmd>BufferLineGotoBuffer 4<cr>", "Jump to Buffer 4" },
        ["<A-5>"] = { "<cmd>BufferLineGotoBuffer 5<cr>", "Jump to Buffer 5" },
        ["<A-6>"] = { "<cmd>BufferLineGotoBuffer 6<cr>", "Jump to Buffer 6" },
        ["<A-7>"] = { "<cmd>BufferLineGotoBuffer 7<cr>", "Jump to Buffer 7" },
        ["<A-8>"] = { "<cmd>BufferLineGotoBuffer 8<cr>", "Jump to Buffer 8" },
        ["<A-9>"] = { "<cmd>BufferLineGotoBuffer 9<cr>", "Jump to Buffer 9" },
        ["<A-0>"] = { "<cmd>BufferLineGotoBuffer -1<cr>", "Jump to Last Buffer" },
        ["<A-p>"] = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin Buffer" },
        ["<A-c>l"] = { "<cmd>BufferLineCloseLeft<cr>", "Close Buffers to the Left" },
        ["<A-c>r"] = { "<cmd>BufferLineCloseRight<cr>", "Close Buffers to the Right" },
        ["<leader>b"] = { "+SortTabs" },
        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", "Sort By Tabs" },
        ["<leader>bd"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort By Directory" },
        ["<leader>be"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort By Extension" },
        ["<leader>br"] = { "<cmd>BufferLineSortByRelativeDirectory<cr>", "Sort By Relative Directory" },

        -- session management keybindings
        ["<leader>s"] = { "+Sessions" },
        ["<leader>ss"] = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session for Current Directory" },
        ["<leader>sl"] = { [[<cmd>lua require("persistence").load({ last = true })<cr>]], "Restore Last Session" },
        ["<leader>sd"] = { [[<cmd>lua require("persistence").stop()<cr>]],
            "Stop Persistence => Don't Save Session on Exit" },


        -- plugin manager keybindings
        ["<leader>l"] = { "<cmd>Lazy<cr>", "Manage Plugins", },
    },
    visual_mode = {
        -- save/quit with ctrl
        ["<C-s>"] = { "<esc><cmd>w<cr>", "Save Current File" },
        ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit" },

        -- move selected lines with alt
        ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move Selection Down" },
        ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move Selection Up" },
        ["<A-h>"] = { "<<cr>gv", "Move Selection Left" },
        ["<A-l>"] = { "><cr>gv", "Move Selection Right" },
    },
    term_mode = {
        -- normal mode shortcut
        ["<esc>"] = { [[<C-\><C-n>]], "Normal Mode" },

        -- window keybindings
        ["<C-j>"] = { [[<C-\><C-n><C-w>j]], "Move to Left Window" },
        ["<C-k>"] = { [[<C-\><C-n><C-w>k]], "Move to Bottom Window" },
        ["<C-h>"] = { [[<C-\><C-n><C-w>h]], "Move to Top Window" },
        ["<C-l>"] = { [[<C-\><C-n><C-w>l]], "Move to Right Window" },
        ["<C-Up>"] = { [[<C-\><C-n><cmd>resize -2<cr>i]], "Resize Window Up" },
        ["<C-Down>"] = { [[<C-\><C-n><cmd>resize +2<cr>i]], "Resize Window Down" },
        ["<C-Left>"] = { [[<C-\><C-n><cmd>vertical resize -2<cr>i]], "Resize Window Left" },
        ["<C-Right>"] = { [[<C-\><C-n><cmd>vertical resize +2<cr>i]], "Resize Window Right" },
    }
}

-- override default keybindings with custom mappings
mappings = vim.tbl_deep_extend("force", defaults, mappings)

for mode, keys in pairs(mappings) do
    local mode_adapter = mode_adapters[mode]
    wk.register(keys, { mode = mode_adapter })
end
