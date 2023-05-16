-- all default options are set for luasnip snippets
local cmp = require('cmp')

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    -- snippets are required
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
    }),
    sources = {
        { name = 'path' }, -- file paths
        { name = 'nvim_lsp' }, -- from language server
        { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 2 }, -- source current buffer
        { name = 'vsnip', keyword_pattern = '\\%([^[:alnum:][:blank:]]\\|\\w\\+\\)',
            keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
        { name = 'calc' }, -- source for math calculation
        { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    preselect = cmp.PreselectMode.None,
})

-- adds '(' after selecting function of method in autocompletion
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- nvim-comment setup
require('nvim_comment').setup()
vim.keymap.set('n', '<leader>/', ':CommentToggle<CR>')
vim.keymap.set('x', '<leader>/', ':CommentToggle<CR>')
vim.keymap.set('o', '<leader>/', ':CommentToggle<CR>')
