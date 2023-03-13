local wk = require("which-key")

vim.api.nvim_set_keymap("n", "<C-c>", "<esc><cmd>quit<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-c>", "<esc><cmd>quit<cr>", { noremap = true, silent = true })

-- telescope keybindings
wk.register({
    ["<leader>f"] = {
        name = "+File",
        f = { require("cozyvim.utils").telescope("files"), "Find Files" },
        r = { require("cozyvim.utils").telescope("oldfiles"), "Find Recent Files" },
        w = { require("cozyvim.utils").telescope("grep_string"), "Grep String" },
        b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
        p = { "<cmd>Telescope projects<cr>", "Projects" },
        h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
        c = { "<cmd>Telescope resume<cr>", "Continue" },
    },
    ["<leader>/"] = { require("cozyvim.utils").telescope("live_grep"), "Live Grep" },
})

-- general keybindings
wk.register({
    -- plugin manager keybindings
    ["<leader>l"] = { "<cmd>Lazy<cr>", "Plugins" },
    -- dashboard keybindings
    ["<leader>;"] = { "<cmd>Alpha<cr>", "Dashboard" },
    -- custom settings keybindings
    ["<leader>x"] = {
        function()
            require('telescope.builtin').find_files({
                cwd = vim.fn.stdpath("config")
            })
        end,
        "Configuration" },
    -- hop keybindings
    ["S"] = { "<cmd>HopWordMW<cr>", "Jump to Word" },
    ["s"] = { "<cmd>HopChar2MW<cr>", "Jump to Characters" },
    ["f"] = { "<cmd>HopChar1CurrentLine<cr>", "Find in Current Line (Char)" },
    ["F"] = { "<cmd>HopWordCurrentLine<cr>", "Find in Current Line (Word)" },
    -- mini.surround keybindings
    -- see plugin config for all default mappings
    ["gs"] = { name = "+Surround" },
    -- todo-comments keybindings
    ["]t"] = { function() require("todo-comments").jump_next() end, "Next Todo Comment", },
    ["[t"] = { function() require("todo-comments").jump_prev() end, "Previous Todo Comment", },
    -- bufremove keybindings
    ["<leader>b"] = {
        name = "+Buffer",
        d = { function() require("mini.bufremove").delete(0, false) end, "Delete Buffer" },
        D = { function() require("mini.bufremove").delete(0, true) end, "Delete Buffer (Force)" },
    },
    -- session management keybindings
    ["<leader>q"] = {
        name = "+Quit/Sessions",
        q = { "<cmd>qa<cr>", "Quit All" },
        s = { function() require("persistence").load() end, "Restore Session for Current Directory" },
        S = { function() require("persistence").load({ last = true }) end, "Restore Last Session" },
        d = { function() require("persistence").stop() end, "Stop Persistence => Don't Save Session on Exit", },
    },
    -- toggle keybindings
    ["<leader>t"] = {
        name = "+Toggle",
        f = { function() require("cozyvim.utils").toggle.format_on_save() end, "Toggle Format on Save" },
    },
})

-- lsp keybindings
wk.register({
    K = { function() vim.lsp.buf.hover() end, "Show Lsp Hover", },
    g = {
        d = { function() vim.lsp.buf.declaration() end, "Go to Lsp Declaration", },
        D = { function() vim.lsp.buf.type_definition() end, "Go to Lsp Type Definition", },
        i = { function() vim.lsp.buf.implementation() end, "Go to Lsp Implementation", },
        o = { function() vim.lsp.buf.type_definition() end, "Go to Lsp Type Definition", },
        r = { function() vim.lsp.buf.references() end, "Find Lsp References", },
        l = { function() vim.diagnostic.open_float() end, "Show Diagnostics (Floating Window)", },
        p = {
            name = "+Goto Preview",
            ---@diagnostic disable-next-line: missing-parameter
            d = { function() require("goto-preview").goto_preview_definition() end, "Goto Preview Definition", },
            ---@diagnostic disable-next-line: missing-parameter
            t = { function() require("goto-preview").goto_preview_type_definition() end, "Goto Preview Type Definition", },
            ---@diagnostic disable-next-line: missing-parameter
            i = { function() require("goto-preview").goto_preview_implementation() end, "Goto Preview Implementation", },
            r = { function() require("goto-preview").goto_preview_references() end, "Goto Preview References", },
            P = { function() require("goto-preview").close_all_win() end, "Close all Goto Preview Windows", },
        },
    },
    ["[d"] = { function() vim.diagnostic.goto_prev() end, "Go to Previous Lsp Diagnostic", },
    ["]d"] = { function() vim.diagnostic.goto_next() end, "Go to Next Lsp Diagnostic", },
    ["<leader>r"] = { name = "+Rename" },
    ["<leader>rn"] = { function() vim.lsp.buf.rename() end, "Rename Lsp Symbol", },
    ["<leader>c"] = { name = "+Code Actions" },
    ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "Code Action", },
})

-- debugging keybindings
wk.register({
    ["<F3>"] = { function() require("dap").close() end, "Dap Stop Debugging" },
    ["<F5>"] = { function() require("dap").continue() end, "Dap Continue/Start Debugging" },
    ["<F6>"] = { function() require("dap").pause() end, "Dap Pause" },
    ["<F7>"] = { function() require("dapui").toggle() end, "Dap Toggle UI" },
    ["<F9>"] = { function() require("dap").toggle_breakpoint() end, "Dap Toggle Breakpoint" },
    ["<F10>"] = { function() require("dap").step_over() end, "Dap Step Over" },
    ["<F11>"] = { function() require("dap").step_into() end, "Dap Step Into" },
    ["<F12>"] = { function() require("dap").step_out() end, "Dap Step Out" },
    ["<leader>d"] = {
        name = "+Debug",
        q = { function() require("dap").close() end, "Stop" },
        c = { function() require("dap").continue() end, "Continue/Start" },
        p = { function() require("dap").pause() end, "Pause" },
        d = { function() require("dapui").toggle() end, "Toggle UI" },
        b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
        s = { function() require("dap").step_over() end, "Step Over" },
        i = { function() require("dap").step_into() end, "Step Into" },
        o = { function() require("dap").step_out() end, "Step Out" },
    },
})
