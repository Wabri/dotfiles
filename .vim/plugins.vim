" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'kamwitsta/nordisk'
Plug 'edeneast/nightfox.nvim'

" Colorized for hexa colors
Plug 'BourgeoisBear/clrzr'

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
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ 'colorscheme': 'nightfox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'bufnum' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
      \ },
      \ }

" => COC
let g:coc_global_extensions = ['coc-git', 'coc-yaml', 'coc-vimlsp', 'coc-marketplace', '@yaegassy/coc-ansible', 'coc-sh', 'coc-tabnine', 'coc-jedi']

let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

