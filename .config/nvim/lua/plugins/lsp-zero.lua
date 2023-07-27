return {
  { -- LSP Configuration & Plugins
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      { 'williamboman/mason.nvim',
        config = function()
          require("mason").setup({
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
          -- [[ Mason ]]
          vim.keymap.set("n", "<leader>mm", vim.cmd.Mason, { desc = 'Package [M]anager lsp with [M]ason'})
        end
      },
      { 'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = true,
        },
        setup_jsonls = true,
        lspconfig = true,
        pathStrict = true,
      } },
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.setup()
    end
  },
}
