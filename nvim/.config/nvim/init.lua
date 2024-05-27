require('globals')
require('options')
require('remaps')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- 	use("ellisonleao/gruvbox.nvim")
-- 	use("christoomey/vim-tmux-navigator")
--
-- 	-- file explorer and status line
-- 	use("nvim-tree/nvim-tree.lua")
-- 	use("nvim-tree/nvim-web-devicons")
-- 	use("nvim-lualine/lualine.nvim")
--
-- 	-- treesitter
-- 	use({
-- 		"nvim-treesitter/nvim-treesitter",
-- 		run = ":TSUpdate",
-- 	})
-- 	use("nvim-treesitter/playground")
-- 	use("nvim-treesitter/nvim-treesitter-textobjects")
-- 	use("nvim-treesitter/nvim-treesitter-context")
--
-- 	-- telescope
-- 	use({
-- 		"nvim-telescope/telescope.nvim",
-- 		tag = "0.1.4",
-- 		requires = { { "nvim-lua/plenary.nvim" } },
-- 	})
--
-- 	-- lsp
-- 	use("williamboman/mason.nvim")
-- 	use("williamboman/mason-lspconfig.nvim")
-- 	use("neovim/nvim-lspconfig")
--
-- 	-- completion framework:
-- 	use("hrsh7th/nvim-cmp")
--
-- 	-- completion sources:
-- 	use("hrsh7th/cmp-nvim-lsp")
-- 	use("hrsh7th/cmp-nvim-lsp-signature-help")
-- 	use("saadparwaiz1/cmp_luasnip")
-- 	use("hrsh7th/cmp-nvim-lua")
-- 	use("hrsh7th/cmp-path")
-- 	use("hrsh7th/cmp-buffer")
-- 	use("hrsh7th/cmp-cmdline")
-- 	use({
-- 		"MattiasMTS/cmp-dbee",
-- 	})
--
-- 	-- snippets
-- 	use({
-- 		"L3MON4D3/LuaSnip",
-- 		-- follow latest release.
-- 		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
-- 		-- install jsregexp (optional!:).
-- 		run = "make install_jsregexp",
-- 	})
--
-- 	-- editing
-- 	use("mhartington/formatter.nvim")
-- 	use({
-- 		"windwp/nvim-autopairs",
-- 		config = function()
-- 			require("nvim-autopairs").setup({})
-- 		end,
-- 	})
-- 	use("numToStr/Comment.nvim")
--
-- 	-- rust plugins
-- 	use("simrat39/rust-tools.nvim")
--
-- 	-- go plugins
-- 	use({
-- 		"crispgm/nvim-go",
-- 		run = ":GoInstallBinaries",
-- 	})
--
-- 	-- sql plugins
-- 	use({
-- 		"kndndrj/nvim-dbee",
-- 		requires = {
-- 			"MunifTanjim/nui.nvim",
-- 		},
-- 		run = function()
-- 			-- Install tries to automatically detect the install method.
-- 			-- if it fails, try calling it with one of these parameters:
-- 			--    "curl", "wget", "bitsadmin", "go"
-- 			require("dbee").install()
-- 		end,
-- 	})
--
-- 	-- misc
-- 	use("theprimeagen/harpoon")
-- 	use("mbbill/undotree")
--
-- 	-- git
-- 	use("tpope/vim-fugitive")
-- 	use("sindrets/diffview.nvim")
--
-- 	-- debugging
-- 	use({ "rcarriga/nvim-dap-ui", tag = "v3.4.0", requires = { "mfussenegger/nvim-dap" } })
-- 	use("theHamsta/nvim-dap-virtual-text")
-- 	use({
-- 		"leoluz/nvim-dap-go",
-- 		ft = "go",
-- 		config = function(_, opts)
-- 			require("dap-go").setup(opts)
-- 		end,
-- 	})
--
-- 	-- notetaking
-- 	use({
-- 		"epwalsh/obsidian.nvim",
-- 		tag = "*", -- recommended, use latest release instead of latest commit
-- 		requires = {
-- 			"nvim-lua/plenary.nvim",
-- 		},
-- 	})
-- 	use({
-- 		"iamcco/markdown-preview.nvim",
-- 		run = "cd app && npm install",
-- 		setup = function()
-- 			vim.g.mkdp_filetypes = { "markdown" }
-- 			vim.g.mkdp_browser = "/snap/bin/firefox"
-- 		end,
-- 		ft = { "markdown" },
-- 	})
--
-- end)
