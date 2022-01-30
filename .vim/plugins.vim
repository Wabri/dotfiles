" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'kamwitsta/nordisk'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Continuously updated session files
Plug 'thaerkh/vim-workspace'

" Syntax and indentation support
Plug 'sheerun/vim-polyglot'

" Git wrapper
Plug 'tpope/vim-fugitive'

call plug#end()

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.8, 'xoffset': 0.5, 'yoffset': 0.0 } }
let g:fzf_preview_window = ['down:70%', 'ctrl-/']

" => workspace
let g:workspace_autocreate = 0
let g:workspace_session_name = 'Session.vim'
let g:workspace_persist_undo_history = 1
