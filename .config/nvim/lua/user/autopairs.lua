local status_ok, autopairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  vim.notify("Failed to load package 'nvim-autopairs'.", vim.log.levels.WARN)
  return
end

autopairs.setup()

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  vim.notify("Failed to load package 'cmp'.", vim.log.levels.WARN)
  return
end

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
