vim.g.completeopt = "menu,menuone,noselect,noinsert"
local cmp = require 'cmp'
local lspkind = require('lspkind')
local ls = require("luasnip")
local snippets_folder = vim.fn.stdpath "config" .. "snippets/"
print(snippets_folder)
require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
            col)
        :match("%s") == nil
end
vim.api.nvim_exec(
    [[
      autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
      autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  ]],
    false
)

cmp.setup({
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = {
        -- ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<CR>'] = cmp.mapping.close(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-l>"] = cmp.mapping {
            i = function(fallback)
                if ls.choice_active() then
                    ls.change_choice(1)
                else
                    fallback()
                end
            end
        }
    },
    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end
    },
    sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } },
    completion = { completeopt = "menu,menuone,noinsert" },
    formatting = {
        format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
    },
    experimental = { ghost_text = false }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' } -- You can specify the `cmp_git` source if you were installed it.
    }, { { name = 'buffer' } })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    --     mapping = {
    --        ['<CR>'] = cmp.mapping.confirm({
    --            select = false
    --        }),
    --   ["<C-p>"] = cmp.mapping.select_prev_item(),
    --   ["<C-n>"] = cmp.mapping.select_next_item(),
    --   ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --   ["<C-e>"] = cmp.mapping.close(),
    --   ["<C-y>"] = cmp.mapping.confirm({ select = false}),
    -- },
    sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    --     mapping = {
    --        ['<CR>'] = cmp.mapping.confirm({
    --            select = true
    --        }),
    --   ["<C-p>"] = cmp.mapping.select_prev_item(),
    --   ["<C-n>"] = cmp.mapping.select_next_item(),
    --   ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --   ["<C-e>"] = cmp.mapping.close(),
    --   ["<C-y>"] = cmp.mapping.confirm({ select = false}),
    -- },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
})
