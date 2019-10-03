call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'

" language server client
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ui stuff
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

set history=700
set modeline
set autoread

let mapleader = ","

set cmdheight=2
" set cursorcolumn
" set cursorline
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
set updatetime=100

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
let base16colorspace=256
set background=dark
colorscheme base16-gruvbox-dark-soft

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

set cc=80

let home = expand('$HOME')
let g:python3_host_prog = home . '/.pyenv/versions/neovim-3.7.4/bin/python'
let g:python_host_prog = home . '/.pyenv/versions/neovim-2.7.16/bin/python'

set shortmess+=c
set signcolumn

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
