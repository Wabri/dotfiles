local builtin = require('telescope.builtin')

-- FILES
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
--

-- GIT
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
--
