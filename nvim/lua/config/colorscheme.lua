local M = {}
function M.setup()
  local theme = vim.env.BASE16_THEME
  if not theme then theme = 'ocean' end
  require('base16-colorscheme').setup(theme, {
    telescope = false,
  })
end

return M
