local ls = require("luasnip")

ls.config.set_config({
	updateevents = "TextChanged,TextChangedI",
})

-- keymaps
vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-H>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-J>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

-- snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s

-- format node
-- it takes a format string and a list of nodes
-- fmt(<fmt_string, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- insert node
-- it takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
	s("req", fmt('local {} = require("{}")', { i(1, "default"), rep(1) })),
})

ls.add_snippets("go", {
    ls.parser.parse_snippet("ife", "if err != nil {\n   return $1\n}"),
})

-- sourcing this file, so snippets get reloaded
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/core/plugin-config/snip.lua<CR>")
