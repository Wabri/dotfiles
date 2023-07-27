return {
  -- Git related plugins
  { 'tpope/vim-fugitive',
    config = function()
      -- [[ Fugitive ]]
      vim.keymap.set("n", "<leader>gg", ":Git<CR>:only<CR>", { desc = '[G]it dashboard'})
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = '[G]it [C]ommit'})
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = '[G]it [L]og'})
      vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { desc = '[G]it [D]iff'})
    end,
  },
}
--

