local M = {}

local function map_telescope(bufnr, mode, lhs, method, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, [[<cmd>lua require('telescope.builtin').]] .. method .. '()<CR>', opts)
end

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

  map_telescope(bufnr, 'n', 'gd', 'lsp_definitions', opts)
  map_telescope(bufnr, 'n', 'gi', 'lsp_implementations', opts)
  map_telescope(bufnr, 'n', 'gr', 'lsp_references', opts)
  map_telescope(bufnr, 'n', '<leader>ca', 'lsp_code_actions', opts)
  map_telescope(bufnr, 'n', '<leader>so', 'lsp_document_symbols', opts)
  map_telescope(bufnr, 'n', '<leader>D', 'lsp_type_definitions', opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local handlers =  {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = 'single'}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'single'}),
  }

  local servers = { 'tsserver', 'eslint', 'bashls' }
  local lspconfig = require 'lspconfig'
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
    })
  end
end

return M
