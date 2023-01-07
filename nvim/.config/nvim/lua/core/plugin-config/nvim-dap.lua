local dap = require('dap')

-- setup adapters
require('dap-vscode-js').setup({
    debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- language config
for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
        {
            name = 'Launch',
            type = 'pwa-node',
            request = 'launch',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '-r', 'ts-node/register' },
            runtimeExecutable = 'node',
            args = { '--inspect', '${file}' },
            skipFiles = { '<node_internals>/**', 'node_modules/**' },
            sourceMaps = true,
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**"
            },
        },
        {
            name = 'Attach to node process',
            type = 'pwa-node',
            request = 'attach',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            port = 9229,
        }
    }
end

-- nvim-dap-ui config
local dapui = require("dapui")
dapui.setup()

-- debugging keymaps
vim.keymap.set('n', '<leader>ds', function ()
    dap.continue()
    dapui.open()
end)
vim.keymap.set('n', '<leader>dk', function ()
    dapui.close()
    dap.close()
end)
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dT', dap.clear_breakpoints)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dh', dap.step_out)
vim.keymap.set('n', '<leader>dl', dap.step_into)
vim.keymap.set('n', '<leader>dj', dap.step_over)
-- nmap <leader>de :VimspectorEval
-- nmap <leader>dw :VimspectorWatch
-- nmap <leader>do :VimspectorShowOutput

-- " for normal mode - the word under the cursor
-- nmap <Leader>di <Plug>VimspectorBalloonEval
-- " for visual mode, the visually selected text
-- xmap <Leader>di <Plug>VimspectorBalloonEval

