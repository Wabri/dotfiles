" =========================================================================== "
" => Plugins
call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'kamwitsta/nordisk'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
