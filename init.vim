call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'cloudhead/neovim-fuzzy'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'numkil/ag.nvim'
" Plug 'morhetz/gruvbox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'w0rp/ale'

" ui stuff
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language plugins
Plug 'digitaltoad/vim-jade'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'wavded/vim-stylus'
call plug#end()

set history=700
set modeline
set autoread

let mapleader = ","

cnoremap w!! w !sudo tee % >/dev/null

set cmdheight=2
set cursorcolumn
set cursorline
set hidden
set laststatus=2
set noshowmode
set number
set relativenumber
set ruler
set scrolloff=7
set wildignore=*.o,*~,*.pyc,*.toc,*.aux,*.tos,*.nav,*.pdf,*.snm,*.out,*.log
set wildmenu

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set matchtime=2
set noerrorbells
set novisualbell
set timeoutlen=500

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

if has("gui_running")
  set guioptions=a
  set guifont=Iosevka\ Term\ Medium\ 10
  set guitablabel=%M\ %t
endif

set termguicolors
let g:gruvbox_italic=0
let base16colorspace=256
" set background=dark
" colorscheme base16-gruvbox-dark-soft
colorscheme base16-grayscale-light

set encoding=utf8
set ffs=unix,dos,mac

let g:airline_powerline_fonts=1
let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled=1

set nobackup
set nowb
set noswapfile
set expandtab
set smarttab

set shiftwidth=2
set tabstop=2
set autoindent
set wrap

nnoremap j gj
nnoremap k gk
nnoremap <space> /
nnoremap <c-space> ?
nnoremap <silent> <leader><cr> :noh<cr>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <leader>ba :% bd!<cr>

try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

set viminfo^=%

nnoremap 0 ^
nnoremap <M-j> :m+<cr>==
nnoremap <M-k> :m-2<cr>==
vnoremap <M-j> :m '>+1<cr>gv=gv
vnoremap <M-k> :m '<-2<cr>gv=gv

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

nnoremap <leader>pp :setlocal paste!<cr>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

au FocusLost * :wa
nnoremap <leader>v V`]

inoremap jj <ESC>
inoremap jk <ESC>

vnoremap < <gv
vnoremap > >gv

set list
set listchars=tab:»·,trail:·,eol:¬

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

set cc=80

let g:deoplete#enable_at_startup = 1
set completeopt-=preview

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'python': ['pyls'],
  \ 'rust': ['rls'],
  \ }

let g:LanguageClient_diagnosticsDisplay = {
  \ 1: {
  \   'name': 'Error',
  \   'texthl': 'ALEError',
  \   'signText': 'x',
  \   'signTexthl': 'ALEErrorSign',
  \ },
  \ 2: {
  \   'name': 'Warning',
  \   'texthl': 'ALEWarning',
  \   'signText': '!',
  \   'signTexthl': 'ALEWarningSign',
  \ },
  \ 3: {
  \   'name': 'Information',
  \   'texthl': 'ALEInfo',
  \   'signText': 'i',
  \   'signTexthl': 'ALEInfoSign',
  \ },
  \ 4: {
  \   'name': 'Hint',
  \   'texthl': 'ALEInfo',
  \   'signText': '?',
  \   'signTexthl': 'ALEInfoSign',
  \ },
  \ }

let home = expand('$HOME')
let g:python3_host_prog = home . '/.nvim-python3/bin/python'
let g:python_host_prog = home . '/.nvim-python2/bin/python'

nnoremap <C-p> :FuzzyOpen<CR>
