" =========================================================================== "
" => PLUGINS

source ~/.vim/plugins.vim
" =========================================================================== "
" => THEMES

" => colorscheme
colorscheme nordisk

" => Color column
set colorcolumn=80

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

" => Reload open file
nmap <leader>R :e!<CR>

" => Directory tree
nmap <leader>e :e .<CR>

" => Terminal
nmap <leader><CR> :vertical terminal<CR>
nmap <leader><leader> :terminal<CR>

" => New
nmap <leader>s :split<CR>:GitFiles<CR>
nmap <leader>v :vsplit<CR>:GitFiles<CR>
nmap <leader>t :tabnew <CR>:GitFiles<CR>

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

" => Tabs
nmap <s-tab> gT
nmap <tab> gt
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
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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

" => Format
nnoremap <silent>== ggVG=<C-o><C-o>

" => Completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <c-n>for trigger completion
inoremap <silent><expr> <C-n> coc#refresh()

" => fzf
nnoremap <c-f> :Rg<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>ff :GitFiles<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ct :Filetypes<CR>
nnoremap <leader>? :Maps<CR>

" => Yank to clipboard
nnoremap <leader>y "*y
nnoremap <leader>p "*p
vnoremap <leader>y "*y
vnoremap <leader>p "*p

" =========================================================================== "
" => Augroup

augroup ansible_ft
    au!
    au BufRead,BufNewFile playbook.yml setfiletype yaml.ansible
augroup END

augroup vagrant_ft
    au!
    au BufRead,BufNewFile Vagrantfile setfiletype ruby
augroup END

augroup vimrc_ft
    au!
    au BufRead,BufNewFile .vimrc setfiletype vim
augroup END

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

if has("autocmd")
  autocmd BufRead *-vault.yml ! ansible-vault edit %
endif
