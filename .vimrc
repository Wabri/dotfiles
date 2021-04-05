" =========================================================================== "
" => PLUGINS

source ~/.vim/plugins.vim

" =========================================================================== "
" => THEMES

" => colorscheme
colorscheme nord

set nocompatible

" => Color column
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" =========================================================================== "
" => SETTINGS

" => Line numbers
set number relativenumber

" => Split
set splitright
set splitbelow

" => Remove swap file
set noswapfile

" => Set tab 
set tabstop=4 softtabstop=4     " Tab key indents by 4 spaces.
set shiftwidth=4                " >> indents by 2 spaces.
set expandtab                   " Use spaces instead of tabs.
set smartindent                 " Autoindentation
set shiftround                  " >> indents to next multiple of 'shiftwidth'.

set smartcase

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set undodir=~/.vim/undodir
set undofile

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Recently vim can merge signcolumn and number column into one
set signcolumn=number

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" => Scrolling options
" keep 5 lines between the cursor and the edge of the screen
set scrolloff=6

" => Mouse Scrolling
set mouse=nicr

" => Go down on a new line instead of infinitely right 
set wrap

" 
set clipboard=unnamedplus

" =========================================================================== "
" => Statusline
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ }
set noshowmode      " Not show current mode in command-line.
set showcmd         " Show already typed keys when more are expected.

" =========================================================================== "
" => Functions

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" =========================================================================== "
" => MAPPING

" => Mapleader
let mapleader=" "

" => Help
nmap <leader>? :Maps<CR>

" => Vimrc
nmap <leader>, :tabnew +e ~/.vimrc <CR>
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
nmap <leader>fg :GFiles<CR>
nmap <leader>ff :Files<CR>

" => New 
nmap <leader>s :split<CR>:GFiles<CR>
nmap <leader>v :vsplit<CR>:GFiles<CR>

" => Terminal
nmap <leader><CR> :vertical terminal<CR>
nmap <leader><leader> :terminal<CR>

" => Tabs
nmap <leader>t :tabnew <CR>:GFiles<CR>
nmap <tab> gt
nmap <s-tab> gT
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

" => Buffers
" nmap <Leader>b :buffers<CR>:buffer<Space>
nmap <Leader>b :Buffers<CR>
nmap <Leader>' :bnext<CR>
nmap <Leader>" :bprev<CR>

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

" Move up down 
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
nmap <leader>SS :mksession! %:p:h:t<CR>:Obsess<CR>
nmap <leader>SD :Obsess!<CR>

" => Scrolling
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" => Format
" without coc
nnoremap <silent>== ggVG=<C-o><C-o>
" nmap <silent> == :Format<CR>

" => Substitute
vnoremap <leader>p "_dP

" => Organize imports
nmap <silent> __ :OR<CR>

" => Organize imports
nnoremap <leader>uu :UndotreeToggle<CR>
nnoremap <leader>uf :UndotreeFocus<CR>

" => Distraction-free mode
nnoremap <leader>z :Goyo<CR>
nnoremap <leader>Z :Goyo!<CR>

" => Go definition
" without coc
" nnoremap gd g<C-]>

" TAB trigger completion
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" <CR> auto-select first completion item format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" <CR> confirm completion, `<C-g>u` means break undo chain at current position. 
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <leader>[g <Plug>(coc-diagnostic-prev)
nmap <leader>]g <Plug>(coc-diagnostic-next)
nmap <leader>=g :CocDiagnostics<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <NUL> coc#refresh()
" => Go definition
nmap <buffer> <leader>gd <Plug>(coc-definition)
" => Go implementation        
nmap <buffer> <leader>gi <Plug>(coc-implementation)
" => Go definition        
nmap <buffer> <leader>gy <Plug>(coc-type-definition)
" => list of references
nmap <buffer> <leader>gr <Plug>(coc-references)
" => Rename
nmap <buffer> <leader>rn <Plug>(coc-rename)
" => Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" =========================================================================== "
" => AutoCommand

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" =========================================================================== "
" => Path

let &path.="/usr/include/,"
