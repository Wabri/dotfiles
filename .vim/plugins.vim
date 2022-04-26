" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'kamwitsta/nordisk'

" Colorized for hexa colors
Plug 'BourgeoisBear/clrzr'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Syntax and indentation support
Plug 'sheerun/vim-polyglot'

" Git wrapper
Plug 'tpope/vim-fugitive'

" VimWiki
Plug 'vimwiki/vimwiki'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" => fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
"let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 1.0, 'xoffset': 0.0, 'yoffset': 0.0 } }
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" => vimwiki
let g:vimwiki_list = [{'path': '~/Documents/Personal/Wiki'}]

