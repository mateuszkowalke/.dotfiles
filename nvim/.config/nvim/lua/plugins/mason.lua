return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			-- TODO
			-- complete the ensure_installed list
			-- need to install "sql-formatter" manually through mason as it's formatter
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
}
