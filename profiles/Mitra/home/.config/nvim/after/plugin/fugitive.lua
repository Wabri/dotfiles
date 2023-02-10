require("which-key").register({
    g = {
        name = "Git",
        g = { "Status" },
        c = { "Commit" },
        l = { "Log" },
        d = { "Diff" },
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>gg", ":Git<CR>:only<CR>")
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
vim.keymap.set("n", "<leader>gl", ":Git log<CR>")
vim.keymap.set("n", "<leader>gd", ":Git diff<CR>")
