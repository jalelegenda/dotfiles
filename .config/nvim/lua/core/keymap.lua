vim.g.mapleader = ' '
local common = require('core.common')

-- normal mode
common.map('n', '<C-k>', '<Cmd>move -2<CR>', common.opts)
common.map('n', '<C-j>', '<Cmd>move +1<CR>', common.opts)
common.map('n', '<Esc>', '<Cmd>nohlsearch<CR>', common.opts)
common.map({ 'n', 'i' }, '<M-h>', '<Cmd><CR>', common.opts)
