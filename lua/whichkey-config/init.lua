local wk = require("which-key")
wk.setup {
    plugins = {
        marks = true,
        registers = true,
        spelling = {enabled = false, suggestions = 20},
        presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false
        }
    }
}



Terminal = require('toggleterm.terminal').Terminal
local toggle_float = function()
    local float = Terminal:new({direction = "float"})
    return float:toggle()
end
-- local toggle_lazygit = function()
--     local lazygit = Terminal:new({cmd = '~/bin/lazygit', direction = "float"})
--     return lazygit:toggle()
-- end
-- local toggle_neomutt = function()
--     local lazygit = Terminal:new({cmd = 'neomutt', direction = "float"})
--     return lazygit:toggle()
-- end
local toggle_top = function()
    local top = Terminal:new({cmd = 'top', direction = "float"})
    return top:toggle()
end
Toggle_pymol = function()
    local pymol = Terminal:new({cmd = 'pymol tmp.xyz', direction = "horizontal"})
    return pymol:toggle()
end

GetPythonFunctionName = function()
    local function_name = vim.fn.search("def", "bnW")
    if function_name == 0 then

        print("No Function")
        return nil
    else
        local val = vim.fn.getline(function_name):match("def%s+(.-)%s*%(")
        print(val)
        return val
    end
end

local PytestPythonFunction = function ()
    local function_name = GetPythonFunctionName()
    print(function_name)
    local fname = vim.fn.expand("%:t")
    if function_name == nil then
        return print("No Function Name found for pytest!")
    end
    local cmd = "vs"
    vim.cmd(cmd)
    cmd = "term pytest " .. fname .. " -k '" .. function_name .. "'"
    print(cmd)
    vim.cmd(cmd)
    print("R:" .. function_name)
end

local mappings = {
    q = {":bn<bar>bd #<CR>", "Close Buffer"},
    Q = {":wq<cr>", "Save & Quit"},
    -- w = {":w<cr>", "Save"},
    x = {":bdelete<cr>", "Close"},
    c = {
        c = {":set number! relativenumber!<cr>", "remove numbering"}
    },
    E = {
        E = {":vs<bar>e ~/.config/nvim/init.lua<cr>", "Edit config"},
        e = {":e<bar>e ~/.config/nvim/init.lua<cr>", "Edit config"},
        W = {
            ":vs<bar>e ~/.config/nvim/lua/whichkey-config/init.lua<cr>",
            "Edit config"
        },
        s = {":e<bar>e ~/.config/nvim/snippets<cr>", "Edit config"},
        S = {
            ":vs<bar>e ~/.config/nvim/lua/luasnip-config.lua<bar>40<cr>",
            "Edit Snippets"
        },
        C = {":vs<bar>e ~/.config/nvim/lua/lsp/cmp.lua<cr>", "Edit cmp"},
        L = {
            ":vs<bar>e ~/.config/nvim/lua/lsp/language_servers.lua<cr>",
            "Edit cmp"
        }
        -- S = {":vs<bar>e ~/.config/nvim/snippets<cr>", "Edit config"}
    },
    g = {
        -- gitgutter
        d = {":Git difftool<cr>", "Git Diff"},
        n = {":GitGutterNextHunk<cr>", "Next Hunk"},
        p = {":GitGutterPrevHunk<cr>", "Prev Hunk"},
        a = {":GitGutterStageHunk<cr>", "Stage Hunk"},
        u = {":GitGutterUndoHunk<cr>", "Undo Hunk"},
        -- vimaget
        s = {":Magit<cr>", "Git Status"},
        -- fugitive
        P = {":Git push<cr>", "Git Push"},
        b = {":Git blame<cr>", "Git Blame"},
        c = {":Git commit<bar>:startinsert<cr>", "Git Commit"},
        af = {":Gw<cr>", "Add File"}
    },
    f = {
        f = {":Telescope find_files<cr>", "Telescope Find Files"},
        r = {":Telescope live_grep<cr>", "Telescope Live Grep"},
        b = {":Telescope buffers<cr>", "Telescope Buffers"},
        h = {":Telescope help_tags<cr>", "Telescope Help Tags"},
        p = {":redir @+ | echo expand('%:p') | redir END<CR>", "Current File Path"}
    },
    p = {s = {":w<bar>so %<bar>PackerSync<cr>", "PackerSync"}},
    -- t = {name = '+terminal', t = {":FloatermNew --wintype=popup --height=6", "terminal"}},
    l = {
        name = "LSP",
        i = {":LspInfo<cr>", "Connected Language Servers"},
        k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
        K = {"<cmd>Lspsaga hover_doc<cr>", "Hover Commands"},
        w = {
            '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>',
            "Add Workspace Folder"
        },
        W = {
            '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>',
            "Remove Workspace Folder"
        },
        l = {
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>',
            "List Workspace Folders"
        },
        t = {'<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition"},
        d = {'<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition"},
        D = {'<cmd>vs<bar>lua vim.lsp.buf.definition()<cr>', "Go To Definition"},
        -- D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration"},
        r = {'<cmd>lua vim.lsp.buf.references()<cr>', "References"},
        R = {'<cmd>Lspsaga rename<cr>', "Rename"},
        a = {'<cmd>Lspsaga code_action<cr>', "Code Action"},
        e = {'<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics"},
        n = {'<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic"},
        N = {
            '<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic"
        },
        T = {':lua require("lsp_lines").toggle()<cr>', "Toggle lsp_lines"}
    },
    r = {
        r = {":w <bar>so %<cr>", "Save and Source"},
        d = {":vs <bar>term make build_and_test<cr>", "dftd4 build and run"},
        b = {":vs <bar>term bash build.sh<cr>", "./build.sh"},
        j = {":vs <bar>term julia main.jl<cr>", "julia main.jl"},
        -- RUN TESTS
        t = {
            p = {":vs<bar>term pytest tests.py<cr>", "PyTest"},
            k = {":vs<bar>term pytest tests.py -k 'test_pairwise_AB_versus_classic_IE'<cr>", "PyTest"},
            l = {PytestPythonFunction, "PyTest Specific"},
            o = {":vs<bar>term python3 tests.py<cr>", "run tests.py"}
        },
        m = {
            m = {":vs<bar>term make<cr>", "make"},
            d = {":vs<bar>term make debug<cr>", "make"},
            t = {":vs<bar>term make t", "make"},

        },
        i = {
            ":vs<bar>term mpiexec -n 2 python3 -u main.py<cr>",
            "mpiexec main.py"
        },
        k = {
            ":vs<bar>term mpiexec -n 2 python3 -u db.py<cr>",
            "mpiexec main.py"
        },
        a = {":vs<bar> term python3 %<cr>", "run active file"}
    },
    t = {
        t = {":ToggleTerm<cr>", "Split Below"},
        f = {toggle_float, "Floating Terminal"},
        -- l = {toggle_lazygit, "LazyGit"},
        y = {toggle_top, "top"},
        -- m = {toggle_neomutt, "NeoMutt"},
        d = {
            ":!dftd4 tmp.xyz --json t.json --param 1.0 0.9171 0.3385 2.883<cr>",
            "dftd4 test"
        },
        c = {
            ":vs<bar>term lscpu | grep -E '^Thread|^Core|^Socket|^CPU\\('<cr>",
            "lscpu grep"
        }
    },
    o = {
        o = {":OverseerToggle<cr>", "Overseer Toggle"},
        r = {":OverseerRun<cr>", "Overseer Run"},
        c = {":OverseerRun ", "Overseer Run template"},
        l = {":OverseerLoadBundle<cr>", "Overseer Load Bundle"},
        d = {":OverseerDeleteBundle<cr>", "Overseer Delete Bundle"},
        h = {':lua require("notify").history()<cr>', "Notify History"},
        n = {':Notifications<cr>', "Notify Notifications"},
        p = {":OverseerRun python3 main.py<cr>", "Overseer Run Python"}

    },
    m = {
        e = {"<cmd>EvalBlock<CR>", "EvalBlock"},
        p = {
            ":vs <bar> term pandoc -V geometry:margin=1in -C --bibliography=refs.bib --listings --csl=default.csl -s h.md -o h.pdf --pdf-engine=xelatex <CR>",
            "pdflatex md"
        }
    }

}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
