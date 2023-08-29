require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "html", "javascript", "lua", "python", "c", "fortran", "markdown", "cpp", "julia",
        "markdown_inline", "json", "toml", "yaml", "latex", "css", "htmldjango", },
    highlight = { enable = true, additional_vim_regex_highlighting = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 3000,
    },
    disable = { "latex" }
}
