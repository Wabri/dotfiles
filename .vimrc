" =========================================================================== "
" => PLUGINS

" => Load Personal plugins
call plug#begin('~/.vim/plugged')

" Colors
Plug 'arcticicestudio/nord-vim'

" Fuzzy Finder <= MOST IMPORTANT PLUGIN
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Completion and syntax of code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Tabbing configurations
Plug 'tpope/vim-sleuth'

call plug#end()

" => Load Personal plugins
" source ~/.vim/plugins/*

" =========================================================================== "
" => THEMES

colorscheme nord

" => Enable 256 colors
" set t_Co=256
" set encoding=utf-8

set nocompatible

" => Color column
set colorcolumn=80
set cursorcolumn

" => File detection and syntax detection
filetype plugin indent on
syntax on

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
"set expandtab       " Use spaces instead of tabs.
"set tabstop=4
"set softtabstop=4   " Tab key indents by 2 spaces.
"set shiftwidth=4    " >> indents by 2 spaces.
"set shiftround      " >> indents to next multiple of 'shiftwidth'.
"set autoindent
"set smartindent

" => Backspace
set backspace=indent,eol,start

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

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

" =========================================================================== "
" => AutoCommand

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" =========================================================================== "
" => Statusline
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
nmap <leader>f :GFiles<CR>

" => New 
nmap <leader>t :tabnew <CR>:GFiles<CR>
nmap <leader>s :split<CR>:GFiles<CR>
nmap <leader>v :vsplit<CR>:GFiles<CR>

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

nmap <leader>h <C-W>H
nmap <leader>j <C-W>J
nmap <leader>k <C-W>K
nmap <leader>l <C-W>L

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

" => Go definition
" without coc
" nnoremap gd g<C-]>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)

" => Go implementation        
nmap <silent> gi <Plug>(coc-implementation)

" => Go definition        
nmap <silent> gy <Plug>(coc-type-definition)

" => list of references
nmap <silent> gr <Plug>(coc-references)

" => Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" => Rename
nmap <leader>rn <Plug>(coc-rename)

" => Scrolling
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" => Format
" without coc
nnoremap <silent>== ggVG=<C-o><C-o>
" nmap <silent> == :Format<CR>

" => Organize imports
nmap <silent> __ :OR<CR>

" => Coc Addons
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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> =g :CocDiagnostics<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <NUL> coc#refresh()
