local status_ok, luasnip = pcall(require, 'luasnip')
if not status_ok then
  vim.notify("Failed to load package 'luasnip'.", vim.log.levels.WARN)
  return
end

-- luasnip setup
-- require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/snippets"}})
-- luasnip.filetype_extend("dart", { "flutter" })

-- vim.o.runtimepath = vim.o.runtimepath..',~/.config/nvim/lua/friendly-snippets'
require("luasnip/loaders/from_vscode").load()

local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
  vim.notify("Failed to load package 'cmp'", vim.log.levels.WARN)
  return
end

-- nvim-cmp setup
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
