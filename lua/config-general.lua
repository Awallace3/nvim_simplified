vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
-- vim.g.vimtex_compiler_method = "latexrun"
vim.g.vimtex_compiler_method = "arara"
-- vim.o.winbar = nil

-- vim.g.syntax_on = true
vim.cmd[[
    set nocompatible
    filetype plugin on
    syntax on
]]

vim.opt_local.suffixesadd:prepend('.lua')
vim.opt_local.suffixesadd:prepend('init.lua')
vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')
vim.g.python3_host_prog = vim.fn.expand("~/miniconda3/envs/nvim/bin/python")

vim.diagnostic.config({
    virtual_text = false
})

vim.cmd [[ set mouse-=]]

-- vim.api.nvim_command('setlocal spell spelllang=en_us')
--
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex"},
    callback = function()
        vim.api.nvim_command('setlocal spell spelllang=en_us')
        vim.api.nvim_command('set spellsuggest+=10')
        -- vim.api.nvim_command('set filetype=markdown')

        -- vim.g.languagetool_server_jar =
        --     "/usr/local/Cellar/languagetool/5.7/libexec/languagetool-server.jar"
        -- vim.g.languagetool_server_command = "echo Server Started"
    end
})
-- vim.g.vimwiki_listsyms = '✗○◐●✓'
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"md", "vimwiki"},
    callback = function()
        vim.api.nvim_command('setlocal spell spelllang=en_us')
        vim.api.nvim_command('set spellsuggest+=10')
        vim.api.nvim_command('set filetype=markdown')

        -- vim.g.languagetool_server_jar =
        --     "/usr/local/Cellar/languagetool/5.7/libexec/languagetool-server.jar"
        -- vim.g.languagetool_server_command = "echo Server Started"
    end
})
vim.g.vimwiki_global_ext=0
-- vim.cmd("set nocompatible")
-- vim.cmd("filetype plugin on")
-- vim.cmd("syntax on")

vim.o.scrolloff = 8


vim.cmd [[
    set splitright
    autocmd BufWritePre *\(.md\|.diffs\|\wmain.py\)\@<! :%s/\s\+$//e
]]

--" Add the current file's directory to the path if not already present.
vim.cmd [[
let s:default_path = escape(&path, '\ ') " store default value of 'path'

" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path
]]

-- autocmd BufWritePre * :%s/\s\+$//e
-- vim.cmd [[
-- let &t_ZH="\e[3m"
-- let &t_ZR="\e[23m"
-- ]]
vim.cmd [[
    let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
]]


-- vim-table-mode
--

