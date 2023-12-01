require("mason").setup()
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    vim.notify("Couldn't load Mason-LSP-Config")
    return
end
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
    .protocol
    .make_client_capabilities())
local on_attach = require("cmp_nvim_lsp").on_attach
require "lsp_signature".setup()

mason_lspconfig.setup({
    ensure_install = { "julials", "rust_analyzer", "jedi_language_server", "ltex"}
})

local function format_any_value(obj, buffer)
    local _type = type(obj)
    if _type == "table" then
        buffer[#buffer + 1] = '{"'
        for key, value in next, obj, nil do
            buffer[#buffer + 1] = tostring(key) .. '":'
            format_any_value(value, buffer)
            buffer[#buffer + 1] = ',"'
        end
        buffer[#buffer] = '}' -- note the overwrite
    elseif _type == "string" then
        buffer[#buffer + 1] = '"' .. obj .. '"'
    elseif _type == "boolean" or _type == "number" then
        buffer[#buffer + 1] = tostring(obj)
    else
        buffer[#buffer + 1] = '"???' .. _type .. '???"'
    end
end


local function format_as_json(obj)
    if obj == nil then
        return "null"
    else
        local buffer = {}
        format_any_value(obj, buffer)
        return table.concat(buffer)
    end
end

local function print_as_json(obj)
    print(format_as_json(obj))
end

local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
    table.insert(words, word)
end

mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- Default handler (optional)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
    end,

    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            capabilities = capabilities,
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
        }
    end,
    ["julials"] = function()
        lspconfig.julials.setup {
            on_new_config = function(new_config, _)
                local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
                -- local julia = vim.fn.expand("~/gits/julia/julia")
                local sysimage_arg = "--sysimage=" ..
                    vim.fn.expand("~/.julia/environments/nvim-lspconfig/languageserver.so")
                local sysimage_native = "--sysimage-native-code=yes"
                if false then
                    new_config.cmd[5] = (new_config.cmd[5]):gsub("using LanguageServer",
                        "using Revise; using LanguageServer; if isdefined(LanguageServer, :USE_REVISE); LanguageServer.USE_REVISE[] = true; end")
                elseif require 'lspconfig'.util.path.is_file(julia) then
                    vim.notify("Julia LSP Engaged!")
                    new_config.cmd[1] = julia
                    if new_config.cmd[2] ~= sysimage_arg then
                        table.insert(new_config.cmd, 2, sysimage_arg)
                        table.insert(new_config.cmd, 3, sysimage_native)
                    end
                end
            end,
            -- This just adds dirname(fname) as a fallback (see nvim-lspconfig#1768).
            root_dir = function(fname)
                local util = require 'lspconfig.util'
                return util.root_pattern 'Project.toml' (fname) or util.find_git_ancestor(fname) or
                    util.path.dirname(fname)
            end,
            -- on_attach = function(client, bufnr)
            --     on_attach(client, bufnr)
            --     -- Disable automatic formatexpr since the LS.jl formatter isn't so nice.
            --     vim.bo[bufnr].formatexpr = ''
            -- end,
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["ltex"] = function()
        lspconfig.ltex.setup {
            enabled = { "latex", "tex", "bib", "markdown" },
            on_attach = on_attach,
            capabilities = capabilities,
            checkFrequency = "save",
            language = "en-US",
            settings = {
                ltex = {
                    dictionary = {
                        ["en-US"] = words,
                    },
                    disabledRules = {
                        ['en-US'] = {
                            "ARROWS",
                            "MORFOLOGIK_RULE_EN_US",
                        },
                    }
                },
            },
        }
    end,

})

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}

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
