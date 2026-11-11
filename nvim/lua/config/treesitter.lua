local M = {}
function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'bash', 'javascript', 'tsx', 'typescript', 'clojure', 'markdown' },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    }
  })
end

return M
