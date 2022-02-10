local M = {}
function M.setup()
  vim.cmd [[colorscheme base16-ocean]]

  -- by default, Telescope borders are invisible
  -- see https://github.com/RRethy/nvim-base16/issues/32#issuecomment-1026475234
  vim.cmd [[highlight! link TelescopeSelection    Visual]]
  vim.cmd [[highlight! link TelescopeNormal       Normal]]
  vim.cmd [[highlight! link TelescopePromptNormal TelescopeNormal]]
  vim.cmd [[highlight! link TelescopeBorder       TelescopeNormal]]
  vim.cmd [[highlight! link TelescopePromptBorder TelescopeBorder]]
  vim.cmd [[highlight! link TelescopeTitle        TelescopeBorder]]
  vim.cmd [[highlight! link TelescopePromptTitle  TelescopeTitle]]
  vim.cmd [[highlight! link TelescopeResultsTitle TelescopeTitle]]
  vim.cmd [[highlight! link TelescopePreviewTitle TelescopeTitle]]
  vim.cmd [[highlight! link TelescopePromptPrefix Identifier]]
end

return M
