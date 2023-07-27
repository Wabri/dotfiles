-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- NO FUN
vim.keymap.set("n", "Q", "<nop>", { expr = true, silent = true })

-- Move from open windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Save & Exit
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = '[W]rite' })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = '[Q]uit' })

-- Undo in the right way
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- Dont loose focus 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- [[ Source ]]
vim.keymap.set("n", "<leader>st", vim.cmd.so, { desc = '[S]ource [T]his file'})
vim.keymap.set("n", "<leader>ss", ":source $MYVIMRC<CR>", { desc = '[S]ource all configuration'})

-- [[ File ]]
vim.keymap.set("n", "<leader>r", ":e!<CR>", { desc = '[R]eload this file' })
-- vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = 'Open the [E]xplorer' })

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==", { desc = 'Move up the line' })
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==", { desc = 'Move down the line' })

-- [[ Buffers ]]
vim.keymap.set("n", "<leader>bn", vim.cmd.bn, { desc = '[B]uffer [N]ext' })
vim.keymap.set("n", "<leader>bp", vim.cmd.bp, { desc = '[B]uffer [P]revious' })
vim.keymap.set("n", "<leader>bb", ":b#<CR>", { desc = '[B]uffer [B]ack-and-forth' })
vim.keymap.set("n", "<leader>bd", ":bd %<CR>", { desc = '[B]uffer [D]elete open' })

-- [[ Yank ]]
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- Yanking and Pasting to clipboard
vim.keymap.set("n", "<leader>p", "\"+p", { desc = '[P]aste from clipboard' })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = '[Y]ank all selected' })
vim.keymap.set("n", "<leader>yy", "\"+Y", { desc = '[Y]ank all the line' })
vim.keymap.set("n", "<leader>ys", "\"+y", { desc = '[Y]ank and [S]elect' })
vim.keymap.set("n", "<leader>yA", "ggVG\"+Y<C-o>", { desc = '[Y]ank [A]ll the file' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Open floating [D]iagnostic [M]essage" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open [D]iagnostics [L]ist" })

