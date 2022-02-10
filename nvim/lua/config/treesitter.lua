local M = {}
function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'bash', 'javascript', 'tsx', 'typescript', 'clojure' },
    highlight = {
      enable = true,
    },
    indent = {
      enable = false,
    }
  })
end

return M
