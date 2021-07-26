" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Tabbing configurations
Plug 'tpope/vim-sleuth'

" Colors
Plug 'kamwitsta/nordisk'

" Fuzzy Finder <- MOST IMPORTANT PLUGIN
if !has('nvim')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
else
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
endif

" Continuously updated session files 
Plug 'tpope/vim-obsession'

" Completion and syntax of code
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Better statusline
Plug 'itchyny/lightline.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

call plug#end()

" =========================================================================== "
" => Settings

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.3, 'height': 0.8, 'xoffset': 0.5, 'yoffset': 0.0 } }
let g:fzf_preview_window = ['down:70%', 'ctrl-/']

" => lightline
set laststatus=2
let g:lightline = { 
      \ 'colorscheme': 'nord',
      \ 'active': {
      \    'left': [ ['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function' : {
      \    'gitbranch': 'FugitiveHead'
      \ },
      \ }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
