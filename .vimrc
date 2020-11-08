" => Load plugins
source ~/.vim/plugins/*

" => Color column
set colorcolumn=80

" => Line numbers
set number relativenumber

" => Split
set splitright
set splitbelow

" => Remove swap file
" set noswapfile

" => Set tab 
set expandtab              " Use spaces instead of tabs.
set tabstop=4
set softtabstop=4         " Tab key indents by 2 spaces.
set shiftwidth=4         " >> indents by 2 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

let mapleader=" "

nmap <leader>, :vsplit +e ~/.vimrc <CR>
nmap <leader>. :source ~/.vimrc <CR>

nmap <leader>q :q<CR>
nmap <leader><ESC> :qall<CR>
nmap <leader>w :w<CR>
nmap <leader>ss :w<CR>

nnoremap <leader>a ggVG|" 

nmap <leader>e :e .<CR>
nmap <leader>t :tabnew <CR>
nmap <leader>s :split <CR>
nmap <leader>v :vsplit <CR>

nmap <leader><CR> :vertical terminal<CR>
nmap <leader><leader> :terminal<CR>

nmap <tab> gt
nmap <s-tab> gT

nmap <Leader>b :buffers<CR>:buffer<Space>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprev<CR>

nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

tmap <C-h> <C-W>h
tmap <C-j> <C-W>j
tmap <C-k> <C-W>k
tmap <C-l> <C-W>l

nmap <leader>ss :mksession! %:p:h:t<CR>

nnoremap <leader>r :call RunScript()<CR>
