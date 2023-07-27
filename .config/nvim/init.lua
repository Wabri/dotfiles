vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")
require("config.keymaps")
require("config.lsp")
require("config.options")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
