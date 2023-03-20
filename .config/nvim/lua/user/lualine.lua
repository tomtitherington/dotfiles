local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  vim.notify("Failed to load package 'lualine'.", vim.log.levels.WARN)
  return
end

lualine.setup {
  options = {
    theme = 'dracula'
  }
}
