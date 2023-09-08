local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'shaunsingh/solarized.nvim'
    use 'oxfist/night-owl.nvim'
    -- install without yarn or npm
    -- markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end
    })
    use {
        "gpanders/vim-medieval"
    }
    use { 'norcalli/nvim-colorizer.lua' }
    use { 'lervag/vimtex' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        highlight = { enable = true }
    }
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    use 'p00f/nvim-ts-rainbow'
    use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
    use { "chipsenkbeil/vimwiki-server.nvim" }
    use {
        'vimwiki/vimwiki',
        config = function()
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
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use 'onsails/lspkind-nvim'
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'rafamadriz/friendly-snippets' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/vim-vsnip' }
    use {
        'hrsh7th/nvim-cmp',
        requires = { { "kdheepak/cmp-latex-symbols", "hrsh7th/cmp-path" } },
        -- config = function()
        --     require'cmp'.setup {
        --         snippet = {
        --             expand = function(args)
        --                 require'luasnip'.lsp_expand(args.body)
        --             end
        --         },
        --         sources = {{name = 'luasnip'}}
        --     }
        -- end,
        sources = { { name = "latex_symbols" } }
    }
    use { "ray-x/lsp_signature.nvim" }
    use { 'folke/which-key.nvim' }
    use {
        'nvim-lualine/lualine.nvim'
        -- requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'mhartington/formatter.nvim'

    use 'akinsho/toggleterm.nvim'
    use { 'preservim/nerdtree', requires = { 'Xuyuanp/nerdtree-git-plugin' } }
    -- use({
    --     "glepnir/lspsaga.nvim",
    --     branch = "main",
    --     config = function() require('lspsaga').setup({}) end
    -- })
    use { "github/copilot.vim" }
    use { 'RRethy/vim-illuminate' }
    -- git integration
    use { 'airblade/vim-gitgutter' }
    -- use {'jreybert/vimagit'}
    use { 'NeogitOrg/neogit',
        requires = 'nvim-lua/plenary.nvim',
        commit = "6375d1a450ea244b517e9be9102c8d18905b332a"
    }

    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-rhubarb' }

    -- debugger
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    -- comments
    use { 'terrortylor/nvim-comment' }
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function() require("lsp_lines").setup() end
    })
    use 'ryanoasis/vim-devicons'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    use 'dhruvasagar/vim-table-mode'
    use {
        'stevearc/overseer.nvim',
        config = function() require('overseer').setup() end
    }
    use { "rcarriga/nvim-notify" }
    use 'rhysd/conflict-marker.vim'
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python"
        }
    }
    -- use {
    --     'chipsenkbeil/distant.nvim',
    --     branch = 'v0.3',
    --     config = function()
    --         require('distant'):setup()
    --     end
    -- }
    use { 'ThePrimeagen/harpoon' }

    -- use { 'bennypowers/nvim-regexplainer',
    --   requires = {
    --     'nvim-treesitter/nvim-treesitter',
    --     'MunifTanjim/nui.nvim',
    --   } }
    --   dadbod
    use {
        "tpope/vim-dadbod",
        opt = true,
        requires = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = function()
            require("dadbod").setup()
        end,
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }
end)
