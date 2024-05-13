-- all default options are set for luasnip snippets
local cmp = require("cmp")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

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
		{ name = "cmp-dbee" },
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

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	matching = { disallow_symbol_nonprefix_matching = false },
})

-- adds '(' after selecting function of method in autocompletion
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- comment.nvim setup
require("Comment").setup()
