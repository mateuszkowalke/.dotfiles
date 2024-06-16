return {
	"stevearc/oil.nvim",
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			keymaps = {
				["C-h"] = false,
				["M-h"] = "actions.select.split",
			},
			view_options = {
				show_hidden = true,
			},
			skip_confirms_for_simple_edits = true,
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "open parent directory" })
		vim.keymap.set(
			"n",
			"<leader>-",
			require("oil").toggle_float,
			{ desc = "open parent directory in floating window" }
		)
	end,
}
