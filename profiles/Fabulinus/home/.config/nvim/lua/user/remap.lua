-- Mapleader
vim.g.mapleader = " "
--

-- Source
vim.keymap.set("n", "<leader>so", vim.cmd.so)
vim.keymap.set("n", "<leader>ss", ":source $MYVIMRC<CR>")
--

-- File
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>r", ":e!<CR>")
--

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
--

-- Give me the terminal
vim.keymap.set("n", "<leader>tt", ":terminal<CR>")
vim.keymap.set("n", "<leader>tg", ":terminal lazygit<CR>")

-- Dont loose focus 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--

-- Dont loose clipboard
vim.keymap.set("x", "<leader>yp", "\"_dP")
vim.keymap.set("v", "<leader>yy", "\"+y")
vim.keymap.set("n", "<leader>yy", "\"+y")
vim.keymap.set("n", "<leader>ya", "\"+Y")
vim.keymap.set("n", "<leader>yA", "ggVG\"+Y<C-o>")
--

-- NO FUN
vim.keymap.set("n", "Q", "<nop>")
--

-- Buffers
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
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
--

-- Packer
vim.keymap.set("n", "<leader>ps", vim.cmd.PackerSync)
--

-- Undo in the right way
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
--
