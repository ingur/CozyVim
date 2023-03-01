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

local lsp_document_symbols = {
    "Class",
    "Function",
    "Method",
    "Constructor",
    "Interface",
    "Module",
    "Struct",
    "Trait",
    "Field",
    "Property",
}

local defaults = {
    insert_mode = {
        ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit" },
        ["<esc>"] = { "<cmd>noh<cr><esc>", "Escape and clear hlsearch" },
        ["<C-t>"] = { cozyvim.utils.toggle.terminal, "Toggle Terminal" },
    },
    normal_mode = {
        ["<C-c>"] = { "<cmd>q<cr>", "Quit" },
        ["<esc>"] = { "<cmd>noh<cr><esc>", "Escape and clear hlsearch" },

        -- telescope keybindings
        ["<leader>f"] = { name = "+Find" },
        ["<leader>/"] = { cozyvim.utils.telescope("live_grep"), "Find in Files (Grep)" },
        ["<leader>:"] = { "<cmd>Telescope command_history<cr>", "Command History" },
        ["<leader>ff"] = { cozyvim.utils.telescope("files"), "Find Files" },
        ["<leader>fg"] = { cozyvim.utils.telescope("live_grep"), "Grep" },
        ["<leader>fb"] = { "<cmd>Telescope file_browser<cr>", "File Browser" },
        ["<leader>fp"] = { "<cmd>Telescope project<cr>", "Project Browser" },
        ["<leader>s"] = { name = "+Search" },
        ["<leader>sa"] = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
        ["<leader>sb"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
        ["<leader>sc"] = { "<cmd>Telescope command_history<cr>", "Command History" },
        ["<leader>sC"] = { "<cmd>Telescope commands<cr>", "Commands" },
        ["<leader>sd"] = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        ["<leader>sg"] = { cozyvim.utils.telescope("live_grep"), "Grep" },
        ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
        ["<leader>sH"] = { "<cmd>Telescope highlights<cr>", "Search Highlight Groups" },
        ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
        ["<leader>sM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        ["<leader>sm"] = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
        ["<leader>so"] = { "<cmd>Telescope vim_options<cr>", "Options" },
        ["<leader>sR"] = { "<cmd>Telescope resume<cr>", "Resume" },
        ["<leader>sw"] = { cozyvim.utils.telescope("grep_string"), "Grep Word" },
        ["<leader>ss"] = { cozyvim.utils.telescope("lsp_document_symbols", { symbols = lsp_document_symbols }), "Goto Symbol" },

        -- plugin manager keybindings
        ["<leader>l"] = { "<cmd>Lazy<cr>", "Manage Plugins" },

        -- dashboard keybindings
        ["<leader>;"] = { "<cmd>Alpha<cr>", "Open Dashboard" },

        -- custom settings keybindings
        ["<leader>x"] = { cozyvim.utils.open_config, "Edit CozyVim Config" },

        -- hop keybindings
        ["S"] = { ":HopWordMW<cr>", "Jump to desired word" },
        ["s"] = { ":HopChar2MW<cr>", "Jump to desired 2 characters" },

        -- todo-comments keybindings
        ["]t"] = { function() require("todo-comments").jump_next() end, "Next Todo Comment", },
        ["[t"] = { function() require("todo-comments").jump_prev() end, "Previous Todo Comment", },

        -- gitsigns keybindings
        -- see plugin config for all mappings assigned on_attach
        ["<leader>g"] = { name = "+Git" },
        ["<leader>gs"] = { name = "+GitSigns" },

        -- mini.surround keybindings
        -- see plugin config for all default mappings
        ["gs"] = { name = "+Surround" },

        -- session management keybindings
        ["<leader>q"] = { name = "+Quit/Sessions" },
        ["<leader>qq"] = { "<cmd>qa<cr>", "Quit All" },
        ["<leader>qs"] = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session for Current Directory" },
        ["<leader>ql"] = { [[<cmd>lua require("persistence").load({ last = true })<cr>]], "Restore Last Session" },
        ["<leader>qd"] = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Persistence => Don't Save Session on Exit", },

        -- window management keybindings
        ["<leader>w"] = { name = "+Window" },
        ["<leader>ww"] = { "<C-W>p", "Other Window" },
        ["<leader>wd"] = { "<C-W>c", "Delete Window" },
        ["<leader>w-"] = { "<C-W>s", "Split Window Below" },
        ["<leader>w|"] = { "<C-W>v", "Split Window Right" },
        ["<leader>-"] = { "<C-W>s", "Split Window Below" },
        ["<leader>|"] = { "<C-W>v", "Split Window Right" },

        -- tab management keybindings
        ["<leader><tab>"] = { name = "+Tab" },
        ["<leader><tab>l"] = { "<cmd>tablast<cr>", "Last Tab" },
        ["<leader><tab>f"] = { "<cmd>tabfirst<cr>", "First Tab" },
        ["<leader><tab><tab>"] = { "<cmd>tabnew<cr>", "New Tab" },
        ["<leader><tab>]"] = { "<cmd>tabnext<cr>", "Next Tab" },
        ["<leader><tab>d"] = { "<cmd>tabclose<cr>", "Close Tab" },
        ["<leader><tab>["] = { "<cmd>tabprevious<cr>", "Previous Tab" },

        -- bufferline tab manager keybindings
        ["<C-p>"] = { "<cmd>BufferLinePick<cr>", "Magic Buffer-picking Mode" },
        ["<A-,>"] = { "<cmd>BufferLineCyclePrev<cr>", "Move to Previous Buffer" },
        ["<A-.>"] = { "<cmd>BufferLineCycleNext<cr>", "Move to Next Buffer" },
        ["<A-<>"] = { "<cmd>BufferLineMovePrev<cr>", "Re-order to Previous" },
        ["<A->>"] = { "<cmd>BufferLineMoveNext<cr>", "Re-order to Next" },
        ["<A-1>"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Jump to Buffer 1" },
        ["<A-2>"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Jump to Buffer 2" },
        ["<A-3>"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Jump to Buffer 3" },
        ["<A-4>"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Jump to Buffer 4" },
        ["<A-5>"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Jump to Buffer 5" },
        ["<A-6>"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Jump to Buffer 6" },
        ["<A-7>"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Jump to Buffer 7" },
        ["<A-8>"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Jump to Buffer 8" },
        ["<A-9>"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Jump to Buffer 9" },
        ["<A-0>"] = { "<cmd>BufferLineGoToBuffer -1<cr>", "Jump to Last Buffer" },
        ["<A-p>"] = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin Buffer" },
        ["<A-c>l"] = { "<cmd>BufferLineCloseLeft<cr>", "Close Buffers to the Left" },
        ["<A-c>r"] = { "<cmd>BufferLineCloseRight<cr>", "Close Buffers to the Right" },
        ["<leader>b"] = { name = "+Buffers" },
        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", "Sort By Tabs" },
        ["<leader>bl"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort By Directory" },
        ["<leader>be"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort By Extension" },
        ["<leader>br"] = { "<cmd>BufferLineSortByRelativeDirectory<cr>", "Sort By Relative Directory" },

        -- bufremove keybindings
        ["<leader>bd"] = { function() require("mini.bufremove").delete(0, false) end, "Delete Buffer" },
        ["<leader>bD"] = { function() require("mini.bufremove").delete(0, true) end, "Delete Buffer (Force)" },

        -- toggleterm keybindings
        ["<C-t>"] = { cozyvim.utils.toggle.terminal, "Toggle Terminal" },
        ["<C-g>"] = { _toggle_lazygit, "Toggle Lazygit", },

        -- toggle keybindings
        ["<leader>t"] = { name = "+Toggle" },
        ["<leader>tt"] = { function() cozyvim.utils.toggle.term_direction() end, "Toggle Terminal Direction" },
        ["<leader>tf"] = { function() cozyvim.utils.toggle.format_on_save() end, "Toggle Format on Save" },

        -- lsp keybindings
        ["K"] = { function() vim.lsp.buf.hover() end, "Show Lsp Hover", },
        ["gD"] = { function() vim.lsp.buf.declaration() end, "Go to Lsp Declaration", },
        ["gd"] = { function() vim.lsp.buf.definition() end, "Go to Lsp Definition", },
        ["gi"] = { function() vim.lsp.buf.implementation() end, "Go to Lsp Implementation", },
        ["gr"] = { function() vim.lsp.buf.references() end, "Show Lsp References", },
        ["<leader>D"] = { function() vim.lsp.buf.type_definition() end, "Go to Lsp Type Definition", },
        ["<leader>r"] = { name = "+Rename" },
        ["<leader>rn"] = { function() vim.lsp.buf.rename() end, "Rename Lsp Symbol", },
        ["<leader>rs"] = { function() require("spectre").open() end, "Replace in files (Spectre)" },
        ["<leader>c"] = { name = "+Code" },
        ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "Code Action", },
        ["<leader>cf"] = { function() vim.lsp.buf.format() end, "Format Buffer" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, "Go to Previous Lsp Diagnostic", },
        ["]d"] = { function() vim.diagnostic.goto_next() end, "Go to Next Lsp Diagnostic", },
        ["gp"] = { name = "+Goto Preview" },
        ---@diagnostic disable-next-line: missing-parameter
        ["gpd"] = { function() require("goto-preview").goto_preview_definition() end, "Goto Preview Definition", },
        ---@diagnostic disable-next-line: missing-parameter
        ["gpt"] = { function() require("goto-preview").goto_preview_type_definition() end, "Goto Preview Type Definition", },
        ---@diagnostic disable-next-line: missing-parameter
        ["gpi"] = { function() require("goto-preview").goto_preview_implementation() end, "Goto Preview Implementation", },
        ["gpr"] = { function() require("goto-preview").goto_preview_references() end, "Goto Preview References", },
        ["gP"] = { function() require("goto-preview").close_all_win() end, "Close all Goto Preview Windows", },

        -- debugging keybindings
        ["<F3>"] = { require("dap").close, "Dap Stop Debugging" },
        ["<F5>"] = { require("dap").continue, "Dap Continue/Start Debugging" },
        ["<F6>"] = { require("dap").pause, "Dap Pause" },
        ["<F7>"] = { require("dapui").toggle, "Dap Toggle UI" },
        ["<F9>"] = { require("dap").toggle_breakpoint, "Dap Toggle Breakpoint" },
        ["<F10>"] = { require("dap").step_over, "Dap Step Over" },
        ["<F11>"] = { require("dap").step_into, "Dap Step Into" },
        ["<F12>"] = { require("dap").step_out, "Dap Step Out" },
    },
    visual_mode = {
        ["<C-c>"] = { "<esc><cmd>q<cr>", "Quit" },
        ["<leader>g"] = { name = "+Git" },
        ["<leader>gs"] = { name = "+GitSigns" },
        ["gs"] = { name = "+Surround" },
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
    },
}

-- override default keybindings with custom mappings
mappings = vim.tbl_deep_extend("force", defaults, mappings)

for mode, keys in pairs(mappings) do
    local mode_adapter = mode_adapters[mode]
    wk.register(keys, { mode = mode_adapter })
end
