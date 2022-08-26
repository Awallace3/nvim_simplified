require('lualine').setup({
    options = {
        theme = 'tokyonight',
        section_separators = '',
        component_separators = ''
    },
    sections = {lualine_x = {"overseer"}},
    extensions = {'nvim-tree'}
})
