require 'user.plugins'
require 'user.options'
require 'user.keymaps'
require 'user.gitsigns'
require 'user.telescope'
require 'user.treesitter'
require 'user.lsp'
require 'user.nvimlightbulb'
require 'user.cmp'
require 'user.dap'
require 'user.lualine'
require 'user.autopairs'
require 'user.autotag'
require 'user.nvimtree'

-- Flutter tools setup
-- require("flutter-tools").setup {
--   lsp = {
--     on_attach = on_attach,
--     capabilities = capabilities
--   }
-- }
-- vim.api.nvim_set_keymap('n', '<leader>fr', ':FlutterRun<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fq', ':FlutterQuit<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fc', [[<Cmd>lua require('telescope').extensions.flutter.commands()<CR>]],
-- { noremap = true, silent = true })

