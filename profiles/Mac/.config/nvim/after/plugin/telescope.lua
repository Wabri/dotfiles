local builtin = require('telescope.builtin')

require("which-key").register({
    f = {
        name = "Telescope",
        f = { "Find Files"},
        s = { "Search string"},
        g = { "Find Git Files"},
    },
}, { prefix = "<leader>" })
-- FILES
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- GIT
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

