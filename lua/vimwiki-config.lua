--
-- let g:vimwiki_list = [{'auto_diary_index': 1}]
-- let g:vimwiki_global_ext = 0
-- let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
vim.g.vimwiki_auto_diary_index = 1
vim.g.vimwiki_global_ext = 0

vim.g.vimwiki_listsyms = '✗○◐●✓'

vim.g.vimwiki_list = {
    {
        path = '~/vimwiki',
        template_path = 'default',
        template_default = 'default',
        css_name = '/Users/austinwallace/vimwiki/style.css',
        syntax = 'markdown',
        ext = '.md',
        path_html = '~/vimwiki',
        custom_wiki2html = 'vimwiki_markdown',
        template_ext = '.tpl'
    }
}
vim.g.vimwiki_ext2syntax = {
    ['.md'] = 'markdown'
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "md", "vimwiki" },
    callback = function()
        vim.api.nvim_command('setlocal spell spelllang=en_us')
        vim.api.nvim_command('set spellsuggest+=10')
        vim.api.nvim_command('set filetype=markdown')
    end
})

-- vim.cmd("set nocompatible")
-- vim.cmd("filetype plugin on")
-- vim.cmd("syntax on")
