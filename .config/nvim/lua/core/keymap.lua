vim.g.mapleader = ' '
local common = require('core.common')

-- normal mode
common.map('n', '<C-k>', '<Cmd>move -2<CR>', common.opts)
common.map('n', '<C-j>', '<Cmd>move +1<CR>', common.opts)
common.map('n', '<Esc>', '<Cmd>nohlsearch<CR>', common.opts)
common.map('n', 'H', '<Cmd>BufferPrevious<CR>', common.opts)
common.map('n', 'L', '<Cmd>BufferNext<CR>', common.opts)
common.map('n', '<leader>x', '<Cmd>BufferClose<CR>', common.opts)
common.map('n', '<leader>X', '<Cmd>BufferCloseAllButCurrent<CR>', common.opts)
common.map('n', '<leader>XL', '<Cmd>BufferCloseBuffersRight<CR>', common.opts)
common.map('n', '<leader>XH', '<Cmd>BufferCloseBuffersLeft<CR>', common.opts)
common.map({ 'n', 'i' }, '<M-h>', '<Cmd><CR>', common.opts)
