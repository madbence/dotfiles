call plug#begin('~/.vim/plugged')
" editing qol
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" heavy stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'eraserhd/parinfer-rust'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" ui stuff
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'
Plug 'karb94/neoscroll.nvim'
Plug 'folke/trouble.nvim'
Plug 'RRethy/nvim-base16'
Plug 'huytd/vim-nord-light-brighter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'folke/lsp-colors.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

set history=700
set modeline
set autoread

let mapleader = ","

set cmdheight=2
" set cursorcolumn
" set cursorline
" set hidden
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

set termguicolors
let base16colorspace=256
set background=dark

if !empty($BASE16_THEME)
  exe "colorscheme base16-" . $BASE16_THEME
else
  colorscheme base16-ocean
endif

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
set signcolumn=yes

lua <<EOF
require('neoscroll').setup({
  easing_function='quadratic'
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "javascript", "tsx", "typescript", "clojure" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false,
  }
}

--[[
require'trouble'.setup {
  icons = false,
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}
]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float({border="single"})<CR>', { noremap = true, silent = true })

function map_telescope(bufnr, mode, lhs, method, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, [[<cmd>lua require('telescope.builtin').]] .. method .. '()<CR>', opts)
end

function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

  map_telescope(bufnr, 'n', 'gd', 'lsp_definitions', opts)
  map_telescope(bufnr, 'n', 'gi', 'lsp_implementations', opts)
  map_telescope(bufnr, 'n', 'gr', 'lsp_references', opts)
  map_telescope(bufnr, 'n', '<leader>ca', 'lsp_code_actions', opts)
  map_telescope(bufnr, 'n', '<leader>so', 'lsp_document_symbols', opts)
  map_telescope(bufnr, 'n', '<leader>D', 'lsp_type_definitions', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
end

local handlers =  {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = 'single'}),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'single'}),
}

local servers = { 'tsserver', 'eslint', 'bashls' }
local lspconfig = require 'lspconfig'
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-SPACE>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  documentation = {
    border = 'double',
  },
  completion = {
    keyword_length = 0,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
