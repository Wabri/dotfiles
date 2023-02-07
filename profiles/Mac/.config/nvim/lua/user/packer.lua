vim.cmd [[packadd packer.nvim]]

-- Mapping
require("which-key").register({
    p = {
        name = "Packer",
        s = { "Sync" },
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>ps", vim.cmd.PackerSync)
--

-- List
return require('packer').startup(function(use)
    -- Leave this here
    use 'wbthomason/packer.nvim'
    --

    -- Utility
    use 'nvim-tree/nvim-tree.lua'
    use 'akinsho/toggleterm.nvim'
    use 'folke/which-key.nvim'
    use 'lewis6991/impatient.nvim'
    use 'mbbill/undotree'
    --

    -- Themes
    use 'shaunsingh/nord.nvim'
    use 'nvim-lualine/lualine.nvim'
    --

    -- File
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
    use({
        'nvim-treesitter/nvim-treesitter',
        { run = ':TSUpdate' }
    })
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

