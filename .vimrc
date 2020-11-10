" =========================================================================== "
" => PLUGINS

" => Load Personal plugins
call plug#begin('~/.vim/plugged')

    " Colorscheme
    Plug 'joshdick/onedark.vim'

    " Fuzzy Finder <= MOST IMPORTANT PLUGIN
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

call plug#end()

" => Load Personal plugins
source ~/.vim/plugins/*

" =========================================================================== "
" => THEMES

" => Colorschemes
colorscheme onedark

" => Color column
set colorcolumn=80
set cursorcolumn


" =========================================================================== "
" => SETTINGS

" => Line numbers
set number relativenumber

" => Split
set splitright
set splitbelow

" => Remove swap file
" set noswapfile

" => Set tab 
set expandtab       " Use spaces instead of tabs.
set tabstop=4
set softtabstop=4   " Tab key indents by 2 spaces.
set shiftwidth=4    " >> indents by 2 spaces.
set shiftround      " >> indents to next multiple of 'shiftwidth'.


" =========================================================================== "
" => MAPPING

" => Mapleader
let mapleader=" "

" => Help
nmap <leader>? :Maps<CR>

" => Vimrc
nmap <leader>, :vsplit +e ~/.vimrc <CR>
nmap <leader>. :source ~/.vimrc <CR>

" => Easy quit and save
nmap <leader>q :q<CR>
nmap <leader><ESC> :qall<CR>
nmap <leader>w :w<CR>

" => Shortcut
nnoremap <leader>a ggVG|" 

" => Directory tree 
nmap <leader>e :e .<CR>

" => Files search
nmap <leader>f :Files<CR>

" => New 
nmap <leader>t :tabnew <CR>
nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>

" => Terminal
nmap <leader><CR> :vertical terminal<CR>
nmap <leader><leader> :terminal<CR>

" => Tabs
nmap <tab> gt
nmap <s-tab> gT

" => Buffers
" nmap <Leader>b :buffers<CR>:buffer<Space>
nmap <Leader>b :Buffers<CR>
nmap <silent>' :bnext<CR>
nmap <silent>" :bprev<CR>

" => Windows moving 
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

tmap <C-h> <C-W>h
tmap <C-j> <C-W>j
tmap <C-k> <C-W>k
tmap <C-l> <C-W>l

" => Windows resizing
nmap <left> <C-w>5<
nmap <right> <C-w>5>
nmap <down> <C-w>5+
nmap <up> <C-w>5-

tmap <left> <C-w>5<
tmap <right> <C-w>5>
tmap <down> <C-w>5+
tmap <up> <C-w>5-

" => Session
nmap <leader>S :mksession! %:p:h:t<CR>

" => Code related
nnoremap <leader>r :call RunScript()<CR>
nnoremap <silent>== ggVG= <C-o>

