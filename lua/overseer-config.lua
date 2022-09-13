local ovr = require("overseer")
ovr.setup({
    -- Default task strategy
    strategy = "terminal",
    -- Template modules to load
    templates = {"builtin"},
    -- When true, tries to detect a green color from your colorscheme to use for success highlight
    auto_detect_success_color = true,
    -- Patch nvim-dap to support preLaunchTask and postDebugTask
    dap = true,
    -- Configure the task list
    task_list = {
        -- Default detail level for tasks. Can be 1-3.
        default_detail = 1,
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
        max_width = {100, 0.2},
        -- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
        min_width = {40, 0.1},
        -- optionally define an integer/float for the exact width of the task list
        width = nil,
        -- String that separates tasks
        separator = "|──────────────────────────────────────|",
        -- Default direction. Can be "left" or "right"
        direction = "left",
        -- Set keymap to false to remove default behavior
        -- keymap=false,
        -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
        bindings = {
            ["?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["<C-e>"] = "Edit",
            ["o"] = "Open",
            ["J"] = "IncreaseDetail",
            ["K"] = "DecreaseDetail",
            ["L"] = "IncreaseAllDetail",
            ["H"] = "DecreaseAllDetail",
            ["["] = "DecreaseWidth",
            ["]"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["r"] = "TogglePreview",
        }
    },
    -- See :help overseer.actions
    actions = {},
    -- Configure the floating window used for task templates that require input
    -- and the floating window used for editing tasks
    form = {
        border = "rounded",
        zindex = 40,
        -- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_X and max_X can be a single value or a list of mixed integer/float types.
        min_width = 80,
        max_width = 0.9,
        width = nil,
        min_height = 10,
        max_height = 0.9,
        height = nil,
        -- Set any window options here (e.g. winhighlight)
        win_opts = {winblend = 10}
    },
    task_launcher = {
        -- Set keymap to false to remove default behavior
        -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
        bindings = {
            i = {["<C-s>"] = "Submit"},
            n = {["<CR>"] = "Submit", ["<C-s>"] = "Submit", ["?"] = "ShowHelp"}
        }
    },
    task_editor = {
        -- Set keymap to false to remove default behavior
        -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
        bindings = {
            i = {
                ["<CR>"] = "NextOrSubmit",
                ["<C-s>"] = "Submit",
                ["<Tab>"] = "Next",
                ["<S-Tab>"] = "Prev"
            },
            n = {
                ["<CR>"] = "NextOrSubmit",
                ["<C-s>"] = "Submit",
                ["<Tab>"] = "Next",
                ["<S-Tab>"] = "Prev",
                ["?"] = "ShowHelp"
            }
        }
    },
    -- Configure the floating window used for confirmation prompts
    confirm = {
        border = "rounded",
        zindex = 40,
        -- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_X and max_X can be a single value or a list of mixed integer/float types.
        min_width = 80,
        max_width = 0.5,
        width = nil,
        min_height = 10,
        max_height = 0.9,
        height = nil,
        -- Set any window options here (e.g. winhighlight)
        win_opts = {winblend = 10}
    },
    -- Configuration for task floating windows
    task_win = {
        -- How much space to leave around the floating window
        padding = 2,
        border = "rounded",
        -- Set any window options here (e.g. winhighlight)
        win_opts = {winblend = 10}
    },
    -- Aliases for bundles of components. Redefine the builtins, or create your own.
    component_aliases = {
        -- Most tasks are initialized with the default components
        default = {
            "on_output_summarize", "on_exit_set_status", "on_complete_notify",
            "on_complete_dispose"
        }
    },
    -- This is run before creating tasks from a template
    pre_task_hook = function(task_defn, util)
        -- util.add_component(task_defn, "on_result_diagnostics", {"timeout", timeout = 20})
        -- util.remove_component(task_defn, "on_complete_dispose")
        -- task_defn.env = { MY_VAR = 'value' }
    end,
    -- A list of components to preload on setup.
    -- Only matters if you want them to show up in the task editor.
    preload_components = {},
    -- Configure where the logs go and what level to use
    -- Types are "echo", "notify", and "file"
    log = {
        {type = "echo", level = vim.log.levels.WARN},
        {type = "file", filename = "overseer.log", level = vim.log.levels.WARN}
    }
})

ovr.register_template({
    -- Required fields
    name = "t1",
    builder = function(params)
        -- This must return an overseer.TaskDefinition
        return {
            -- cmd is the only required field
            cmd = {'echo'},
            -- additional arguments for the cmd
            args = {"hello", "world"},
            -- the name of the task (defaults to the cmd of the task)
            name = "Greet",
            -- set the working directory for the task
            -- cwd = "/tmp",
            -- additional environment variables
            -- env = {VAR = "FOO"},
            -- the list of components or component aliases to add to the task
            components = {"default"},
            -- arbitrary table of data for your own personal use
            metadata = {foo = "bar"}
        }
    end,
    -- Optional fields
    desc = "Optional description of task",
    -- Tags can be used in overseer.run_template()
    tags = {ovr.TAG.BUILD},
    params = {
        -- See :help overseer.params
    },
    -- Determines sort order when choosing tasks. Lower comes first.
    priority = 50,
    -- Add requirements for this template. If they are not met, the template will not be visible.
    -- All fields are optional.
    condition = {
        -- A string or list of strings
        -- Only matches when current buffer is one of the listed filetypes
        -- filetype = {"lua"},
        -- A string or list of strings
        -- Only matches when cwd is inside one of the listed dirs
        -- dir = "/home/user/my_project",
        -- Arbitrary logic for determining if task is available
        callback = function(search)
            print(vim.inspect(search))
            return true
        end
    }
})

ovr.register_template({
    name = "main.py",
    builder = function()
        return {
            cmd = {'python3'},
            args = {"main.py"},
            name = "main.py",
            components = {"default"},
            metadata = {foo = "python"}
        }
    end,
    desc = "Runs main.py",
    tags = {ovr.TAG.BUILD},
    priority = 50,
    condition = {
        callback = function(search)
            print(vim.inspect(search))
            return true
        end
    }
})

ovr.register_template({
    name = "hiveToCalc",
    builder = function()
        return {
            cmd = {'rsync'},
            args = {"-rP", "hive:data/calc/", "calc"},
            name = "rsync hive:calc calc",
            cwd = "/theoryfs2/ds/amwalla3/projects/d4_corrections",
            components = {"default"},
            metadata = {foo = "python"}
        }
    end,
    desc = "Runs main.py",
    tags = {ovr.TAG.BUILD},
    priority = 50,
    condition = {
        callback = function(search)
            print(vim.inspect(search))
            return true
        end
    }
})


ovr.register_template({
    name = "calcToHive",
    builder = function()
        return {
            cmd = {'rsync'},
            args = {"-rP", "calc/", "hive:data/calc"},
            name = "rsync calc/ hive:data/calc",
            cwd = "/theoryfs2/ds/amwalla3/projects/d4_corrections",
            components = {"default"},
            metadata = {foo = "python"}
        }
    end,
    desc = "Runs main.py",
    tags = {ovr.TAG.BUILD},
    priority = 50,
    condition = {
        callback = function(search)
            print(vim.inspect(search))
            return true
        end
    }
})

ovr.register_template({
    name = "mpi4py",
    builder = function()
        return {
            cmd = {'mpiexec'},
            args = {"-n", '4', 'python3', '-u', 'main.py'},
            name = "mpiexec -n N python3 -u main.py",
            -- cwd = "/theoryfs2/ds/amwalla3/projects/d4_corrections",
            components = {"default"},
            metadata = {foo = "python"}
        }
    end,
    desc = "Runs main.py with N processes",
    tags = {ovr.TAG.BUILD},
    priority = 50,
    condition = {
        callback = function(search)
            print(vim.inspect(search))
            return true
        end
    }
})
