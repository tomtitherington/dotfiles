-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  --use 'joshdick/onedark.vim' -- Theme inspired by Atom
  -- use 'tjdevries/colorbuddy.vim'
  --use 'tjdevries/gruvbuddy.nvim'
  use {'dracula/vim', as = 'dracula'}
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' } } -- UI tabs for each open buffer
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- Loads of snippets
  use 'rafamadriz/friendly-snippets'
  use 'kosayoda/nvim-lightbulb' -- Code Action Lightbulb
  -- Flutter/Dart stuff 
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'} -- This plugin starts dartls behind the scenes
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
end)

-- Set shell to bash
vim.opt.shell = "/bin/sh"

--On pressing tab, insert 2 spaces
vim.bo.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd([[colorscheme dracula]])


--Set statusbar
vim.g.lightline = {
  colorscheme = 'dracula',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'FugitiveHead' },
}

-- Remove mode as mode information is displayed in lightline
vim.opt.showmode = false

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("bufferline").setup{}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
  current_line_blame = true,
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>.', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], { noremap = true, silent = true})


-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true, -- false will disable the whole extension
  },
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

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  --vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Vue/Volar language server
nvim_lsp.volar.setup {
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact','vue', 'json'},
  init_options = {
    typescript = {
      serverPath = '/opt/homebrew/lib/node_modules/typescript/lib/tsserverlibrary.js'
    }
  },
  cmd = { 'vue-language-server', '--stdio' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Example custom server
local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- require('lspconfig').sumneko_lua.setup {
--   cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { 'vim' },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
-- require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/snippets"}})
luasnip.filetype_extend("dart", {"flutter"})
-- vim.o.runtimepath = vim.o.runtimepath..',~/.config/nvim/lua/friendly-snippets'
require("luasnip/loaders/from_vscode").load()
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Bufferline

-- require("bufferline").setup{
--   options = {
--     mode = "buffers",
--     numbers = "none",
--     color_icons = true, -- whether or not to add the filetype icon highlights
--     show_buffer_icons = true, -- disable filetype icons for buffers
--     show_buffer_close_icons = false,
--     show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
--     show_close_icon = false,
--     alway_show_bufferline = true
--   }
-- }

-- lspsaga setup
-- local saga = require('lspsaga')
-- saga.init_lsp_saga()
-- -- vim.api.nvim_set_keymap('n', '<leader>.', [[<Cmd>lua require('lspsaga.codeaction').code_action()<CR>]], { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>.', ':Lspsaga code_action<CR>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>fe', [[:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]], { noremap = true, silent = true})
-- nvim-lightbulb setup
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]


-- Flutter tools setup
require("flutter-tools").setup {
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  }
vim.api.nvim_set_keymap('n', '<leader>fr',':FlutterRun<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fq',':FlutterQuit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fc', [[<Cmd>lua require('telescope').extensions.flutter.commands()<CR>]], { noremap = true, silent = true })


-- DAP 
local dap = require('dap')
dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = { os.getenv('HOME').."/ghq/github.com/Dart-Code/Dart-Code/out/dist/debug.js", "flutter"}
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch Flutter",
    dartSdkPath = "/opt/homebrew/Caskroom/flutter/3.0.4/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = "/opt/homebrew/Caskroom/flutter/3.0.4/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
    toolArgs = {"--device-id", "chrome"}
  }
}

dap.set_log_level('TRACE')

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

vim.keymap.set('n', '<F5>', function() require"dap".continue() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F10>', function() require"dap".step_over() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F11>', function() require"dap".step_into() end, { noremap = true, silent = true })
vim.keymap.set('n', '<F12>', function() require"dap".step_out() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', function() require"dap".toggle_breakpoint() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', function() require"dap".terminate() end, {noremap = true, silent = true})

-- TODO use with Flutter Tools for Hot Reload etc.
-- DAP UI
local dapui = require('dapui')
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



