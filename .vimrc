" =========================================================================== "
" => PLUGINS

source ~/.vim/plugins.vim
" =========================================================================== "
" => THEMES

" => colorscheme
colorscheme nordisk

" => Color column
set colorcolumn=80
set cursorline

" =========================================================================== "
" => SETTINGS

" => Line numbers
set number relativenumber

" => Split
set splitright
set splitbelow

" => Remove swap file
set noswapfile

" => Remove banner on netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 13

" => Persitent undo history
set undodir=~/.vim/undodir
set undofile

" => Search config
set incsearch

" => More space on command
set cmdheight=2

" => Updatetime
set updatetime=300

" => Updatetime
set completeopt=menuone,noinsert,noselect

set shortmess+=c

set signcolumn=yes

" => mouse
set mouse=a

" =========================================================================== "
" => MAPPING

" => Mapleader
let mapleader=" "

" => Vimrc
nmap <leader>, :tabnew +e ~/.vimrc <CR>
nmap <leader>. :source ~/.vimrc <CR>

" => Easy quit and save
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader>Q :qa!<CR>

" => Reload open file
nmap <leader>R :e!<CR>

" => Open a remotely file 
nmap <leader>E q::e scp://user@192.168.1.1//...

" => Directory tree
nmap <leader>e :Le .<CR>

" => Terminal
nmap <leader><CR> :vertical terminal<CR>
nmap <leader><leader> :terminal<CR>

" => New
nmap <leader>s :split<CR>:GitFiles<CR>
nmap <leader>v :vsplit<CR>:GitFiles<CR>
nmap <leader>t :tabnew <CR>:GitFiles<CR>
nmap <leader>nt :tabnew <CR>:e
nmap <leader>ns :split<CR>:e
nmap <leader>nn :e

" => Windows moving
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

tmap <C-h> <C-W>h
tmap <C-j> <C-W>j
tmap <C-k> <C-W>k
tmap <C-l> <C-W>l

nmap <leader>h <C-W>H
nmap <leader>j <C-W>J
nmap <leader>k <C-W>K
nmap <leader>l <C-W>L

" => Buffers
nmap <leader>bb :b#<CR>
nmap <leader>bn :bn<CR>
nmap <leader>bp :bp<CR>
nmap <leader>bd :bd %<CR>

" => Tabs
nmap <leader>tn gT
nmap <leader>tp gt
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" => Move up down
" Visual
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Insert
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
" Normal
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" => Shift + Enter = new line
inoremap <S-CR> <END><CR>

" => Windows resizing
nmap <left> <C-w>5<
nmap <right> <C-w>5>
nmap <down> <C-w>5+
nmap <up> <C-w>5-

" => Netwr mapping
function! NetrwMapping()
    nmap <buffer> <C-h> <C-w>h
    nmap <buffer> <C-j> <C-w>j
    nmap <buffer> <C-k> <C-w>k
    nmap <buffer> <C-l> <C-w>l
endfunction

" => fzf
nmap <c-f> :Rg<CR>
nmap <leader>F :Files<CR>
nmap <leader>ff :GitFiles<CR>
nmap <leader>fl :Lines<CR>
nmap <leader>fb :Buffers<CR>
nmap <leader>ct :Filetypes<CR>
nmap <leader>? :Maps<CR>

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

" => Exit from insert without break the Home raw position
inoremap jk <Esc>
inoremap kj <Esc>

" => Session
nmap <leader>SS :ToggleWorkspace<CR>

" => Git
nmap <leader>gg :Git<CR><C-w><C-w>:q!<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gl :Git log --oneline<CR>
nmap <leader>gf :Flogsplit<CR>

" => coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ Check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <silent> K :call Show_documentation()<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" =========================================================================== "
" => Augroup

autocmd BufNewFile,BufRead */recipes/*.rb set ft=chef syntax=ruby

augroup ansible_ft
    au!
    au BufRead,BufNewFile playbook.yml setfiletype yaml.ansible
augroup END

augroup readme
    let @z = "'sj/^## mswy$'ao- [pa]o(#pa):s/ /-/gekJxma@z"
    let @x = "gg/^## IndexjV/^##kdOkmams"
    au BufRead README.md set nowrapscan
    au BufReadPost README.md norm mc@x
    au BufWritePre README.md norm @z
    au BufWritePost README.md norm 'c
    au BufLeave README.md set wrapscan
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
