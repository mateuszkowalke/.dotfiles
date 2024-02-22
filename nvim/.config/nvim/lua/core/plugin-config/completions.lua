-- all default options are set for luasnip snippets
local cmp = require("cmp")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local ls = require("luasnip")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	-- snippets are required
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	}),
	-- order of the sources matters - it gives the completions ranking for priority
	-- additional fields for sources are: keyword_length, priority, max_item_count
	sources = {
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "nvim_lsp" }, -- from language server
		{ name = "path" }, -- file paths
		{ name = "luasnip" }, -- from luasnip snippets
		{ name = "buffer", keyword_length = 4 }, -- source current buffer
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lua = "[api]",
				nvim_lsp = "[lsp]",
				path = "[path]",
				luasnip = "[snip]",
				buffer = "[buf]",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	preselect = cmp.PreselectMode.None,
})

-- add vim-dadbod-completion in sql files
-- TODO
-- completion does not work
vim.cmd([[
    autocmd FileType sql,mysql,plsql,ddl lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
]])

-- adds '(' after selecting function of method in autocompletion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- luasnip setup
vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

-- comment.nvim setup
require("Comment").setup()
