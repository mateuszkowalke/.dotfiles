require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "sumneko_lua", "tsserver" }
})

local lsp_config = require('lspconfig')

local on_attach = function(_, _)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- this clashes with harpoon keymapping
    -- should be used only by some other plugin, so maybe no need for manual triggering
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp_config.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = {
                    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    [vim.fn.stdpath 'config' .. '../lua'] = true
                }
            }
        }
    }
}

lsp_config.denols.setup {
    on_attach = on_attach,
    root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
}

lsp_config.tsserver.setup {
    on_attach = function(_, _)
        on_attach(_, _)
        vim.keymap.set('n', '<leader>f', ':Format<CR>')
        vim.keymap.set('n', '<leader>F', ':FormatWrite<CR>')
    end,
    root_dir = lsp_config.util.root_pattern("package.json"),
}

lsp_config['eslint'].setup({})

require("formatter").setup(
    {
        logging = true,
        filetype = {
            typescriptreact = {
                require("formatter.filetypes.typescriptreact").prettier,
            },
            typescript = {
                require("formatter.filetypes.typescript").prettier,
            },
            javascriptreact = {
                require("formatter.filetypes.javascriptreact").prettier,
            },
            javascript = {
                require("formatter.filetypes.javascript").prettier,
            },
            json = {
                require("formatter.filetypes.json").prettier,
            },
            lua = {
                require("formatter.filetypes.lua").stylua,
            }
        }
    }
)
