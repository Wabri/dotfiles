-- Mapleader
vim.g.mapleader = " "
--

-- Source
require("which-key").register({
    s = {
        name = "Source",
        s = { "Reload config"},
        o = { "Source this file"},
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>so", vim.cmd.so)
vim.keymap.set("n", "<leader>ss", ":source $MYVIMRC<CR>")
--


-- File
require("which-key").register({
    r = { "Reload file" },
    e = { "Explorer" },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>r", ":e!<CR>")
vim.keymap.set("n", "<leader>e", ":Explore<CR>")
--

-- Move lines
require("which-key").register({
    j = { "Move line up" },
    k = { "Move line down" },
}, { prefix = "<leader>" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
--

-- Give me the terminal
require("which-key").register({
    t = {
        name = "Terminal",
        t = { "New Terminal"},
        g = { "Lazygit"},
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>tt", ":split | resize 10 | terminal<CR>i")
vim.keymap.set("n", "<leader>tg", ":terminal lazygit<CR>i")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:exit<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
--

-- Dont loose focus 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--

-- Dont loose clipboard
require("which-key").register({
    y = {
        name = "Clipboard",
        y = { "Copy this line"},
        a = { "Copy from here and do"},
        A = { "Copy all the file"},
    },
}, { prefix = "<leader>" })
vim.keymap.set("x", "<leader>yp", "\"_dP")
vim.keymap.set("v", "<leader>yy", "\"+y")
vim.keymap.set("n", "<leader>yy", "\"+Y")
vim.keymap.set("n", "<leader>ya", "\"+y")
vim.keymap.set("n", "<leader>yA", "ggVG\"+Y<C-o>")
--

-- NO FUN
vim.keymap.set("n", "Q", "<nop>")
--

-- Buffers
require("which-key").register({
    b = {
        name = "Buffers",
        n = { "Next"},
        p = { "Previous"},
        b = { "Back-and-forth"},
        d = { "Remove this"},
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bn)
vim.keymap.set("n", "<leader>bp", vim.cmd.bp)
vim.keymap.set("n", "<leader>bb", ":b#<CR>")
vim.keymap.set("n", "<leader>bd", ":bd %<CR>")
--

-- NO FUN
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
--

-- Save & Exit
require("which-key").register({
    w = { "Save" },
    q = { "Quit vim" },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
--

-- Undo in the right way
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
--
