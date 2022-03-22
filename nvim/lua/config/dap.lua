local M = {}
function M.setup()
  local dap = require('dap')
  require('dapui').setup()

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/projects/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  dap.configurations.typescript = {
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require'dap.utils'.pick_process,
    },
  }

  vim.api.nvim_set_keymap('n', '<F5>', [[:lua require('dap').continue()<CR>]], { noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<F10>', [[:lua require('dap').step_over()<CR>]], { noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<F11>', [[:lua require('dap').step_into()<CR>]], { noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<F12>', [[:lua require('dap').step_out()<CR>]], { noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>b', [[:lua require('dap').toggle_breakpoint()<CR>]], { noremap = true, silent = true})
  -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  -- nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
  -- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
end

return M
