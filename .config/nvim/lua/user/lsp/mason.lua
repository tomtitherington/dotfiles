local status_ok, mason = pcall(require, "mason")
if not status_ok then
	vim.notify("Failed to load package 'mason'.", vim.log.levels.WARN)
	return
end

mason.setup()

-- TODO move this to separate file ./servers.lua
local servers = {
	pyright = {},
	clangd = {},
	tsserver = {},
	lua_ls = {
		Lua = {
			diagnostics = { globals = { "vim" } }, --silences undefined global vim warnings
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}


local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	vim.notify("Failed to load package 'mason-lspconfig'.", vim.log.levels.WARN)
	return
end

-- Ensure servers above are installed
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers)
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = require("user.lsp.handlers").on_attach,
			settings = servers[server_name],
		}
	end,
}
