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
vim.keymap.set('n', '<leader>dk', ":lua require'dap'.disconnect({ terminateDebuggee = true })<CR>")
vim.keymap.set('n', '<leader>dt', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dT', ":lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set('n', '<leader>dc', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>dh', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>dl', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<leader>dj', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<leader>db', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- TODO
-- dap mappings for equivalent vimspector features
-- nmap <leader>de :VimspectorEval
-- nmap <leader>dw :VimspectorWatch
-- nmap <leader>do :VimspectorShowOutput

-- " for normal mode - the word under the cursor
-- nmap <Leader>di <Plug>VimspectorBalloonEval
-- " for visual mode, the visually selected text
-- xmap <Leader>di <Plug>VimspectorBalloonEval

-- TODO
-- add remapping of K

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

dap.configurations.typescript = {
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

-- TODO
-- rust config

-- loads launch.json from default location (.vscode/launch.json)
require('dap.ext.vscode').load_launchjs(nil, { node2 = {'javascript'} })
