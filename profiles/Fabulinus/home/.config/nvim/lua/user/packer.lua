vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Leave this here
    use 'wbthomason/packer.nvim'
    --

    -- Utility
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    --

    -- Themes
    use 'shaunsingh/nord.nvim'
    --

    -- File
    use 'mbbill/undotree'
    use({
        'ThePrimeagen/harpoon',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    --

    -- Fuzzy Finder and more
    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    --

    -- Treesitter = generate syntax tree
    use(
    'nvim-treesitter/nvim-treesitter',
    {
        run = ':TSUpdate'
    }
    )
    use('nvim-treesitter/playground')
    --

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
    --
end)
