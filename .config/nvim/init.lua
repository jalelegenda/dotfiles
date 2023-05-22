vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require'keymap'
require'options'


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require'lazy'.setup({
    {
	'williamboman/mason.nvim',
	dependencies = {
	    'neovim/nvim-lspconfig',
	    'williamboman/mason-lspconfig.nvim',
	    'mfussenegger/nvim-dap',
	    'mfussenegger/nvim-lint',
	    'mhartington/formatter.nvim',
	},
    },
    {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.1',
	dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
	'neovim/nvim-lspconfig',
    },
    {
	'hrsh7th/nvim-cmp',
	dependencies = {
	    'hrsh7th/cmp-nvim-lsp',
	    'hrsh7th/cmp-buffer',
	    'hrsh7th/cmp-path',
	    'hrsh7th/cmp-cmdline',
	},
    },
    {
	'dcampos/nvim-snippy',
    },
    {
	'nvim-treesitter/nvim-treesitter',
    },
    {
	'L3MON4D3/LuaSnip',
    },
    {
	'nvim-tree/nvim-tree.lua',
    },
    {
	'rockerBOO/boo-colorscheme-nvim',
    },
})

require'plugins.telescope'
require'plugins.mason'
require'plugins.treesitter'
require'plugins.nvim_tree'
require'plugins.nvim_cmp'
require'plugins.nvim_lspconfig'

require("boo-colorscheme").use({
  italic = true, -- toggle italics
  theme = "forest_stream"
})
