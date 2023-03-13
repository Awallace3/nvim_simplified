-- vim.cmd([[colorscheme dracula]])

-- vim.g.tokyodark_color_gamma = "1.0"
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_italic_comments = true
-- vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}
-- vim.g.tokyonight_dark_float = true
-- vim.g.tokyodark_transparent_background = true
-- vim.g.tokyonight_transparent = true

-- vim.g.neosolarized_contrast = "normal"
-- vim.g.neosolarized_visibility = "normal"
-- vim.g.neosolarized_vertSplitBgTrans = 1
-- vim.g.neosolarized_bold = 1
-- vim.g.neosolarized_underline = 1
-- vim.g.neosolarized_italic = 0
-- vim.g.neosolarized_termBoldAsBright = 1
-- vim.cmd [[
-- colorscheme NeoSolarized
-- ]]
--
-- vim.cmd [[
--     colorscheme onehalflight
-- ]]


require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { },
    functions = {italic = true},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "normal", -- style for sidebars, see below
    floats = "normal", -- style for floating windows
  },
  sidebars = { "qf", "help", "terminal", "vista_kind", "packer" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
-- vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = true, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})
vim.cmd [[colorscheme tokyonight]]
