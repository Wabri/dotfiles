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
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
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
            bigfile = { 
                enabled = true,
                notify = true
            },
            dashboard = { 
                enabled = true,
                -- width = 80,
                preset = {
                    keys = {
                        { icon = "󰀱 ", key = "h", desc = "Harpoon", action = "<leader>hh" },
                        { icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
                        { icon = "󰜏 ", key = "w", desc = "Find Text", action = "<leader>fW" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    {
                        icon = "󰉹 ",
                        title = "Working Directory",
                        section = "terminal",
                        cmd = "pwd",
                        height = 1,
                        padding = 1,
                        action = "<leader>e",
                        key = "e"
                    },
                    { 
                        section = "keys", 
                        gap = 1, 
                        padding = 1 
                    },
                    { section = "startup" },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 1,
                        padding = 1,
                        action = "<leader>gg",
                        key = "g"
                    },
                    {
                        pane = 2,
                        height = 3,
                        icon = " ",
                        title = "Docker ps",
                        section = "terminal",
                        cmd = "docker ps | tail -n +2",
                    },
                    {
                        pane = 2,
                        height = 3,
                        icon = " ",
                        title = "Podman ps",
                        section = "terminal",
                        cmd = "podman ps | tail -n +2",
                    },
                    {
                        pane = 2,
                        height = 3,
                        icon = "󰆧 ",
                        title = "Distrobox ls",
                        section = "terminal",
                        cmd = "distrobox ls | tail -n +2",
                    },
                    -- {
                    --     pane = 3,
                    --     icon = "󰜘 ",
                    --     title = "Git Logs",
                    --     section = "terminal",
                    --     enabled = function()
                    --         return Snacks.git.get_root() ~= nil
                    --     end,
                    --     cmd = "git log --oneline --graph",
                    --     height = 15,
                    --     padding = 1,
                    -- },
                },
            },
            dim = { enable = true },
            explorer = { 
  replace_netrw = true, -- Replace netrw with the snacks explorer
 },
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
    {
        'developedbyed/marko.nvim',
        config = function()
            require('marko').setup({
                width = 100,
                height = 100,
                border = "rounded",
                title = " Marks ",
            })
        end,
    },
    { "nvim-lualine/lualine.nvim" },
    { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" } },
    { "echasnovski/mini.icons", version = false },

    -- Themes
    { "ellisonleao/gruvbox.nvim" },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.o.background = "dark"
                vim.cmd("colorscheme gruvbox")
            end,
            set_light_mode = function()
                vim.o.background = "light"
                vim.cmd("colorscheme gruvbox")
            end,
        }
    }
})

-- UI

-- UI:Noice
require("noice").setup({
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

    -- Keymaps:Dim
    { "zd", function() snacks.dim.enable() end, desc = "Dimming enable" },
    { "zD", function() snacks.dim.disable() end, desc = "Dimming disabled" },

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

