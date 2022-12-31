local lspkind = require("lspkind")
local cmp = require("cmp")

local luasnip = require("luasnip")

luasnip.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    enable_autosnippets = false,
})

local sources = {
    { name = "path", group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "luasnip", group_index = 3, keyword_length = 3 },
}

local menu = {
    path = "[Path]",
    buffer = "[Buf]",
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
}

if cozyvim.copilot.enabled and cozyvim.copilot.cmp then
    sources[#sources + 1] = { name = "copilot", group_index = 1 }
    menu["copilot"] = "[Cop]"
end

local function has_words_before()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    -- enabled = function()
    --     -- disable completion in comments
    --     local context = require 'cmp.config.context'
    --     -- keep command mode completion enabled when cursor is in a comment
    --     if vim.api.nvim_get_mode().mode == 'c' then
    --         return true
    --     else
    --         return not context.in_treesitter_capture("comment")
    --             and not context.in_syntax_group("Comment")
    --     end
    -- end,
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = menu,
        }),
    },
    sources = cmp.config.sources(sources, {
        { name = "buffer" },
    }),
})
