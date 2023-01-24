local dap, dapui = require('dap'), require("dapui")

-- register dapui to open and close on debugging sessions
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dapui.setup()

-- debugging keymaps
vim.keymap.set('n', '<leader>ds', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>dk', ":lua require'dap'.terminate()<CR>")
vim.keymap.set('n', '<leader>dt', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dT', ":lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set('n', '<leader>dc', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>dh', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>dl', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<leader>dj', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<leader>db', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- nmap <leader>de :VimspectorEval
-- nmap <leader>dw :VimspectorWatch
-- nmap <leader>do :VimspectorShowOutput

-- " for normal mode - the word under the cursor
-- nmap <Leader>di <Plug>VimspectorBalloonEval
-- " for visual mode, the visually selected text
-- xmap <Leader>di <Plug>VimspectorBalloonEval

-- mapping for 'K' to dap.ui.widgets.hover() while in debugging session
local api = vim.api
local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', 'K')
      end
    end
  end
  api.nvim_set_keymap(
    'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end

-- virtual text for debugging
require('nvim-dap-virtual-text').setup()

-- setup adapters
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

-- loads launch.json from default location (.vscode/launch.json)
require('dap.ext.vscode').load_launchjs(nil, { node2 = {'javascript'} })
