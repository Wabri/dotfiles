local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("which-key").register({
    h = {
        name = "Harpoon",
        a = { "Add"},
        h = { "Menu"},
        ["1"] = { "Goto 1" },
        ["2"] = { "Goto 2" },
        ["3"] = { "Goto 3" },
        ["4"] = { "Goto 4" },
    },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end)
