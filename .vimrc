" VIMRC

" === PLUGINS ===
source ~/.vim/plugins.vim

" === SETTINGS ===

" => No swap file
set noswapfile

" => Relative Number
set number relativenumber

" => Search
set incsearch ignorecase

" === NETRW ===
let g:netrw_banner = 0

" === COLORSCHEME ===
colorscheme nordisk

" === MAPPING ===

" => Mapleader
let mapleader=" "

" => Vimrc
nnoremap <leader>, :e ~/.vimrc<CR>
nnoremap <leader>. :source ~/.vimrc<CR>

" => Buffers
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>

" => Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" => NETRW
nnoremap <leader>e :e .<CR>
