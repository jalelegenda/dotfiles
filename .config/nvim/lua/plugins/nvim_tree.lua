require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  git = {
    enable = false,
  },
})

vim.keymap.set('n', '<leader>t','<Cmd>NvimTreeToggle<CR>', { remap = true, silent = true })
