local function get_config(name)
  return "require('config." .. name .. "').setup()"
end

local function startup()
  -- package manager for neovim
  use 'wbthomason/packer.nvim'

  -- old, non-lua plugins
  use 'tpope/vim-surround'
  use 'unblevable/quick-scope'

  -- base16 color scheme
  use {'RRethy/nvim-base16', config = get_config('colorscheme')}

  -- automatically insert/remove char pairs, like parens, etc.
  use {'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup()]]}

  -- live preview for :<number>
  use {'nacro90/numb.nvim', config = [[require('numb').setup()]]}

  -- AST-aware syntax highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config('treesitter')}

  -- smooth scroll for <C-d>/<C-u>/etc.
  use {'karb94/neoscroll.nvim', config = [[require('neoscroll').setup({ easing_function='quadratic' })]]}

  -- statusline + tabline
  use {'nvim-lualine/lualine.nvim', config = get_config('lualine')}
  use {'kdheepak/tabline.nvim', config = [[require('tabline').setup({})]]}

  -- auto-completion
  use {
    'hrsh7th/nvim-cmp',
    config = get_config('completion'),
    requires = {'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'hrsh7th/cmp-buffer', 'saadparwaiz1/cmp_luasnip'},
  }

  -- LSP stuff
  use {
    'neovim/nvim-lspconfig',
    after = {'cmp-nvim-lsp', 'nvim-cmp', 'telescope.nvim', 'plenary.nvim'},
    config = get_config('lsp'),
  }

  -- mark file changes
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, config = [[require('gitsigns').setup()]]}

  -- fancy ui
  use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}, config = [[require('telescope').setup({})]]}

  -- comment stuff out
  use {'numToStr/Comment.nvim', config = [[require('Comment').setup()]]}
end

require('packer').startup(startup)
