vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- vim.g.completeopt = "menu,menuone"

-- example mappings
-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and
--                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
--                                                                           col)
--                    :match("%s") == nil
-- end
--
-- local feedkey = function(key, mode)
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
--                           mode, true)
-- end

-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require('lspkind')

-- luasnips
-- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- if not snip_status_ok then return end
-- local luasnip = require"luasnip"

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()


-- require('luasnip').filetype_extend("javascript", {"javascriptreact"})
-- require('luasnip').filetype_extend("javascript", {"html"})
-- require('luasnip').filetype_extend("javascript", {"react-native"})

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
      mapping = {
    --["<CR>"] = cmp.mapping.confirm({ select = true }),
         ['<CR>'] = cmp.mapping.confirm({
             behavior = cmp.ConfirmBehavior.Insert,
             select = false
             --select = true
         }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expandable() then
--                 luasnip.expand()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             elseif check_backspace() then
--                 fallback()
--             else
--                 fallback()
--             end
--         end, {"i", "s"}),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      -- elseif has_words_before() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
    snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
  completion = { completeopt = "menu,menuone,noinsert" },
  experimental = { ghost_text = true },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- capabilities = capabilities
-- }

-- cmp.setup({
--     snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--             -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--             --luasnip.lsp_expand(args.body)
--             -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--             -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--         end
--     },
--     window = {completion = cmp.config.window.bordered()},
--     mapping = {
--         ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
--         ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
--         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
--         ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--         ['<C-e>'] = cmp.mapping({
--             i = cmp.mapping.abort(),
--             c = cmp.mapping.close()
--         }),
--         ['<CR>'] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = false
--         }),
--         -- ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}),
--         -- ["<Tab>"] = cmp.mapping(function(fallback)
--         --   if cmp.visible() then
--         --     cmp.select_next_item()
--         --   elseif vim.fn["vsnip#available"](1) == 1 then
--         --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
--         --   elseif has_words_before() then
--         --     cmp.complete()
--         --   else
--         --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
--         --   end
--         -- end, {"i", "s"}),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expandable() then
--                 luasnip.expand()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             elseif check_backspace() then
--                 fallback()
--             else
--                 fallback()
--             end
--         end, {"i", "s"}),
--
--         -- ["<S-Tab>"] = cmp.mapping(function()
--         --   if cmp.visible() then
--         --     cmp.select_prev_item()
--         --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
--         --     feedkey("<Plug>(vsnip-jump-prev)", "")
--         --   end
--         -- end, {"i", "s"})
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, {"i", "s"})
--     },
--     sources = cmp.config.sources({
--         {name = 'luasnip'},
--        -- {name = 'orgmode'},
--         {name = 'nvim_lsp'},
--        -- {name = 'vsnip'}, -- For vsnip users.
--         -- {name = 'latex_symbols'}, {name = 'path'}
--         -- { name = 'luasnip' }, -- For luasnip users.
--         -- { name = 'ultisnips' }, -- For ultisnips users.
--         -- { name = 'snippy' }, -- For snippy users.
--     }, {{name = 'buffer'}}),
--     -- documentaion is a test
--     -- documentation = {
--     --     border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
--     -- },
--     experimental = {
--         ghost_text = true
--         -- native_menu = false,
--     },
--     formatting = {
--         format = lspkind.cmp_format({with_text = true, maxwidth = 50})
--     }
-- })
--
-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
-- })
