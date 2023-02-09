local builtin = require('telescope.builtin')

require("which-key").register({
    f = {
        name = "Telescope",
        f = { "Find Files"},
        s = { "Search string"},
        S = { "Live search string"},
        g = { "Find Git Files"},
        d = { "Diagnostics"},
        c = { "Treesitter"},
    },
}, { prefix = "<leader>" })
-- FILES
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fS', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- GIT
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
-- LSP
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fc', builtin.treesitter, {})
