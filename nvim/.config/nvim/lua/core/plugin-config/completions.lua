-- all default options are set for luasnip snippets
local cmp = require('cmp')
local luasnip = require('luasnip')
luasnip.setup({})

require('luasnip.loaders.from_vscode').lazy_load()
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
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    }, {
        { name = 'buffer' },
    })
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
