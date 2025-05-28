local mappings = {
  n = {
    ["<leader>bp"] = { "<cmd>bp<cr>", desc = "Previous buffer" },
    ["<leader>bn"] = { "<cmd>bn<cr>", desc = "Next buffer" },
    ["<leader>e"] = { "<cmd>Oil<cr>", desc = "Toggle Explorer" },
  },
}

return mappings
