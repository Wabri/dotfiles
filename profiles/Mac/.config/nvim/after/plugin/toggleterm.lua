require("toggleterm").setup({
  size = 10,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

-- Mapping
require("which-key").register({
    t = {
        name = "Terminal",
        t = { "New Terminal"},
        g = { "LazyGit"},
    },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>")
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

