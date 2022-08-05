local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

-- require'lspconfig'.jsonls.setup {capabilities = capabilities}

--require'lspconfig'.html.setup {capabilities = capabilities}
--
--require'lspconfig'.cssls.setup {capabilities = capabilities}
--
--require'lspconfig'.tsserver.setup {capabilities = capabilities}
-- texlab
-- require'lspconfig'.texlab.setup {capabilities = capabilities}

-- might affect luasnips
require"lsp_signature".setup()

-- require'lspconfig'.pylsp.setup {capabilities = capabilities}
require'lspconfig'.jedi_language_server.setup{capabilities = capabilities}
require'lspconfig'.fortls.setup {capabilities = capabilities}
require'lspconfig'.cmake.setup{capabilities = capabilities}

--require'lspconfig'.rust_analyzer.setup {
--    -- more config
--    capabilities = capabilities,
--    settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}
--}
-- require'lspconfig'.jedi_language_server.setup{}

-- lua

USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER ..
                            "/.config/lua-language-server"
    sumneko_binary = "/Users/" .. USER ..
                         "/.config/lua-language-server/bin/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/theoryfs2/ds/" .. USER ..
                            "/.config/lua-language-server"
    sumneko_binary = "/theoryfs2/ds/" .. USER ..
                         "/.config/lua-language-server/bin/lua-language-server"
else
    print("Unsupported system for sumneko")
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

-- snippets
-- local lspconfig = require'lspconfig'
-- local configs = require'lspconfig/configs'
--
-- if not lspconfig.emmet_ls then
--  configs.emmet_ls = {
--    default_config = {
--      cmd = {'emmet-ls', '--stdio'};
--      filetypes = {'html', 'css', 'blade'};
--      root_dir = function(fname)
--        return vim.loop.cwd()
--      end;
--      settings = {};
--    };
--  }
-- end
-- lspconfig.emmet_ls.setup{ capabilities = capabilities; }

