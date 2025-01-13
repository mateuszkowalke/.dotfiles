P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

-- run gofmt + goimports on save
local format_sync_grp_go = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = format_sync_grp_go,
})

-- run prettier on save for appropriate files
local format_sync_grp_prettier = vim.api.nvim_create_augroup("prettier", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.json", "*.graphqls", "*.ts", "*.js" },
	callback = function()
		vim.cmd("FormatWrite")
	end,
	group = format_sync_grp_prettier,
})
