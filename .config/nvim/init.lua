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
	dependencies = {
	    'nvim-lua/plenary.nvim',
	    'nvim-telescope/telescope-live-grep-args.nvim',
	},
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
	    'hrsh7th/cmp-nvim-lua',
	    'hrsh7th/cmp-nvim-lsp-signature-help',
	},
    },
    {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
	    'nvim-treesitter/nvim-treesitter-textobjects',
	},
    },
    {
	'kylechui/nvim-surround',
	event = 'VeryLazy',
	config = function()
	    require'nvim-surround'.setup{}
	end,
    },
    {
	'Vonr/align.nvim',
    },
    {
	'L3MON4D3/LuaSnip',
    },
    {
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
	'folke/which-key.nvim',
	event = "VeryLazy",
	init = function()
	    vim.o.timeout = true
	    vim.o.timeoutlen = 300
	end,
	opts = {},
    },
    {
	'romgrk/barbar.nvim',
        dependencies = {
	    'nvim-tree/nvim-web-devicons',
	},
    },
    {
	'rafamadriz/friendly-snippets'
    },
    {
        'folke/persistence.nvim',
	event = "BufReadPre",
	opts = {}
    },
    {
	'gbprod/yanky.nvim',
    },
    {
	'Pocco81/auto-save.nvim',
	config = function()
	    require'auto-save'.setup{}
	end,
    },

})

require'plugins.telescope'
require'plugins.mason'
require'plugins.treesitter'
require'plugins.nvim_tree'
require'plugins.nvim_cmp'
require'plugins.nvim_lspconfig'
require'plugins.align'
require'plugins.barbar'
require'persistence'.load()
vim.cmd[[colorscheme tokyonight-moon]]
