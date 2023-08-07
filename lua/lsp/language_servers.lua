local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
    .protocol
    .make_client_capabilities())


lspconfig.jsonls.setup { capabilities = capabilities }
lspconfig.texlab.setup { capabilities = capabilities }

lspconfig.html.setup { capabilities = capabilities }
--
lspconfig.tsserver.setup { capabilities = capabilities }
lspconfig.denols.setup { capabilities = capabilities }

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
-- texlab
-- lspconfig.texlab.setup {capabilities = capabilities}

-- might affect luasnips
require "lsp_signature".setup()

-- lspconfig.ccls.setup {capabilities = capabilities}
-- lspconfig.ccls.setup {
--     cmd = { "ccls", "--log-file=/tmp/ccls.log", '--init={"clang":{"excludeArgs":["--gcc-toolchain=/usr"]}}' },
--     filetypes = { "c", "cpp", "obj", "objcpp" },
--     capabilities = capabilities,
-- }
lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--log=verbose",
        "--compile-commands-dir=./build",
        -- "--query-driver=/usr/bin/g++",
        "--query-driver=/usr/bin/g++,/theoryfs2/ds/amwalla3/miniconda3/envs/p4dev18/bin/x86_64-conda-linux-gnu-c++",
    },
    capabilities = capabilities
}

vim.g.LanguageClient_serverStderr = "/tmp/lsp.log"


-- lspconfig.pylsp.setup {capabilities = capabilities}
-- lspconfig.pylsp.setup {
--     capabilities = capabilities,
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     maxLineLength = 80
--                 },
--                 jedi = {
--                     extra_paths = { "~/miniconda3/envs/nvim/bin" }
--                 }
--             }
--         }
--     }
-- }
local home = os.getenv("HOME")
lspconfig.jedi_language_server.setup {
    capabilities = capabilities,
    cmd = {
        home .. "/miniconda3/envs/nvim/bin/jedi-language-server"
    }
}
-- lspconfig.pyright.setup {
--     capabilities = capabilities,
--     cmd = { "pyright-langserver", "--stdio" },
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 -- diagnosticMode = "workspace",
--                 diagnosticMode = "openFilesOnly",
--                 typeCheckingMode = "basic",
--                 -- stubPath = "/theoryfs2/ds/amwalla3/.pyright-stubs"
--             }
--         }
--     }
-- }
lspconfig.fortls.setup { capabilities = capabilities }
lspconfig.cmake.setup { capabilities = capabilities,
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    init_options = {
        buildDirectory = "build",
        maxNumJobs = 4
    },
    whitelist = { "cmake" }

}

lspconfig.julials.setup { capabilities = capabilities,

    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if lspconfig.util.path.is_file(julia) then
            local sys_image = "--sysimage=/theoryfs2/ds/amwalla3/.julia/environments/nvim-lspconfig/languageserver.so"
            vim.notify("Engaged julia LSP!")
            new_config.cmd[1] = julia
            table.insert(new_config.cmd, 3, sys_image)
        end
    end
}
--
-- lspconfig.julials.setup({
--       on_new_config = function(new_config,new_root_dir)
--       Server_path = "/theoryfs2/ds/amwalla3/.julia/packages/LanguageServer/0vsx2/src"
--       Cmd = {
--         "julia",
--         "--project="..Server_path,
--         "--startup-file=no",
--         "--history-file=no",
--         -- "--sysimage=/theoryfs2/ds/amwalla3/.julia/environments/nvim-lspconfig/languageserver.so",
--         -- "--sysimage-native-code=yes",
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

lspconfig.rust_analyzer.setup({
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

-- lua
local sumneko_root_path = vim.fn.expand("$HOME/.config/lua-language-server")
local sumneko_binary = vim.fn.expand("$HOME/.config/lua-language-server/bin/lua-language-server")
lspconfig.lua_ls.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
                globals = { 'vim' }
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
