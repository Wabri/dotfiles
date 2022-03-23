""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Wabri <gabriele.puliti@pm.me>                    "
" Alias: Wabri (https://github.com/Wabri)                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" === PLUGINS ===
call plug#begin()
	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" LSP
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	" Ruby
	Plug 'neovim/neovim-ruby'
	" Tabnine
	Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

	" Snippets
	Plug 'rafamadriz/friendly-snippets'

	" Code format
	Plug 'sbdchd/neoformat'

	" Fuzzy finder
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	" Colorscheme
	Plug 'kamwitsta/nordisk'

	" Statusline
	Plug 'nvim-lualine/lualine.nvim'

	" Git wrapper
	Plug 'tpope/vim-fugitive'
	Plug 'rbong/vim-flog'

	" Defaults everyone can agree on
	Plug 'tpope/vim-sensible'
	
	" Continuously updated session files
	Plug 'thaerkh/vim-workspace'

	" Colorize all text
	Plug 'lilydjwg/colorizer'
call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'cmp_tabnine' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
	local servers = { 'solargraph', 'bashls', 'pylsp', 'ansiblels' }
	for _, lsp in pairs(servers) do
	  require('lspconfig')[lsp].setup {
	    on_attach = on_attach,
	    flags = {
	      debounce_text_changes = 150,
	    },
			capabilities = capabilities
	  }
	end

	-- Setup tabnine
	local tabnine = require('cmp_tabnine.config')
	tabnine:setup({
		max_lines = 1000;
		max_num_results = 20;
		sort = true;
		run_on_every_keystroke = true;
		snippet_placeholder = '..';
		ignored_file_types = {
			-- lua = true
		};
	})
EOF

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
"let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 1.0, 'xoffset': 0.0, 'yoffset': 0.0 } }
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" => workspace
let g:workspace_autocreate = 0
let g:workspace_session_name = 'Session.vim'
let g:workspace_persist_undo_history = 1

