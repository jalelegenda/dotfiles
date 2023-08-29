vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- normal mode
vim.keymap.set('n', '<C-BS>', 'db', opts)
vim.keymap.set('n', '<C-k>', 'ddkP', opts)
vim.keymap.set('n', '<C-j>', 'ddp', opts)
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', opts)


-- insert mode
vim.keymap.set('i', '<C-Del>', '<Cmd>delete<Cmd>', opts)
