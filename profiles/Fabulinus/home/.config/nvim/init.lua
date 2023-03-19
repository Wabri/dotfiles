vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("user.packages")
require("user.settings")
require("user.keymaps")
require("user.lsp")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
