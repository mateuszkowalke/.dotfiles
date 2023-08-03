require('mason').setup()
-- TODO
-- complete the ensure_installed list
-- need to exclude 'black' and 'prettier' from the list as causing errors:
-- [mason-lspconfig.nvim] Server "black" is not a valid entry in ensure_installed. Make sure to only provide lspconfig server names.
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'denols', 'eslint', 'html', 'cssls', 'jsonls', 'lua_ls', 'clangd',
        'docker_compose_language_service', 'gopls', 'pyright', 'ruff_lsp' }
})

-- close quickfix menu after selecting choice and center screen
-- vim.api.nvim_create_autocmd(
--     "FileType", {
--     pattern = { "qf" },
--     command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>zz]]
-- })

local lsp_config = require('lspconfig')

local on_attach = function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { silent = true })
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = 'utf-16'

-- setup for languages using default configuration
local servers = { 'gopls', 'clangd', 'docker_compose_language_service', 'html', 'cssls', 'ruff_lsp' }
for _, server in ipairs(servers) do
    lsp_config[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- lua setup
lsp_config.lua_ls.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<space>f', ':Format<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<space>F', ':FormatWrite<CR>', { buffer = bufnr })
    end,
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

-- python setup
lsp_config.pyright.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<space>f', ':Format<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<space>F', ':FormatWrite<CR>', { buffer = bufnr })
    end,
    capabilities = capabilities,
}

-- rust setup
local rt = require("rust-tools")
local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

rt.setup({
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    },
    server = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    capabilities = capabilities,
})

-- typescript/javascript setup
lsp_config.denols.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
}

lsp_config.tsserver.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<space>f', ':Format<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<space>F', ':FormatWrite<CR>', { buffer = bufnr })
    end,
    capabilities = capabilities,
    root_dir = lsp_config.util.root_pattern("package.json"),
}

lsp_config.jsonls.setup {
    on_attach = function(_, bufnr)
        on_attach(_, bufnr)
        vim.keymap.set('n', '<space>f', ':Format<CR>', { buffer = bufnr })
        vim.keymap.set('n', '<space>F', ':FormatWrite<CR>', { buffer = bufnr })
    end,
    capabilities = capabilities,
}

-- setup linters and formatters
lsp_config['eslint'].setup({})

require('formatter').setup(
    {
        logging = true,
        filetype = {
            typescriptreact = {
                require('formatter.filetypes.typescriptreact').prettier,
            },
            typescript = {
                require('formatter.filetypes.typescript').prettier,
            },
            javascriptreact = {
                require('formatter.filetypes.javascriptreact').prettier,
            },
            javascript = {
                require('formatter.filetypes.javascript').prettier,
            },
            json = {
                require('formatter.filetypes.json').prettier,
            },
            lua = {
                require('formatter.filetypes.lua').stylua,
            },
            python = {
                require('formatter.filetypes.python').black
            }
        }
    }
)

-- borders for floating windows
-- TODO refactor to separate file?
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    { "🭽", "FloatBorder" },
    { "▔",  "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕",  "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁",  "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏",  "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- config for showing diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- diagnostic symbols
local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
