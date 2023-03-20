local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	vim.notify("Failed to load package 'gitsigns'.", vim.log.levels.WARN)
	return
end

gitsigns.setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
  current_line_blame = true,
}
