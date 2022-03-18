local M = {}
function M.setup()
  require('base16-colorscheme').with_config({
    telescope = false,
  })
  local theme = vim.env.BASE16_THEME
  if not theme then theme = 'ocean' end
  vim.cmd('colorscheme base16-' .. theme)
end

return M
