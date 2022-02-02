" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'kamwitsta/nordisk'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Continuously updated session files
Plug 'thaerkh/vim-workspace'

" Syntax and indentation support
Plug 'sheerun/vim-polyglot'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Better statusline
Plug 'itchyny/lightline.vim'

" Completion and syntax of code
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax and indentation support
Plug 'sheerun/vim-polyglot'

call plug#end()

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 1.0, 'xoffset': 1.8, 'yoffset': 0.0 } }
let g:fzf_preview_window = ['down:60%', 'ctrl-/']

" => workspace
let g:workspace_autocreate = 0
let g:workspace_session_name = 'Session.vim'
let g:workspace_persist_undo_history = 1

" => lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'component_function' : {
      \    'gitbranch': 'FugitiveHead'
      \ },
    \ }

" => coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }
