local M = {}
function M.setup()
  require('lualine').setup({
    options = {
      icons_enabled = false,
    },
  });
end

return M
