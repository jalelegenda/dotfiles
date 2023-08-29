local builtin = require'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
vim.keymap.set('n', '<leader>sb', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>sw', builtin.lsp_workspace_symbols, {})

