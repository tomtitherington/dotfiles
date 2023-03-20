local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	vim.notify("Failed to load package 'nvim-treesitter.configs'.", vim.log.levels.WARN)
	return
end

-- Parsers must be installed manually via :TSInstall
configs.setup {
	ensure_installed = "all",
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	autopairs = { enable = true }, -- used with the autopairs plugin
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			node_incremental = 'grn',
			scope_incremental = 'grc',
			node_decremental = 'grm',
		},
	},
	indent = {
		enable = true,
	},
}
