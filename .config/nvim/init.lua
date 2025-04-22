-- Bootstrap Lazy.nvim
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

-- Basic Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- Tabs and Spaces Settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Plugin Setup
require("lazy").setup({
  { "github/copilot.vim" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "kdheepak/lazygit.nvim" },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "nvim-lualine/lualine.nvim" },
  { "AstroNvim/astrotheme" },
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
  { "folke/which-key.nvim" },
  { "echasnovski/mini.icons", version = false },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
  },
  { "lewis6991/gitsigns.nvim" },
  {
    'SuperBo/fugit2.nvim',
    build = false,
    opts = {
      width = 100,
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      {
        'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
        dependencies = { 'stevearc/dressing.nvim' }
      },
    },
    cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
    keys = {
      { '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
    }
  },
})

-- Mini Icons Setup
require("mini.icons").setup()

-- Gitsigns
require('gitsigns').setup()

-- LSP Configuration
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "bashls", "pyright", "html", "cssls", "ts_ls", "perlnavigator" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "gopls", "bashls", "pyright", "html", "cssls", "ts_ls" }
for _, server in ipairs(servers) do
  lspconfig[server].setup({ capabilities = capabilities })
end

lspconfig.perlnavigator.setup{ cmd = { "perlnavigator" } }

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- nvim-cmp Setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      local ls = require("luasnip")
      ls.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({ { name = "nvim_lsp" } }),
})
require("luasnip.loaders.from_vscode").lazy_load()


-- Treesitter Setup
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "bash", "python", "html", "css", "javascript", "lua", "perl" },
  highlight = { enable = true },
})

-- Lualine Setup
require("lualine").setup({ options = { theme = "auto" } })

-- nvim-tree Setup
require("nvim-tree").setup()

-- toggleterm Setup
require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
})

-- Telescope Setup
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
})

-- Astrotheme Setup
require("astrotheme").setup({
  palette = "astrodark",
  background = { light = "astrolight", dark = "astrodark" },
  termguicolors = true,
  terminal_color = true,
})
vim.cmd("colorscheme astrodark")

-- Noice Setup
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

-- Which-Key Setup
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

-- Keybindings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Keybindings::helpers
function ToggleDiagnosticSigns()
  diagnostic = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({signs = diagnostic})
  vim.diagnostic.config({virtual_text = diagnostic})
end 

-- basic telescope configuration
local harpoon = require('harpoon')
harpoon:setup({})
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

local function copy_file_name()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
  print("File name copied to clipboard: " .. file_name)
end

-- Keybindings::Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

wk.add({
  -- File Explorer
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer", mode = "n" },

  -- Telescope
  { "<leader>f", group = "Files" }, -- group
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Grep Words", mode = "n" },

  -- Buffers
  { "<leader>b", group = "Buffers" }, -- group
  { "<leader>bb", "<C-^>", desc = "Switch Buffer", mode = "n" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer", mode = "n" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer", mode = "n" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close Buffer", mode = "n" },

  -- Terminal
  { "<leader>t", group = "Terminal" }, -- group
  { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = "n" },

  -- Miscellaneous
  {
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  },

  -- Yank
  {
    { "<leader>y", group = "Yank" }, -- group
    { "<leader>yf", function() copy_file_name() end, desc = "Copy File Name" },
  },

  -- GIT
  { "<leader>g", group = "Git" }, -- group
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit", mode = "n" },
  { "<leader>gb", "<cmd>Gitsigns blame<cr>", desc = "Toggle blame", mode = "n" },

  -- UI
  { "<leader>u", group = "UI" }, -- group
  { "<leader>ud", ToggleDiagnosticSigns, desc = "Toggle diagnostic signs", mode = "n" },

  -- Harpoon
  { "<leader>hf", function() toggle_telescope(harpoon:list()) end, desc = "File Harpoon", mode = "n"},
  { "<leader>ha", function() harpoon:list():add() end, desc = "Harpoon current file",mode = "n"},
  { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "List all the harpooned files",mode = "n"},
  { "<leader>h1", function() harpoon:list():select(1) end, desc = "GoTo 1",mode = "n"},
  { "<leader>h2", function() harpoon:list():select(2) end, desc = "GoTo 2",mode = "n"},
  { "<leader>h3", function() harpoon:list():select(3) end, desc = "GoTo 3",mode = "n"},
  { "<leader>h4", function() harpoon:list():select(4) end, desc = "GoTo 4",mode = "n"},
  { "<leader>hp", function() harpoon:list():prev() end, desc = "GoTo previous",mode = "n"},
  { "<leader>hn", function() harpoon:list():next() end, desc = "GoTo next",mode = "n"},
})

