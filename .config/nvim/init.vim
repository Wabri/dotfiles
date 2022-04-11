""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Wabri <gabriele.puliti@pm.me>                    "
" Alias: Wabri (https://github.com/Wabri)                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" === PLUGINS ===
source ~/.config/nvim/plugins/plugins.vim

" === SETTINGS ===
" => No swap file
set noswapfile

" => Relative Number
set number relativenumber

" => Search
set incsearch ignorecase

" => Split
set splitright
set splitbelow

" => More space on command
set cmdheight=1

" => Cursor position
set ruler

" = UNDO =
" => Enable undofile
set undofile
" => Persitent undo history directory
set undodir=~/.config/nvim/undodir

" = NETRW =
" => General default style
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 13

" = Mouse =
" => Enable mouse on normal and visual mode
set mouse=n

" = TAB =
" => Number of space when TAB
set tabstop=2
" => Number of space for each steps of indent
set shiftwidth=2

" = THEMES =
" => Enable rgb color
set termguicolors
" => Default color group
set background=dark
" => Enable syntax
syntax enable
" => colorscheme
colorscheme nordic

" Laststatus
set laststatus=3
highlight WinSeparator guibg=None

" === MAPPING ===

" => Mapleader
let mapleader=" "

" => Reload vimrc
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>

" => Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" => Reload open file
nnoremap <leader>R :e!<CR>

" => Windows moving
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" => Buffers
nnoremap <leader>bb :b#<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bd :bd %<CR>
nmap <leader>B :Buffers<CR>

" => Tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

" => Move code up down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" => Windows resizing
nnoremap <left> <C-w>5<
nnoremap <right> <C-w>5>
nnoremap <down> <C-w>5+
nnoremap <up> <C-w>5-

" => NETRW
nnoremap <leader>e :e .<CR>

" => New
nnoremap <leader>t :tabnew <CR>:Files<CR>
nnoremap <leader>s :split<CR>:Files<CR>
nnoremap <leader>v :vsplit<CR>:Files<CR>
nnoremap <leader>nt :tabnew <CR>:e
nnoremap <leader>ns :split<CR>:e
nnoremap <leader>nv :vsplit<CR>:e
nnoremap <leader>nn :e

" => fzf
nmap <c-f> :Rg<CR>
nmap <leader>ff :GitFiles<CR>
nmap <leader>F :Files<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>ft :Filetypes<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)

" => Yank to clipboard
nnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>y "*y
vnoremap <leader>p "*p
nnoremap Y y$

" => Dont let focus go away when searching mode
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <c-o> <c-o>zzzv
nnoremap <c-i> <c-i>zzzv

" => Undo, but undo in the right way
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" => Select and group
vnoremap ." <esc>`>a"<esc>`<i"<esc>
vnoremap .' <esc>`>a'<esc>`<i'<esc>
vnoremap .` <esc>`>a`<esc>`<i`<esc>
vnoremap .( <esc>`>a)<esc>`<i(<esc>
vnoremap .[ <esc>`>a]<esc>`<i[<esc>
vnoremap .{ <esc>`>a}<esc>`<i{<esc>
vnoremap .2{ <esc>`>a }}<esc>`<i{{ <esc>

" => Session
nmap <leader>SS :ToggleWorkspace<CR>

" => Git
nmap <leader>gg :Git<CR>:only<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gl :Git log --oneline<CR>

" => Git Diffview
nmap <leader>df :DiffviewFileHistory<CR>
nmap <leader>dd :DiffviewOpen<CR>
nmap <leader>dc :DiffviewClose<CR>

