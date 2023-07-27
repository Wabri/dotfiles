return {
  { -- theme
    "catppuccin/nvim", name = "catppuccin",
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
