local cmp = require'cmp'

cmp.setup({
   snippet = {
     expand = function(args)
         require'luasnip'.lsp_expand(args.body)
     end,
   },
   window = {
     completion = cmp.config.window.bordered(),
     documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
     ['<C-Space>'] = cmp.mapping.complete(),
     ['<C-e>'] = cmp.mapping.abort(),
     ['<CR>'] = cmp.mapping.confirm({ select = true }),
   }),
   sources = cmp.config.sources({
     { name = 'nvim_lsp' },
     { name = 'luasnip' },
     { name = 'nvim_lua' },
     { name = 'nvim_lsp_signature_help' },
     { name = 'path' },
   }),
})

