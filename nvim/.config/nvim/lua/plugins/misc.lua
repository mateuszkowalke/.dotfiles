return {

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_browser = "/snap/bin/firefox"
		end,
		ft = { "markdown" },
	},
	"mbbill/undotree",
	"christoomey/vim-tmux-navigator",
}
