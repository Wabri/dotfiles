local mappings = {
  n = {
    ["<leader>bp"] = { "<cmd>bp<cr>", desc = "Previous buffer" },
    ["<leader>bn"] = { "<cmd>bn<cr>", desc = "Next buffer" },
    ["<leader><leader>1"] = { function() require("harpoon.ui").nav_file(1) end, desc = "Go to 1" },
    ["<leader><leader>2"] = { function() require("harpoon.ui").nav_file(2) end, desc = "Go to 2" },
    ["<leader><leader>3"] = { function() require("harpoon.ui").nav_file(3) end, desc = "Go to 3" },
    ["<leader><leader>4"] = { function() require("harpoon.ui").nav_file(4) end, desc = "Go to 4" },
  },
}

return mappings
