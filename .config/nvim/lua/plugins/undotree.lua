return {
  -- Undo history visualizer
  {
    'mbbill/undotree',
    config = function ()
      -- [ Undotree ]]
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = '[U]ndotree'})
    end
  }
}
