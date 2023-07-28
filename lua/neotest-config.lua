local nt = require("neotest")

nt.setup({
    adapters = {
        require("neotest-python")({
            dap = {justMyCode = true},
            args = {"--log-level", "DEBUG"},
            runner = "pytest",
            -- is_test_file = function(file_path)
            --     return file_path:match("*test_.*%.py$") ~= nil
            -- end,
        })
    },
    discovery = {
      concurrent = 1,
      enabled = true,
      -- filter_dir = function ()
      --   return {name = "tests", rel_path = "./"}
      -- end,
    },
    floating = {
      border = "rounded",
      max_height = 0.9,
      max_width = 0.8,
      options = {}
    },
    icons={
      passed = "",
      running = "",
      failed = "",
      unknown = "",
    },
    quickfix = {open=false},
    output = {open_on_run=false},
    lazy=true,
})
nt.state.adapter_ids()
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
keymap('n', '[j', '<CMD>lua require("neotest").jump.next({status = "failed"})<CR>', opts)
keymap('n', ']j', '<CMD>lua require("neotest").jump.prev({status = "failed"})<CR>', opts)



-- Parameters~
-- {user_config} `(neotest.Config)`
--
-- Default values:
-- >lua
--   {
--     adapters = {},
--     benchmark = {
--       enabled = true
--     },
--     consumers = {},
--     default_strategy = "integrated",
--     diagnostic = {
--       enabled = true,
--       severity = 1
--     },
--     discovery = {
--       concurrent = 0,
--       enabled = true
--     },
--     floating = {
--       border = "rounded",
--       max_height = 0.6,
--       max_width = 0.6,
--       options = {}
--     },
--     highlights = {
--       adapter_name = "NeotestAdapterName",
--       border = "NeotestBorder",
--       dir = "NeotestDir",
--       expand_marker = "NeotestExpandMarker",
--       failed = "NeotestFailed",
--       file = "NeotestFile",
--       focused = "NeotestFocused",
--       indent = "NeotestIndent",
--       marked = "NeotestMarked",
--       namespace = "NeotestNamespace",
--       passed = "NeotestPassed",
--       running = "NeotestRunning",
--       select_win = "NeotestWinSelect",
--       skipped = "NeotestSkipped",
--       target = "NeotestTarget",
--       test = "NeotestTest",
--       unknown = "NeotestUnknown",
--       watching = "NeotestWatching"
--     },
--     icons = {
--       child_indent = "│",
--       child_prefix = "├",
--       collapsed = "─",
--       expanded = "╮",
--       failed = "",
--       final_child_indent = " ",
--       final_child_prefix = "╰",
--       non_collapsible = "─",
--       passed = "",
--       running = "",
--       running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
--       skipped = "",
--       unknown = "",
--       watching = ""
--     },
--     jump = {
--       enabled = true
--     },
--     log_level = 3,
--     output = {
--       enabled = true,
--       open_on_run = "short"
--     },
--     output_panel = {
--       enabled = true,
--       open = "botright split | resize 15"
--     },
--     projects = {},
--     quickfix = {
--       enabled = true,
--       open = false
--     },
--     run = {
--       enabled = true
--     },
--     running = {
--       concurrent = true
--     },
--     state = {
--       enabled = true
--     },
--     status = {
--       enabled = true,
--       signs = true,
--       virtual_text = false
--     },
--     strategies = {
--       integrated = {
--         height = 40,
--         width = 120
--       }
--     },
--     summary = {
--       animated = true,
--       enabled = true,
--       expand_errors = true,
--       follow = true,
--       mappings = {
--         attach = "a",
--         clear_marked = "M",
--         clear_target = "T",
--         debug = "d",
--         debug_marked = "D",
--         expand = { "<CR>", "<2-LeftMouse>" },
--         expand_all = "e",
--         jumpto = "i",
--         mark = "m",
--         next_failed = "J",
--         output = "o",
--         prev_failed = "K",
--         run = "r",
--         run_marked = "R",
--         short = "O",
--         stop = "u",
--         target = "t",
--         watch = "w"
--       },
--       open = "botright vsplit | vertical resize 50"
--     },
--     watch = {
--       enabled = true,
--       symbol_queries = {
--         elixir = <function 1>,
--         lua = '        ;query\n        ;Captures module names in require calls\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n      ',
--         python = "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol))\n        (import_statement (_ (identifier) @symbol))\n      "
--       }
--     }
--   }
-- <
