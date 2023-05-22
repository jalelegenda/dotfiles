vim.g.mapleader = ' '

-- normal mode
vim.keymap.set('n', 'H', vim.cmd.tabprevious)
vim.keymap.set('n', 'L', vim.cmd.tabnext)
vim.keymap.set('n', '<Leader>w', vim.cmd.NvimTreeToggle)

-- insert mode
