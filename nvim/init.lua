require('plugins')

vim.g.mapleader = ','
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.wildignore = {'*.o', '*~', '*.toc', '*.aux', '*.tos', '*.nav', '*.pdf', '*.out'}
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.list = true
vim.opt.listchars = {tab = '»·', trail = '·', eol = '¬'}
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = {'80'}
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = {}

-- keep selection after indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- navigate between splits
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

-- j/k visually
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })

-- quickly edit init.lua
vim.api.nvim_set_keymap('n', '<leader>ev', ':e ' .. vim.fn.stdpath('config') .. '/init.lua<CR>', { noremap = true, silent = true })

-- restore cursor position when a buffer is opened, see :help restore-cursor
vim.cmd [[
augroup restore_cursor
  autocmd!
  autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
augroup END
]]

-- auto save
vim.cmd [[
augroup auto_save
  autocmd!
  autocmd FocusLost * :wa
augroup END
]]

-- auto-compile packer loader
vim.cmd [[
augroup packer_auto_compile
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]
