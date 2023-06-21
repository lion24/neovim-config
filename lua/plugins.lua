local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	end

	local function plugins(use)
		use({ "wbthomason/packer.nvim" })
		-- Load only when require
		use({ "nvim-lua/plenary.nvim", module = "plenary" })
		-- Colorscheme
		use({
			"sainnhe/everforest",
			config = function()
				vim.cmd("colorscheme everforest")
			end,
		})
		-- Startup screen
		use({
			"goolord/alpha-nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("config.alpha").setup()
			end,
		})
		-- WhichKey
		use({
			"folke/which-key.nvim",
			config = function()
				require("config.whichkey").setup()
			end,
		})
		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			opt = true,
			event = "BufReadPre",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
			requires = {
				{ "windwp/nvim-ts-autotag", event = "InsertEnter" },
				{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
				{ "p00f/nvim-ts-rainbow", event = "BufReadPre" },
			},
		})
		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			after = "nvim-treesitter",
			config = function()
				require("config.lualine").setup()
			end,
			wants = "nvim-web-devicons",
		})
		-- nvim-tree
		use({
			"nvim-tree/nvim-tree.lua",
			opt = true,
			cmd = { "NvimTreeToggle", "NvimTreeClose" },
			config = function()
				require("config.nvimtree").setup()
			end,
		})
		use({ "elihunter173/dirbuf.nvim", cmd = { "Dirbuf" } })
		-- Code documentation
		use({
			"danymat/neogen",
			config = function()
				require("config.neogen").setup()
			end,
			cmd = { "Neogen" },
			module = "neogen",
			disable = false,
		})
		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				{ "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"lukas-reineke/cmp-rg",
				"davidsierradz/cmp-conventionalcommits",
				{ "onsails/lspkind-nvim", module = { "lspkind" } },
				-- "hrsh7th/cmp-calc",
				-- "f3fora/cmp-spell",
				-- "hrsh7th/cmp-emoji",
				{
					"L3MON4D3/LuaSnip",
					config = function()
						require("config.snip").setup()
					end,
					module = { "luasnip" },
				},
				"rafamadriz/friendly-snippets",
				"honza/vim-snippets",
			},
		})
		-- Auto pairs
		use({
			"windwp/nvim-autopairs",
			opt = true,
			event = "InsertEnter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
			end,
		})
		-- Auto tag
		use({
			"windwp/nvim-ts-autotag",
			opt = true,
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup({ enable = true })
			end,
		})
		-- End wise
		use({
			"RRethy/nvim-treesitter-endwise",
			opt = true,
			event = "InsertEnter",
			disable = false,
		})
		-- LSP
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"jose-elias-alvarez/null-ls.nvim",
				"jay-babu/mason-null-ls.nvim",
				"folke/neodev.nvim",
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup({})
					end,
				},
				{ "b0o/schemastore.nvim", module = { "schemastore" } },
				{ "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
				{
					"SmiteshP/nvim-navic",
					config = function()
						require("nvim-navic").setup({})
					end,
					module = { "nvim-navic" },
				},
			},
		})

		-- print(string.format("packer_bootstrap ? %s", tostring(packer_bootstrap)))
		if packer_bootstrap then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end

	packer_init()

	local packer = require("packer")
	packer.init(conf)
	packer.startup(plugins)
end

return M
