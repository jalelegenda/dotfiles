vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- normal mode
vim.keymap.set('n', '<C-BS>', 'db', opts)
vim.keymap.set('n', '<C-k>', 'ddkP', opts)
vim.keymap.set('n', '<C-j>', 'ddp', opts)
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', opts)
vim.keymap.set('n', 'H', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', 'L', '<Cmd>BufferNext<CR>', opts)
vim.keymap.set('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)
vim.keymap.set('n', '<leader>X', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
vim.keymap.set('n', '<leader>Xl', '<Cmd>BufferCloseBuffersRight<CR>', opts)
vim.keymap.set('n', '<leader>Xh', '<Cmd>BufferCloseBuffersLeft<CR>', opts)


-- insert mode
vim.keymap.set('i', '<C-Del>', '<Cmd>delete<Cmd>', opts)
