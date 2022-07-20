local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use 'tpope/vim-surround'
    use 'windwp/nvim-autopairs'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        highlight = {enable = true}
    }
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
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
                ['.md'] = 'markdown',
                ['.markdown'] = 'markdown',
                ['.mdown'] = 'markdown'
            }
        end
    }
    use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'neovim/nvim-lspconfig'
    use({
        "hrsh7th/nvim-cmp",
        requires = {{"kdheepak/cmp-latex-symbols"}},
        sources = {{name = "latex_symbols"}}
    })
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use {'L3MON4D3/LuaSnip'}
    use 'onsails/lspkind-nvim'
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },
                sources = {
                    {name = 'luasnip'}
                }
            }
        end
    }
    use { 'saadparwaiz1/cmp_luasnip' }

    use {"ray-x/lsp_signature.nvim"}

    use {'folke/which-key.nvim'}
    --use {'tami5/lspsaga.nvim', config = "require('lspsaga-config')"}

--    use({
--    "glepnir/lspsaga.nvim",
--    branch = "main",
--    config = function()
--        local saga = require("lspsaga")
--
--        saga.init_lsp_saga({
--            -- your configuration
--        })
--    end,
--})

    use 'p00f/nvim-ts-rainbow'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'sbdchd/neoformat'}
    use 'akinsho/toggleterm.nvim'
    use {'preservim/nerdtree', requires = {'Xuyuanp/nerdtree-git-plugin'}}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    use({

    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        -- change the lsp symbol kind
        local kind = require('lspsaga.lspkind')
        kind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

        saga.init_lsp_saga()
    end,
})

end)
