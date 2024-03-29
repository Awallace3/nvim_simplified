-- This is necessary for VimTeX to load properly. The "indent" is optional.
-- Note that most plugin managers will do this automatically.
-- filetype plugin indent on
-- This enables Vim's and neovim's syntax-related features. Without this, some
-- VimTeX features will not work (see ":help vimtex-requirements" for more
-- info).
-- syntax enable
-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = 'zathura'
-- vim.g.vimtex_syntax_packages

-- Or with a generic interface:
vim.g.vimtex_view_general_viewer = 'okular'
-- vim.g.vimtex_compiler_arara = {options = {'--log'}}
-- vim.g.vimtex_compiler_latexmk = {options = {'--log'}}
--
vim.cmd [[
let g:vimtex_quickfix_open_on_warning = 0
]]

-- let g:vimtex_quickfix_ignore_all_warnings = 0
-- let g:vimtex_quickfix_latexlog = {
--       \ 'default' : 1,
--       \ 'general' : 1,
--       \ 'references' : 1,
--       \ 'overfull' : 0,
--       \ 'underfull' : 0,
--       \ 'font' : 1,
--       \ 'packages' : {
--       \   'default' : 0,
--       \   'general' : 0,
--       \   'babel' : 1,
--       \   'biblatex' : 1,
--       \   'fixltx2e' : 1,
--       \   'hyperref' : 1,
--       \   'natbib' : 1,
--       \   'scrreprt' : 1,
--       \   'titlesec' : 0,
--       \ },
--       \}
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    command = "silent VimtexCompileSS",
    -- group = group
    desc = "Compiles Latex"
})
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- strongly recommended, you probably don't need to configure anything. If you
-- want another compiler backend, you can change it as follows. The list of
-- supported backends and further explanation is provided in the documentation,
-- see ":help vimtex-compiler".
-- vim.g.vimtex_compiler_method = 'arara'
vim.g.vimtex_compiler_method = 'latexmk'
-- vim.g.vimtex_compiler_method = ''

-- Most VimTeX mappings rely on localleader and this can be changed with the
-- following line. The default is usually fine and is the symbol "\".
-- let maplocalleader = --,"
