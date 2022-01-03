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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Continuously updated session files
Plug 'thaerkh/vim-workspace'

" Completion and syntax of code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Syntax and indentation support
Plug 'sheerun/vim-polyglot'

" Better statusline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'

call plug#end()

" =========================================================================== "
" => Settings

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.8, 'xoffset': 0.5, 'yoffset': 0.0 } }
let g:fzf_preview_window = ['down:70%', 'ctrl-/']
set rtp+=/usr/local/opt/fzf

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
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline.active = {
            \ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
	          \            [ 'percent' ],
	          \            [ 'fileformat', 'fileencoding', 'filetype'] ] }

" => coc
function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! Show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" => workspace
let g:workspace_autocreate = 0
let g:workspace_session_name = 'Session.vim'
let g:workspace_persist_undo_history = 0

