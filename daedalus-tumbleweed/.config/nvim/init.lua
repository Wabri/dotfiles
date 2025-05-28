-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.o.scrolloff = 10

-- Tabs and Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- PackageManagement:Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- PackageManagement:LazyPlugins
require("lazy").setup({
  -- LSP
  { "github/copilot.vim" },
  -- { "neovim/nvim-lspconfig" },
  -- { "williamboman/mason.nvim", build = ":MasonUpdate" },
  -- { "williamboman/mason-lspconfig.nvim" },
  -- { "hrsh7th/nvim-cmp" },
  -- { "hrsh7th/cmp-nvim-lsp" },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   lazy = true,
  --   dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
  --   opts = {
  --     history = true,
  --     delete_check_events = "TextChanged",
  --     region_check_events = "CursorMoved",
  --   },
  -- },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  -- UI
  { "folke/which-key.nvim" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  { "nvim-lualine/lualine.nvim" },
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
  { "echasnovski/mini.icons", version = false },

  -- Themes
  { "AstroNvim/astrotheme" },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = "dark"
        require("astrotheme").setup({
          palette = "astrodark",
          background = {
            dark = "astrodark",
          },
        })
        vim.cmd("colorscheme astrodark")
      end,
      set_light_mode = function()
        vim.o.background = "light"
        require("astrotheme").setup({
          palette = "astrolight",
          background = {
            light = "astrolight",
          },
        })
        vim.cmd("colorscheme astrolight")
      end,
    }
  }
})

-- UI

-- UI:Noice
require("noice").setup({
  -- lsp = {
  --   override = {
  --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --     ["vim.lsp.util.stylize_markdown"] = true,
  --     ["cmp.entry.get_documentation"] = true,
  --   },
  -- },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = false,
  },
})

-- UI:MiniIcons
require("mini.icons").setup()

-- UI:Gitsigns
require('gitsigns').setup()

-- UI:Lualine
require("lualine").setup({ options = { theme = "auto" } })

-- LSP

-- LSP:mason
-- require("mason").setup()
-- require("mason-lspconfig").setup({
--   ensure_installed = { "gopls", "bashls", "pyright", "html", "cssls", "ts_ls", "perlnavigator" },
-- })

-- LSP:lspconfig
-- local lspconfig = require("lspconfig")
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local servers = { "gopls", "bashls", "pyright", "html", "cssls", "ts_ls" }
-- for _, server in ipairs(servers) do
--   lspconfig[server].setup({ capabilities = capabilities })
-- end
--
-- lspconfig.perlnavigator.setup{ cmd = { "perlnavigator" } }
--
-- -- LSP:cmp
-- local cmp = require("cmp")
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       local ls = require("luasnip")
--       ls.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--   }),
--   sources = cmp.config.sources({ { name = "nvim_lsp" } }),
-- })
--
-- -- LSP:luasnip
-- require("luasnip.loaders.from_vscode").lazy_load()
--
-- LSP:treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "bash", "python", "html", "css", "javascript", "lua", "perl" },
  highlight = { enable = true },
})

-- Harpoon
local harpoon = require("harpoon")
harpoon.setup()

-- Keybindings

-- Keybindings::snacks
local snacks = require("snacks")

-- Keybindings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Keybindings::WhichKey
local wk = require("which-key")
wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
  },
  win = { border = "single" },
  layout = { spacing = 6 },
})

-- Keybindings::helpers
function ToggleDiagnosticSigns()
  diagnostic = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({signs = diagnostic})
  vim.diagnostic.config({virtual_text = diagnostic})
end 

local function copy_file_name()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
  print("File name copied to clipboard: " .. file_name)
end

wk.add({
  -- Keymaps:LSP
  { "gd", function() snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  { "gD", function() snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
  { "gr", function() snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  { "gI", function() snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },

  -- Keymaps:Navigation
  { "<C-h>", "<C-w>h", desc = "Move to left window", mode = "n" },
  { "<C-j>", "<C-w>j", desc = "Move to lower window", mode = "n" },
  { "<C-k>", "<C-w>k", desc = "Move to upper window", mode = "n" },
  { "<C-l>", "<C-w>l", desc = "Move to right window", mode = "n" },

  -- Keymaps:NvimTree
  { "<leader>e", function() snacks.explorer() end, desc = "File Explorer", mode = "n" },

  -- Keymaps:Pickers
  { "<leader>f", group = "Find" }, -- group
  { "<leader>ff", function() snacks.picker.files { hidden = false, ignored = true } end, desc = "File", mode = "n" },
  { "<leader>fF", function() snacks.picker.files { hidden = true, ignored = true } end, desc = "Hidden File", mode = "n" },
  { "<leader>fw", function() snacks.picker.grep() end, desc = "Grep" },
  { "<leader>fW", function() snacks.picker.grep { hidden = true, ignored = true } end, desc = "Grep" },
  { "<leader>fc", function() snacks.picker.colorschemes() end, desc = "Colorschemes" },
  { "<leader>fu", function() snacks.picker.undo() end, desc = "Undo tree" },

  -- Keymaps:Buffers
  { "<leader>b", group = "Buffers" }, -- group
  { "<leader>bb", "<C-^>", desc = "Back-n-Forth", mode = "n" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next", mode = "n" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous", mode = "n" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close", mode = "n" },
  { "<leader>bf", function() snacks.picker.buffers() end, desc = "Find", mode = "n" },

  -- Keymaps:Miscellaneous
  {
    mode = { "n", "v" },
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  },

  -- Keymaps:Yank
  {
    { "<leader>y", group = "Yank" }, -- group
    { "<leader>yf", function() copy_file_name() end, desc = "Copy File Name" },
  },

  -- Keymaps:Git
  { "<leader>g", group = "Git" }, -- group
  { "<leader>gg", function() snacks.lazygit() end, desc = "Lazygit" },
  { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Toggle blame", mode = "n" },

  -- Keymaps:UI
  { "<leader>u", group = "UI" }, -- group
  { "<leader>ud", ToggleDiagnosticSigns, desc = "Toggle diagnostic signs", mode = "n" },

  -- Keymaps:Harpoon
  { "<leader>ha", function() harpoon:list():add() end, desc = "Harpoon current file",mode = "n"},
  { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "List all the harpooned files",mode = "n"},
  { "<leader>h1", function() harpoon:list():select(1) end, desc = "GoTo 1",mode = "n"},
  { "<leader>h2", function() harpoon:list():select(2) end, desc = "GoTo 2",mode = "n"},
  { "<leader>h3", function() harpoon:list():select(3) end, desc = "GoTo 3",mode = "n"},
  { "<leader>h4", function() harpoon:list():select(4) end, desc = "GoTo 4",mode = "n"},
  { "<leader>hp", function() harpoon:list():prev() end, desc = "GoTo previous",mode = "n"},
  { "<leader>hn", function() harpoon:list():next() end, desc = "GoTo next",mode = "n"},
})

