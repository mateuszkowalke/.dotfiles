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
				ensure_installed = {
					"tsserver",
					"denols",
					"eslint",
					"html",
					"cssls",
					"jsonls",
					"lua_ls",
					"clangd",
					"docker_compose_language_service",
					"gopls",
					"asm_lsp",
					"rust_analyzer",
					"pyright",
					"ruff_lsp",
					"yamlls",
					"bufls",
				},
			})
		end,
	},
}
