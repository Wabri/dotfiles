local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require('cmp')

lsp.setup_nvim_cmp()

lsp.setup()
