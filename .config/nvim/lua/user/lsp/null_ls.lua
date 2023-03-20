local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify("Failed to load package 'null-ls'.", vim.log.levels.WARN)
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
	debug = false,
	diagnostics_format = "[#{c}] #{m} (#{s})", -- #{c} code | #{m} message | #{s} source name
	sources = {
		--formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
		formatting.black.with { extra_args = { "--fast" } },
		diagnostics.flake8,
		-- null_ls.builtins.diagnostics.flake8.with({
		-- 	-- Force the severity to be a hint
		-- 	diagnostics_postprocess = function(process_diagnostics)
		-- 		process_diagnostics.severity = vim.diagnostic.severity.WARN
		-- 	end
		-- })
	},
}
