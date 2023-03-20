local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("Failed to load package 'telescope'.", vim.log.levels.WARN)
  return
end

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

