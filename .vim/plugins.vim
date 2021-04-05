call plug#begin('~/.vim/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Tabbing configurations
Plug 'tpope/vim-sleuth'

" Colors
Plug 'arcticicestudio/nord-vim'

" Fuzzy Finder <- MOST IMPORTANT PLUGIN
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 
Plug 'dyng/ctrlsf.vim'

" Distraction-free mode
Plug 'junegunn/goyo.vim'

" Continuously updated session files 
Plug 'tpope/vim-obsession'

" Completion and syntax of code
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Highlight of code
Plug 'sheerun/vim-polyglot'

" Undo history visualizer
Plug 'mbbill/undotree'

" Better statusline
Plug 'itchyny/lightline.vim'

call plug#end()

