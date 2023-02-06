require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "lua", "vim", "help", "ruby" },

  sync_install = false,
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}
