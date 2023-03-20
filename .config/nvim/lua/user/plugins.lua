-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Autocommand that reloads Neovim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Loading package 'packer' failed.", vim.log.levels.ERROR)
	return
end

-- Use a popup window for Packer
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end
	},
}

--local use = require('packer').use
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	use 'tpope/vim-fugitive'    -- Git commands in nvim
	-- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
	use 'tpope/vim-commentary'  -- "gc" to comment visual regions/lines
	use 'windwp/nvim-autopairs' -- automatically closes brackets, quotes .. etc
	use 'kyazdani42/nvim-web-devicons' -- nerd fonts that a few plugins depend on

	-- UI to select things (files, grep results, open buffers...)
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

	use { 'dracula/vim', as = 'dracula' }
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

	-- Add indentation guides even on blank lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- Add git related info in the signs columns and popups
	use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

	use { 'nvim-tree/nvim-tree.lua' } -- A file explorer 


	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use { 'neovim/nvim-lspconfig' }            -- Collection of configurations for built-in LSP clients along with a package manager for those
	use { 'williamboman/mason.nvim' }          -- Package manager for LSP, DAP, Linters and a couple of other bits
	use { 'williamboman/mason-lspconfig.nvim' } -- LSP extensions
	use { 'jose-elias-alvarez/null-ls.nvim' }  -- Formatters, Diagnostics (Linters) plus a couple more bits

	use 'hrsh7th/nvim-cmp'                     -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	-- Loads of snippets
	use 'rafamadriz/friendly-snippets'
	use 'kosayoda/nvim-lightbulb' -- Code Action Lightbulb

	-- Flutter/Dart stuff
	use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' } -- This plugin starts dartls behind the scenes

	-- DAP
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
end)
