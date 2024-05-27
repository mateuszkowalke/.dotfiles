return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			git = {
				ignore = false,
			},
		})

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
	end,
}
