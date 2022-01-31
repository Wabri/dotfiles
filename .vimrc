""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"__     ___
"\ \   / (_)_ __ ___
" \ \ / /| | '_ ` _ \
"  \ V / | | | | | | |
"   \_/  |_|_| |_| |_|
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Wabri <gabriele.puliti@pm.me>                    "
" Alias: Wabri (https://github.com/Wabri)                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" === PLUGINS ===
source ~/.vim/plugins.vim

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

" === NETRW ===
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 13

" === COLORSCHEME ===
colorscheme nordisk

" === MAPPING ===

" => Mapleader
let mapleader=" "

" => Save & Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" => Reload open file
nnoremap <leader>R :e!<CR>


" => Windows moving
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

tnoremap <C-h> <C-W>h
tnoremap <C-j> <C-W>j
tnoremap <C-k> <C-W>k
tnoremap <C-l> <C-W>l

function! NetrwMapping()
    nmap <buffer> <C-h> <C-w>h
    nmap <buffer> <C-j> <C-w>j
    nmap <buffer> <C-k> <C-w>k
    nmap <buffer> <C-l> <C-w>l
endfunction

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

" => Move up down
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
nmap <leader>ff :Files<CR>
nmap <leader>fg :GitFiles<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>ft :Filetypes<CR>

" => Yank to clipboard
nnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>y "*y
vnoremap <leader>p "*p
nnoremap Y y$

" => Dont let focus go away when searching mode
nnoremap n nzzzv
nnoremap N Nzzzv

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

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" =========================================================================== "
" => Augroup

autocmd BufNewFile,BufRead */recipes/*.rb set ft=chef syntax=ruby

augroup ansible_ft
    au!
    au BufRead,BufNewFile playbook.yml setfiletype yaml.ansible
augroup END

augroup vagrant_ft
    au!
    au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END

augroup aclpolicy_ft
    au!
    au BufRead,BufNewFile *.aclpolicy setfiletype yaml
augroup END

augroup vimrc_ft
    au!
    au BufRead,BufNewFile .vimrc setfiletype vim
augroup END

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

autocmd StdinReadPre * let s:std_in=1

if has("autocmd")
  autocmd BufRead *-vault.yml ! ansible-vault edit %
endif

