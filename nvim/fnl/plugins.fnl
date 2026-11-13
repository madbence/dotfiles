(macro plugins [specs]
  (local tbl [])
  (var i 1)
  (while (<= i (length specs))
    (let [curr (. specs i)
          next (. specs (+ i 1))]
      (case (type next)
        (where (or :string :nil)) (do
                                    (table.insert tbl curr)
                                    (set i (+ i 1)))
        _ (let [spec {1 curr}]
            (each [k v (pairs next)]
              (tset spec k v))
            (set i (+ i 2))
            (table.insert tbl spec)))))
  tbl)

(fn map-telescope [bufnr mode lhs method opts]
  (vim.api.nvim_buf_set_keymap bufnr mode lhs
                               (.. "<cmd>lua require('telescope.builtin')."
                                   method "()<CR>")
                               opts))
(fn on-attach [client bufnr]
  (let [opts {:noremap true :silent true}]
    (vim.api.nvim_buf_set_keymap bufnr :n :gD
                                 "<cmd>lua vim.lsp.buf.declaration()<CR>" opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :K "<cmd>lua vim.lsp.buf.hover({ border = 'single' })<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :L
                                 "<cmd>lua vim.diagnostic.open_float({ scope = \"cursor\", border = \"single\" })<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<C-k>
                                 "<cmd>lua vim.lsp.buf.signature_help({ border = 'single' })<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>wa
                                 "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>wr
                                 "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>wl
                                 "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>rn
                                 "<cmd>lua vim.lsp.buf.rename()<CR>" opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>so
                                 "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>"
                                 opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ca
                                 "<cmd>lua vim.lsp.buf.code_action()<CR>" opts)
    (vim.api.nvim_buf_set_keymap bufnr :n :<leader>l
                                 "<cmd>lua vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })<CR>"
                                 opts)
    (map-telescope bufnr :n :gd :lsp_definitions opts)
    (map-telescope bufnr :n :gi :lsp_implementations opts)
    (map-telescope bufnr :n :gr :lsp_references opts)
    (map-telescope bufnr :n :<leader>so :lsp_document_symbols opts)
    (map-telescope bufnr :n :<leader>D :lsp_type_definitions opts)
    (vim.cmd " command! Format execute 'lua vim.lsp.buf.format()' ")))

(plugins [
  :kylechui/nvim-surround
    {:config true}

  :unblevable/quick-scope

  :RRethy/nvim-base16
    {:config (fn []
               (var theme vim.env.BASE16_THEME)
               (when (not theme)
                 (set theme :ocean))
               (local color (require :base16-colorscheme))
               (color.setup theme {:telescope false}))}

  :windwp/nvim-autopairs
    {:config true}

  :nacro90/numb.nvim
    {:config true}

  :nvim-treesitter/nvim-treesitter
    {:lazy false
     :build ::TSUpdate
     :config (fn []
               (local treesitter (require :nvim-treesitter))
               (treesitter.setup {})
               (treesitter.install [:bash :javascript :tsx :typescript :clojure :markdown :markdown_inline])
               (vim.api.nvim_create_autocmd :FileType
                 {:group (vim.api.nvim_create_augroup :treesitter {:clear true})
                  :pattern [:sh :javascript :javascriptreact :typescript :typescriptreact :clojure :markdown]
                  :callback (fn []
                              ; Parsers may still be downloading on the first launch.
                              (when (pcall vim.treesitter.start)
                                (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))}))}

  :nvim-treesitter/nvim-treesitter-context
    {:config true}

  :karb94/neoscroll.nvim
    {:opts {:easing_function :quadratic}}

  :nvim-lualine/lualine.nvim
    {:opts {:options {:icons_enabled false}}}

  :kdheepak/tabline.nvim
    {:config true}

  :saghen/blink.cmp
    {:version "1.*"
     :main :blink.cmp
     :opts {:keymap {:preset :super-tab}
            :signature {:enabled true}
            :completion {:documentation {:auto_show true}}}}

  ; lsp config
  :neovim/nvim-lspconfig
    {:dependencies [:saghen/blink.cmp]
     :config (fn []
               (vim.diagnostic.config {:virtual_text false :virtual_lines false})
               (local servers [:ts_ls :eslint :fennel_ls])
               (each [_ lsp (ipairs servers)]
                 (local config {:on_attach on-attach
                                :root_markers [:package-lock.json :.git]})
                 (vim.lsp.config lsp config)
                 (vim.lsp.enable lsp)))}

  :nvim-telescope/telescope.nvim
    {:config (fn []
               (local telescope (require :telescope))
               (local builtin (require :telescope.builtin))
               (telescope.setup {})
               (telescope.load_extension :ui-select)
               (vim.keymap.set :n "<leader>ff" builtin.find_files {})
               (vim.keymap.set :n "<leader>fg" builtin.live_grep {})
               (vim.keymap.set :n "<leader>fb" builtin.buffers {})
               (vim.keymap.set :n "<leader>fh" builtin.help_tags {}))}

  :folke/trouble.nvim
    {:config true}

  :nvim-telescope/telescope-ui-select.nvim

  :nvim-lua/plenary.nvim

  :lewis6991/gitsigns.nvim
    {:config true}

  :numToStr/Comment.nvim
    {:config true}

  :atweiden/vim-fennel
])
