""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"__     ___                    
"\ \   / (_)_ __ ___  
" \ \ / /| | '_ ` _ \
"  \ V / | | | | | | |
"   \_/  |_|_| |_| |_|
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:	Gabriele Puliti <gabriele.puliti@gmail.com>    "
" Alias: Wabri (https://github.com/Wabri)                      "
" Last change:	2020 5 24                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To use it, copy it to ~/.vimrc                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins will be downloaded under the specified directory.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Declare the list of plugins.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Utils
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startup page
Plug 'mhinz/vim-startify'
" Distraction free
Plug 'junegunn/goyo.vim'
" File manager
Plug 'preservim/nerdtree'
Plug 'vifm/vifm.vim'
" Minimap
Plug 'severin-lemaignan/vim-minimap'
" All buffers, tabs, and tab layouts can be persisted as a workspace
Plug 'vim-ctrlspace/vim-ctrlspace'
" Markdown preview
Plug 'iamcco/markdown-preview.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run git from vim
Plug 'tpope/vim-fugitive'
" Get git diff from file
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'PotatoesMaster/i3-vim-syntax'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code completion 
" Must read the guide if use:
" https://github.com/ycm-core/YouCompleteMe/blob/master/README.md
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ycm-core/YouCompleteMe'
Plug 'zxqfl/tabnine-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => List ends here.
" => Plugins become visible to Vim after this call.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter *
       \   if !argc()
       \ |   Startify
       \ |   NERDTree
       \ |   wincmd w
       \ | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
syntax on
set background=dark
colorscheme nord
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs and Spaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Removes pipes | that act as seperators on splits
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fillchars+=vert: 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backspace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make backspace work as you would expect.
set backspace =indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch between buffers without having to save first.
set hidden 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus =2          " Always show statusline.
set display =lastline      " Show as much as possible of the last line.
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch              " Highlight while searching with / or ?.
" set hlsearch               " Keep matches highlighted.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Redraw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Always set autoindenting on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
inoremap {<CR> {<CR>}<Esc>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Default split to below and right.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nicr

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Map Leader, used for shortcut
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader =" "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Disable arrow keys in Normal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
no <Up> <Nop>
no <Down> <Nop>
no <Left> <Nop>
no <Right> <Nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Disable arrow keys in Insert mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ino <Up> <Nop>
ino <Down> <Nop>
ino <Left> <Nop>
ino <Right> <Nop>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easy write and quit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easier write
nmap <leader>w :w!<cr>
nmap <leader>W :wq<cr>
" easier quit
nmap <leader>q :q<cr>
nmap <leader>Q :q!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Select all
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>a ggVG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Source vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>s :source ~/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Scrolling options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrolling
inoremap <C-E> <C-X><C-E>
"scrolling on insert
inoremap <C-Y> <C-X><C-Y>
" keep 5 lines between the cursor and the edge of the screen
set scrolloff=6

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cursor settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline
set colorcolumn=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Default save to the original file.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowritebackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Do not keep a backup file, use versions instead
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Put the number of the line at the left of the text,
" => with the relative distance between the line focused.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number relativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" switch to terminal
noremap <C-d> :sh<CR>
" open a terminal inside vim
nnoremap <leader>t :terminal<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => This is the map to switch between splitted editor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <c-h> <C-w>h
map <c-j> <C-w>j
map <c-k> <C-w>k
map <c-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => This abilitate the copy and paste to clipboard (on debian
" => you need to install: apt install vim-gnome
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>

"copy to outside buffer
vnoremap <leader>y "+y

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut
map <leader>e :NERDTreeToggle<CR>

" Close if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startify setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><leader> :Startify<CR>
autocmd User Startified setlocal buftype=nofile
" let NERDTreeHijackNetrw = 0
let g:startify_custom_header = []
let g:startify_skiplist = [
       \ 'COMMIT_EDITMSG',
       \ '.config/*',
       \ '.vim*',
       \ '.bash*',
       \ 'Workspace*',
       \ ]
let g:startify_lists = [
       \ { 'header': ['   Sessions'], 'type': 'sessions' },
       \ { 'header': ['   Bookmarks'], 'type': 'bookmarks' },
       \ ]

let g:startify_bookmarks = [ 
    \ {'b': '~/.bashrc'},
    \ {'d': '~/.config/dunst/dunstrc'},
    \ {'i': '~/.config/i3/config'},
    \ {'k': '~/.config/kitty/kitty.conf'},
    \ {'v': '~/.vimrc'},
    \ {'x': '~/.Xresources'}
    \ ] 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :GlLog<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>f :Goyo \| set linebreak<CR>

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  set scrolloff=999
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  set scrolloff=7
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlSpace settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CtrlSpaceLoadLastWorkspaceOnStart = 0
let g:CtrlSpaceSaveWorkspaceOnSwitch = 0
let g:CtrlSpaceSaveWorkspaceOnExit = 0

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bb :CtrlSpace<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Minimap settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:minimap_toggle='<leader>mm'
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>mc'
let g:minimap_highlight='Search'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vifm settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>v :Vifm<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown Preview settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for normal mode
map <leader>cm :MarkdownPreview<CR>
" for normal mode
map <leader>cs :MarkdownPreviewStop<CR>

" browser
let g:mkdp_path_to_chrome = "qutebrowser"
    " Path to the chrome or the command to open chrome (or other modern browsers).
    " If set, g:mkdp_browserfunc would be ignored.
    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Compile document and preview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cc :w! \| !compilepreview <c-r>%<CR>
map <leader>co :!openpreview <c-r>%<CR><CR>

