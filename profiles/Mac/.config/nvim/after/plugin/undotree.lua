require("which-key").register({
    u = {
        name = "Undotree",
        u = { "Toggle"},
    },
}, { prefix = "<leader>" })
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
