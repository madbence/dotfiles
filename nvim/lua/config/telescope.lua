local M = {}

function M.setup()
  local telescope = require('telescope')
  telescope.setup({})
  telescope.load_extension('ui-select')
end

return M
