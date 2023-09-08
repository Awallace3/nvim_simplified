local wk = require("which-key")
wk.setup {
    plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = false, suggestions = 20 },
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
    local float = Terminal:new({ direction = "float" })
    return float:toggle()
end
local toggle_top = function()
    local top = Terminal:new({ cmd = 'top', direction = "float" })
    return top:toggle()
end
Toggle_pymol = function()
    local pymol = Terminal:new({ cmd = 'pymol tmp.xyz', direction = "horizontal" })
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

local PytestPythonFunction = function()
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

-- determine filetype for formatter, python different from others
local determine_formatter = function()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        vim.cmd("Format")
    elseif filetype == "htmldjango" then
        vim.cmd("Format")
    else
        vim.lsp.buf.format()
    end
end

GetPath = function(str, sep)
    sep = sep or '/'
    return str:match("(.*" .. sep .. ")")
end
-- get directory of python3_host_prog path
local nvim_bin_cmd = "silent !" .. GetPath(vim.g.python3_host_prog)

Formatter = function()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        vim.cmd("write")
        local cmd = nvim_bin_cmd .. "black --quiet" .. " " .. vim.fn.expand("%:p")
        vim.cmd(cmd)
        vim.cmd("e!")
    elseif filetype == "htmldjango" then
        vim.cmd("write")
        local cmd = nvim_bin_cmd .. "djlint" .. " --reformat --indent 4 " .. vim.fn.expand("%:p")
        print(cmd)
        vim.cmd(cmd)
        vim.cmd("e!")
    else
        vim.lsp.buf.format()
    end
end

local find_files_different_root = function()
    require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
end

local grep_files_different_root = function()
    require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })
end
-- Neogit =  require("neogit")
--
local function get_filetype()
    local filetype = vim.bo.filetype
    print(filetype)
    return filetype
end

require("telescope").load_extension('harpoon')
local function harpoon_nav_file()
    local ind = tonumber(vim.fn.input("Harpoon Index: "))
    require("harpoon.ui").nav_file(ind)
end


local mappings = {
    q = { ":bn<bar>bd #<CR>", "Close Buffer" },
    Q = { ":wq<cr>", "Save & Quit" },
    -- w = {":w<cr>", "Save"},
    x = { ":bdelete<cr>", "Close" },
    c = {
        c = { ":set number! relativenumber!<cr>", "remove numbering" },
        s = { ":colorscheme solarized<CR>", "Set Solarized Theme" }
    },
    d = {
        name = "Database",
        u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
        f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
        r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
        q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    },
    E = {
        name = "Edit Config",
        E = { ":vs<bar>e ~/.config/nvim/init.lua<cr>", "Edit config" },
        e = { ":e<bar>e ~/.config/nvim/init.lua<cr>", "Edit config" },
        W = {
            ":vs<bar>e ~/.config/nvim/lua/whichkey-config/init.lua<cr>",
            "Edit config"
        },
        s = { ":e<bar>e ~/.config/nvim/snippets<cr>", "Edit config" },
        S = {
            ":vs<bar>e ~/.config/nvim/lua/luasnip-config.lua<bar>40<cr>",
            "Edit Snippets"
        },
        C = { ":vs<bar>e ~/.config/nvim/lua/lsp/cmp.lua<cr>", "Edit cmp" },
        L = {
            ":vs<bar>e ~/.config/nvim/lua/lsp/language_servers.lua<cr>",
            "Edit cmp"
        }
        -- S = {":vs<bar>e ~/.config/nvim/snippets<cr>", "Edit config"}
    },
    F = { Formatter, "Format Buffer" },
    g = {
        -- gitgutter
        name = "Git",
        d = { ":Git difftool<cr>", "Git Diff" },
        n = { ":GitGutterNextHunk<cr>", "Next Hunk" },
        p = { ":GitGutterPrevHunk<cr>", "Prev Hunk" },
        a = { ":GitGutterStageHunk<cr>", "Stage Hunk" },
        u = { ":GitGutterUndoHunk<cr>", "Undo Hunk" },
        -- vimaget
        -- s = {":Magit<cr>", "Git Status"},
        s = { ":lua require('neogit').open()<CR>", "Git Status" },
        S = { ":lua require('neogit').open({ cwd = vim.fn.expand('%:p:h')})<CR>", "Git Status" },
        -- t = {":lua require('neogit')", "Git Status"},
        -- fugitive
        P = { ":Git push<cr>", "Git Push" },
        b = { ":Git blame<cr>", "Git Blame" },
        c = { ":Git commit<bar>:startinsert<cr>", "Git Commit" },
        af = { ":Gw<cr>", "Add File" }
    },
    h = {
        name = "Harpoon",
        i = { harpoon_nav_file, "Harpoon Index" },
        n = { ':lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
        p = { ':lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Previous" },

    },
    f = {
        name = "Find",
        a = { ':lua require("harpoon.mark").add_file()<cr>', "Harpoon Add" },
        m = { ':lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Menu" },
        f = { ":Telescope find_files<cr>", "Telescope Find Files" },
        r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
        F = { find_files_different_root, "Telescope Find Files" },
        R = { grep_files_different_root, "Telescope Live Grep" },
        b = { ":Telescope buffers<cr>", "Telescope Buffers" },
        h = { ':Telescope harpoon marks<cr>', "Telescope Harpoon" },
        d = { ":Telescope help_tags<cr>", "Telescope Help Tags" },
        p = { ":redir @+ | echo expand('%:p') | redir END<CR>", "Current File Path" },
        t = { get_filetype, "Current File Path" },
        i = { harpoon_nav_file, "Harpoon Index" },
    },
    p = { s = { ":w<bar>so %<bar>PackerSync<cr>", "PackerSync" } },
    -- t = {name = '+terminal', t = {":FloatermNew --wintype=popup --height=6", "terminal"}},
    l = {
        name = "LSP",
        i = { ":LspInfo<cr>", "Connected Language Servers" },
        k = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
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
        L = {
            ':LspLog<cr>',
            "LSP LOG"
        },
        t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition" },
        d = { '<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
        D = { '<cmd>vs<bar>lua vim.lsp.buf.definition()<cr>', "Go To Definition" },
        -- D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration"},
        r = { '<cmd>lua vim.lsp.buf.references()<cr>', "References" },
        R = { '<cmd>lua vim.lsp.buf.rename()<cr>', "Rename Variable" },
        a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', "Code Action" },
        T = { ':lua require("lsp_lines").toggle()<cr>', "Toggle lsp_lines" }
    },
    r = {
        name = "Run",
        b = { ":vs <bar>term bash build.sh<cr>", "./build.sh" },
        B = { ":vs <bar>term cd src/dispersion && bash build.sh<cr>", "./build.sh" },
        d = { ":vs <bar>term make build_and_test<cr>", "dftd4 build and run" },
        f = { ":vs <bar>term flask --app cdsg run --debug<cr>", "Run csdg" },
        r = { ":w <bar>so %<cr>", "Save and Source" },
        j = { ":vs <bar>term julia main.jl<cr>", "julia main.jl" },
        -- RUN TESTS
        t = {
            p = { ":vs<bar>term pytest tests.py<cr>", "PyTest" },
            k = { ":vs<bar>term pytest tests.py -k 'test_ATM_water'<cr>", "PyTest" },
            l = { PytestPythonFunction, "PyTest Specific" },
            o = { ":vs<bar>term python3 tests.py<cr>", "run tests.py" }
        },
        m = {
            m = { ":vs<bar>term make<cr>", "make" },
            d = { ":vs<bar>term make debug<cr>", "make" },
            t = { ":vs<bar>term make t", "make" },

        },
        i = {
            ":vs<bar>term mpiexec -n 2 python3 -u mpi_jobs.py<cr>",
            "mpiexec main.py"
        },
        h = {
            ":vs<bar>term mpirun -n 18 --machinefile machineFile python3 -u mpi_jobs.py<cr>",
            "mpiexec main.py"
        },
        u = {
            ":vs<bar>term mpiexec -n 2 python3 -u main.py<cr>",
            "mpiexec main.py"
        },
        k = {
            ":vs<bar>term mpiexec -n 2 python3 -u db.py<cr>",
            "mpiexec main.py"
        },
        a = { ":vs<bar> term python3 %<cr>", "run active file" }
    },
    t = {
        name = "Terminal",
        t = { ":ToggleTerm<cr>", "Split Below" },
        f = { toggle_float, "Floating Terminal" },
        -- l = {toggle_lazygit, "LazyGit"},
        y = { toggle_top, "top" },
        -- m = {toggle_neomutt, "NeoMutt"},
        d = {
            ":!dftd4 tmp.xyz --json t.json --param 1.0 0.9171 0.3385 2.883<cr>",
            "dftd4 test"
        },
        c = {
            ":vs<bar>term lscpu | grep -E '^Thread|^Core|^Socket|^CPU\\('<cr>",
            "lscpu grep"
        },
        r = { ':lua require("neotest").run.run()<CR>', "Neotest Pytest" },
        a = { ':lua require("neotest").run.run(vim.fn.expand("%f"))<CR>', "Neotest Pytest Active" },
        v = { ':lua require("neotest").run.attach()<CR>', "Neotest Attach" },
        p = { ':lua require("neotest").output.open({enter = true})<CR>', "Neotest Output" },
        o = { ':lua require("neotest").output_panel.toggle()<CR>', "Neotest Output" },
        w = { ':lua require("neotest").watch.toggle()<CR>', "Neotest Watch" },
        s = { ':lua require("neotest").summary.toggle()<CR>', "Neotest Summary" },


    },
    o = {
        name = "Overseer",
        o = { ":OverseerToggle<cr>", "Overseer Toggle" },
        r = { ":OverseerRun<cr>", "Overseer Run" },
        c = { ":OverseerRun ", "Overseer Run template" },
        l = { ":OverseerLoadBundle<cr>", "Overseer Load Bundle" },
        d = { ":OverseerDeleteBundle<cr>", "Overseer Delete Bundle" },
        h = { ':lua require("notify").history()<cr>', "Notify History" },
        n = { ':Notifications<cr>', "Notify Notifications" },
        p = { ":OverseerRun python3 main.py<cr>", "Overseer Run Python" }

    },
    m = {
        name = "Markdown",
        e = { "<cmd>EvalBlock<CR>", "EvalBlock" },
        p = {
            ":vs <bar> term pandoc -V geometry:margin=1in -C --bibliography=refs.bib --listings --csl=default.csl -s h.md -o h.pdf --pdf-engine=xelatex <CR>",
            "pdflatex md"
        }
    }

}
local opts = { prefix = '<leader>' }
wk.register(mappings, opts)
