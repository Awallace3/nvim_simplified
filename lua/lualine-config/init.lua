require('lualine').setup({
    options = {
        theme = 'tokyonight',
        -- theme = 'night-owl',
        section_separators = '',
        component_separators = ''
    },
    sections = {lualine_x = {"overseer"}},
    extensions = {'nvim-tree'}
})
