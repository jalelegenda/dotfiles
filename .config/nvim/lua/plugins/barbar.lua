local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', 'H', '<Cmd>BufferPrevious<CR>', opts)
map('n', 'L', '<Cmd>BufferNext<CR>', opts)
map('n', '<leader>x', '<Cmd>BufferClose<CR>', opts)

require'barbar'.setup{
    sidebar_filetypes = {
	NvimTree = true,
    },
}
