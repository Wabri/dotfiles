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
" Distraction free
Plug 'junegunn/goyo.vim'
" File manager
Plug 'preservim/nerdtree'
Plug 'unkiwii/vim-nerdtree-sync'
" Minimap
Plug 'severin-lemaignan/vim-minimap'
" All buffers, tabs, and tab layouts can be persisted as a workspace
Plug 'vim-ctrlspace/vim-ctrlspace'
" Markdown preview
Plug 'iamcco/markdown-preview.vim'
" General-purpose command-line fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" An ack/ag/pt/rg powered code search and view tool
Plug 'dyng/ctrlsf.vim'
" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" Jump iMproved
Plug 'pechorin/any-jump.vim'
" always-on highlight for a unique character in every word on a line to help you use f
Plug 'unblevable/quick-scope'
" Comment stuff out
Plug 'tpope/vim-commentary'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run git from vim
Plug 'tpope/vim-fugitive'
" Get git diff from file
Plug 'mhinz/vim-signify'
" lightweight and powerful git branch viewer
Plug 'rbong/vim-flog'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax checking and semantic error 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'dense-analysis/ale'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code completion 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Wakatime 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'wakatime/vim-wakatime'

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
" => Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Tabs and Spaces
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 2 spaces.
set shiftwidth  =4         " >> indents by 2 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
filetype plugin indent on


" => Removes pipes | that act as seperators on splits
set fillchars+=vert: 

" => Backspace
" Make backspace work as you would expect.
set backspace =indent,eol,start

" => Buffers
" Switch between buffers without having to save first.
set hidden 

" => Status Line
set laststatus =2          " Always show statusline.
set display =lastline      " Show as much as possible of the last line.
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

" => Search
set incsearch              " Highlight while searching with / or ?.
set ignorecase
" set hlsearch               " Keep matches highlighted.

" => Redraw
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

" => Always set autoindenting on
set autoindent
inoremap {<CR> {<CR>}<Esc>O

" => Default split to below and right.
set splitbelow splitright

" => Mouse Scrolling
set mouse=nicr

" => Map Leader, used for shortcut
let mapleader =" "

" => Disable arrow keys in Normal mode
"no <Up> <Nop>
"no <Down> <Nop>
"no <Left> <Nop>
"no <Right> <Nop>

" => Disable arrow keys in Insert mode
ino <Up> <Nop>
ino <Down> <Nop>
ino <Left> <Nop>
ino <Right> <Nop>

" => Scrolling options
inoremap <C-E> <C-X><C-E>
"scrolling on insert
inoremap <C-Y> <C-X><C-Y>
" keep 5 lines between the cursor and the edge of the screen
set scrolloff=6

" => Cursor settings
set cursorline
set colorcolumn=80

" => Default save to the original file.
set nowritebackup

" => Do not keep a backup file, use versions instead
set nobackup

" => Put the number of the line at the left of the text,
" => with the relative distance between the line focused.
set number relativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:nerdtree_sync_cursorline = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Minimap settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:minimap_highlight='Search'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown Preview settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" browser
let g:mkdp_path_to_chrome = "qutebrowser"
    " Path to the chrome or the command to open chrome (or other modern browsers).
    " If set, g:mkdp_browserfunc would be ignored.
    
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <NUL> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ctrlsf options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_position = 'right'
let g:ctrlsf_winsize = '100'

" => Ale configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Easy save
nmap <leader>w :w!<cr>
nmap <leader>W :x<cr>
" => Easy quit
nmap <leader>q :q<cr>
nmap <leader>Q :q!<cr>

" => Select all
nnoremap <leader>a ggVG

" => Source vimrc
nnoremap <leader>s :source ~/.vimrc<cr>

" => Switch to terminal
noremap <C-d> :sh<CR>
" => Terminal inside vim
nnoremap <leader>t :terminal<CR>
" Shortcommand for :enew variant for terminal
nnoremap <leader>T :term ++curwin<CR>

" => Switch between splitted editor
map <c-h> <C-w>h
map <c-j> <C-w>j
map <c-k> <C-w>k
map <c-l> <C-w>l

" => This abilitate the copy and paste to clipboard (on debian
" => you need to install: apt install vim-gnome
" paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
" copy to outside buffer
vnoremap <leader>y "+y

" => NERDTree open 
map <leader>e :NERDTreeToggle<CR>

" => Fugitive git
nmap <leader>gs :vertical Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gl :GlLog<CR>
nmap <leader>gd :Gdiffsplit<CR>
nmap <silent>gh :diffget //2<CR>
nmap <silent>gl :diffget //3<CR>
" => Flog branch viewer
nmap <silent>gF :Flog<CR>
nmap <silent>gf :Flogsplit<CR>

" => Goyo zen-mode
map <F11> :Goyo \| set linebreak<CR>

" => Buffer switching
nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>

" => Minimap
let g:minimap_toggle='<leader>mm'
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>mc'

" => Markdown Preview
map <leader>cm :MarkdownPreview<CR>
map <leader>cs :MarkdownPreviewStop<CR>

" => Compile document and preview
map <leader>cc :w! \| !compilepreview <c-r>%<CR>
map <leader>co :!openpreview <c-r>%<CR><CR>

" => FZF 
map <leader>f :FZF<CR>
map <leader>F :FZF!<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" => Conquer of completion
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current buffer.
nmap <F2> <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <F3> <Plug>(coc-fix-current)

" Symbol renaming.
nmap <silent> rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <silent> == :Format<CR>
nmap <silent> -- :Fold<CR>
nmap <silent> - zc
nmap <silent> ++ zR
nmap <silent> + zo
nmap <silent> __ :OR<CR>

" => Markdown Preview
map <left> <C-w>5<
map <right> <C-w>5>
map <down> <C-w>5+
map <up> <C-w>5-

" => Multiple Cursor mapping
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_select_all_word_key = '<A-n>'
"let g:multi_cursor_start_key           = 'g<C-n>'
"let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" => CtrlSF mapping
nmap     <C-F> <Plug>CtrlSFPrompt
"vmap     <C-F> <Plug>CtrlSFVwordPath
vmap     <C-F> <Plug>CtrlSFVwordExec
"nmap     <C-F>n <Plug>CtrlSFCwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
"nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" => Any Jump
" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>
