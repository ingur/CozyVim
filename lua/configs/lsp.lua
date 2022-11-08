local lsp_installer = require("nvim-lsp-installer")
local lspsignature = require("lsp_signature")
local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")
local lspkind = require('lspkind')
local cmp = require("cmp")

local luasnip = require("luasnip")

luasnip.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    enable_autosnippets = false,
})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
    enabled = function()
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                path = "[Path]",
                buffer = "[Buf]",
                copilot = "[Cop]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
            })
        }),
    },
    sources = cmp.config.sources({
        { name = 'path', group_index = 1, },
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'copilot', group_index = 1 },
        { name = 'luasnip', group_index = 3, keyword_length = 3 },
    }, {
        { name = 'buffer' },
    })
})

lsp_installer.setup({
    automatic_installation = true
})

lspsignature.setup({
    floating_window = false,
    toggle_key = "<A-x>",
    hint_prefix = "🦥 ",
}, 0)

lspformat.setup({})

local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            completion = {
                keywordSnippet = "Disable",
            },
            diagnostics = {
                globals = { "vim", }
            }
        }
    },
})

lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {
                    "inactive-code"
                }
            }
        }
    },
})

lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
    settings = {
        javascript = {
            format = {
                semicolons = "insert",
            },
        },
    },
})

-- additional language servers
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local other_servers = {
    "html",
    "cssls",
    "jsonls",
    "marksman",
}

for _, lsp in ipairs(other_servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
