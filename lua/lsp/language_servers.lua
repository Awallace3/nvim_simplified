-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
--                                                                      .protocol
--                                                                      .make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
                                                                     .protocol
                                                                    .make_client_capabilities())

require'lspconfig'.jsonls.setup {capabilities = capabilities}

require'lspconfig'.html.setup {capabilities = capabilities}
--
require'lspconfig'.cssls.setup {capabilities = capabilities}
--
require'lspconfig'.tsserver.setup {capabilities = capabilities}
require'lspconfig'.ccls.setup {capabilities = capabilities}
require'lspconfig'.denols.setup {capabilities = capabilities}
vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
-- texlab
-- require'lspconfig'.texlab.setup {capabilities = capabilities}

-- might affect luasnips
require"lsp_signature".setup()
local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  },
  capabilities = capabilities
}

-- require'lspconfig'.pylsp.setup {capabilities = capabilities}
require'lspconfig'.jedi_language_server.setup{capabilities = capabilities}
require'lspconfig'.fortls.setup {capabilities = capabilities}
require'lspconfig'.cmake.setup{capabilities = capabilities}
require'lspconfig'.julials.setup{capabilities = capabilities,
on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        -- local cmd = {
        --     vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia"),
        --     "-Jlanguageserver.so"
        -- }
        if require'lspconfig'.util.path.is_file(julia) then
            local sys_image = "--sysimage=/theoryfs2/ds/amwalla3/.julia/environments/nvim-lspconfig/languageserver.so"
	    vim.notify("Hello!")
            new_config.cmd[1] = julia
            table.insert(new_config.cmd, 3, sys_image)
        end
    end
}

-- require'lspconfig'.julials.setup({
--       on_new_config = function(new_config,new_root_dir)
--       Server_path = "/theoryfs2/ds/amwalla3/.julia/packages/LanguageServer/0vsx2/src"
--       Cmd = {
--         "julia",
--         "--project="..Server_path,
--         "--startup-file=no",
--         "--history-file=no",
--         "--sysimage=/theoryfs2/ds/amwalla3/.julia/environments/nvim-lspconfig/languageserver.so",
--         "--sysimage-native-code=yes",
--         "-e", [[
--           using Pkg;
--           Pkg.instantiate()
--           using LanguageServer; using SymbolServer;
--           depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--           project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
--           # Make sure that we only load packages from this environment specifically.
--           @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
--           server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
--           server.runlinter = true;
--           run(server);
--         ]]
--     };
--     new_config.cmd = Cmd
--     -- on_attach=require'completion'.on_attach
--     end
-- })

require'lspconfig'.rust_analyzer.setup({
    -- on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
-- require'lspconfig'.rust_analyzer.setup {
--    -- more config
--    capabilities = capabilities,
--    settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}
-- }
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

