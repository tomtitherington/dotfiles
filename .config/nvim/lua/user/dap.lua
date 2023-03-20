local status_ok, dap = pcall(require, 'dap')
if not status_ok then
  vim.notify("Failed to load package 'dap'", vim.log.levels.WARN)
  return
end

-- dap.adapters.dart = {
--   type = "executable",
--   command = "node",
--   args = { os.getenv('HOME') .. "/ghq/github.com/Dart-Code/Dart-Code/out/dist/debug.js", "flutter" }
-- }
-- dap.configurations.dart = {
--   {
--     type = "dart",
--     request = "launch",
--     name = "Launch Flutter",
--     dartSdkPath = "/opt/homebrew/Caskroom/flutter/3.0.4/flutter/bin/cache/dart-sdk/",
--     flutterSdkPath = "/opt/homebrew/Caskroom/flutter/3.0.4/flutter",
--     program = "${workspaceFolder}/lib/main.dart",
--     cwd = "${workspaceFolder}",
--     toolArgs = { "--device-id", "chrome" }
--   }
-- }

dap.set_log_level('TRACE')

vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<F5>', function() require "dap".continue() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F10>', function() require "dap".step_over() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F11>', function() require "dap".step_into() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F12>', function() require "dap".step_out() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', function() require "dap".toggle_breakpoint() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', function() require "dap".terminate() end, { noremap = true, silent = true })

local status_ok, dapui = pcall(require, 'dapui')
if not status_ok then
  vim.notify("Failed to load package 'dapui'", vim.log.levels.WARN)
  return
end

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
