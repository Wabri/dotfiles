local lsp = require('lsp-zero')
lsp.preset('recommended')

local cmp = require('cmp')

lsp.setup_nvim_cmp({
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.complete(),
  })
})

lsp.setup()
