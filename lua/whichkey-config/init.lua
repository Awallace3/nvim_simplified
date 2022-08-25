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
        },
    }
}
local Terminal = require('toggleterm.terminal').Terminal
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
local mappings = {
    q = {":bn<bar>bd #<CR>", "Close Buffer"},
    Q = {":wq<cr>", "Save & Quit"},
    --w = {":w<cr>", "Save"},
    x = {":bdelete<cr>", "Close"},
    E = {
        E = {":vs<bar>e ~/.config/nvim/init.lua<cr>", "Edit config"},
        W = {":vs<bar>e ~/.config/nvim/lua/whichkey-config/init.lua<cr>", "Edit config"},
    },
    g = {
        -- gitgutter
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
        af = {":Gw<cr>", "Add File"},
    },
    f ={
        f = {":Telescope find_files<cr>", "Telescope Find Files"},
        r = {":Telescope live_grep<cr>", "Telescope Live Grep"},
        b = {":Telescope buffers<cr>", "Telescope Buffers"},
        h = {":Telescope help_tags<cr>", "Telescope Help Tags"},
        p = {":echo expand('%:p')<cr>", "Current File Path"}
    },
    p = {
        s = {":w<bar>so %<bar>PackerSync<cr>", "PackerSync"}
    },
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
        --D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration"},
        r = {'<cmd>lua vim.lsp.buf.references()<cr>', "References"},
        R = {'<cmd>Lspsaga rename<cr>', "Rename"},
        a = {'<cmd>Lspsaga code_action<cr>', "Code Action"},
        e = {'<cmd>Lspsaga show_line_diagnostics<cr>', "Show Line Diagnostics"},
        n = {'<cmd>Lspsaga diagnostic_jump_next<cr>', "Go To Next Diagnostic"},
        N = {
            '<cmd>Lspsaga diagnostic_jump_prev<cr>', "Go To Previous Diagnostic"
        },
        -- T = {'require("lsp_lines").toggle<cr>', "Toggle lsp_lines"}
    },
    r = {
        r = {":w <bar>so %<cr>", "Save and Source"},
        d = {":vs <bar>term make build_and_test<cr>", "dftd4 build and run"},
        t = {
            p = {":vs<bar>term pytest tests.py<cr>", "PyTest"},
            o = {":vs<bar>term python3 tests.py<cr>", "run tests.py"}
        },
        m = {":vs<bar>term mpiexec -n 2 python3 -u main.py<cr>", "mpiexec main.py"},
        a = {":vs<bar> term python3 %<cr>", "run active file"}
    },
    t = {
        t = {":ToggleTerm<cr>", "Split Below"},
        f = {toggle_float, "Floating Terminal"},
        -- l = {toggle_lazygit, "LazyGit"},
        y = {toggle_top, "top"},
        -- m = {toggle_neomutt, "NeoMutt"},
        d = {":!dftd4 tmp.xyz --json t.json --param 1.0 0.9171 0.3385 2.883<cr>", "dftd4 test"},
        c = {":vs<bar>term lscpu | grep -E '^Thread|^Core|^Socket|^CPU\\('<cr>", "lscpu grep"},
    }
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
