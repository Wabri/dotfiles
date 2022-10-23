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
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	" Ruby
	Plug 'neovim/neovim-ruby'

	" Snippets
	Plug 'rafamadriz/friendly-snippets'

	" Code format
	Plug 'sbdchd/neoformat'

	" Fuzzy finder
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	" Colorscheme
	Plug 'andersevenrud/nordic.nvim'

	" Statusline
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'

	" Git wrapper
	Plug 'tpope/vim-fugitive'
	Plug 'rbong/vim-flog'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'sindrets/diffview.nvim'

	" Defaults everyone can agree on
	Plug 'tpope/vim-sensible'
	
	" Continuously updated session files
	Plug 'thaerkh/vim-workspace'

	" Vim-tmux integration
	Plug 'christoomey/vim-tmux-navigator'

	" Colorize all text
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
	local has_words_before = function()
  	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local feedkey = function(key, mode)
  	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

  -- Setup nvim-cmp.
	local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

	cmp.setup {
	  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.fn["vsnip#available"](1) == 1 then
					feedkey("<Plug>(vsnip-expand-or-jump)", "")
				elseif has_words_before() then
					cmp.complete()
				else
					fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
				end
				end, { "i", "s" }),
			["<C-p>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.fn["vsnip#jumpable"](-1) == 1 then
					feedkey("<Plug>(vsnip-jump-prev)", "")
				end
			end, { "i", "s" }),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	  })
	}

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

	-- Setup lsp installer
	require("nvim-lsp-installer").setup({
	ensure_installed = { "ansiblels", "solargraph", "bashls", "pylsp", "gopls" },
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
			}
		}
	})

  -- Setup lspconfig.
	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		-- Mappings.
		local opts = { noremap=true, silent=true }
		
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
		buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
		buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		buf_set_keymap('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		buf_set_keymap('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
EOF

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
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

" => hexokinase
let g:Hexokinase_highlighters = ['sign_column']
set signcolumn=yes:2

