local status_ok, autotag = pcall(require, "nvim-ts-autotag")
if not status_ok then
  vim.notify("Failed to load package 'nvim-ts-autotag'.", vim.log.levels.WARN)
  return
end


autotag.setup({})
