" Wabri's Simple Vim Configuration
" A minimal but useful Vim setup

" ===== Basic Settings =====
set nocompatible              " Use Vim settings, not Vi settings
filetype plugin indent on     " Enable filetype detection
syntax on                     " Enable syntax highlighting

" ===== UI Configuration =====
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set cursorline                " Highlight current line
set showmatch                 " Highlight matching brackets
set ruler                     " Show cursor position
set wildmenu                  " Enhanced command line completion
set showcmd                   " Show command in bottom bar

" ===== Indentation =====
set tabstop=4                 " Number of visual spaces per TAB
set softtabstop=4             " Number of spaces in tab when editing
set shiftwidth=4              " Number of spaces to use for autoindent
set expandtab                 " Tabs are spaces
set autoindent                " Auto-indent new lines
set smartindent               " Smart auto-indent

" ===== Search =====
set incsearch                 " Search as characters are entered
set hlsearch                  " Highlight matches
set ignorecase                " Ignore case when searching
set smartcase                 " Unless uppercase is used

" ===== Performance =====
set lazyredraw                " Redraw only when needed
set ttyfast                   " Faster terminal connection

" ===== Backups =====
set nobackup                  " Don't create backup files
set nowritebackup             " Don't create backup while editing
set noswapfile                " Don't create swap files

" ===== Other =====
set encoding=utf-8            " Use UTF-8 encoding
set scrolloff=5               " Keep 5 lines visible above/below cursor
set backspace=indent,eol,start " Allow backspace over everything
set clipboard=unnamedplus     " Use system clipboard

" ===== Key Mappings =====
" Map leader to space
let mapleader = " "

" Clear search highlighting with <leader><space>
nnoremap <leader><space> :nohlsearch<CR>

" Quick save with <leader>w
nnoremap <leader>w :w<CR>

" Quick quit with <leader>q
nnoremap <leader>q :q<CR>

" Move by visual line (useful for wrapped lines)
nnoremap j gj
nnoremap k gk

" ===== Status Line =====
set laststatus=2              " Always show status line
set statusline=%F             " Full file path
set statusline+=%m            " Modified flag
set statusline+=%r            " Read-only flag
set statusline+=%=            " Switch to right side
set statusline+=%l/%L         " Current line / Total lines
set statusline+=\ %c          " Column number
set statusline+=\ %p%%        " Percentage through file

" ===== Color Scheme =====
colorscheme desert            " Use desert color scheme (built-in)
