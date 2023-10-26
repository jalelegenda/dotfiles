vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local keymap_opts = { noremap = true, silent = true }

require("keymap")
require("options")
local lsp = require("plugins.lspconfig")
local treesitter = require("plugins.treesitter")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-lint",
            "mhartington/formatter.nvim",
        },
        opts = {
            ui = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            vim.keymap.set("n", "<leader><leader>", "<Cmd>Mason<CR>", keymap_opts)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
            vim.keymap.set("n", "<leader>sb", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>sw", builtin.lsp_workspace_symbols, {})
            vim.keymap.set("n", "<leader>rw", builtin.registers, {})
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
    },
    lsp,
    treesitter,
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "echasnovski/mini.align",
        config = true,
    },
    {
        "echasnovski/mini.pairs",
        config = true,
    },
    {
        "echasnovski/mini.indentscope",
        config = true,
    },
    {
        "echasnovski/mini.comment",
        config = true,
        version = false,
    },
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },
    {
        "romgrk/barbar.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            sidebar_filetypes = {
                NvimTree = true,
            },
        },
        version = "^1.0.0",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "folke/persistence.nvim",
        {
            "folke/persistence.nvim",
            event = "BufReadPre",
            opts = {},
        },
    },
    {
        "gbprod/yanky.nvim",
    },
    {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({})
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "johmsalas/text-case.nvim",
        event = "VeryLazy",
        config = function()
            require("textcase").setup({})
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    -- {
    --     "RRethy/vim-illuminate",
    -- },
    {
        "stevearc/conform.nvim",
    },
})

require("plugins.nvim_tree")
require("plugins.nvim_cmp")
require("plugins.noice")
require("plugins.lualine")
require("plugins.gitsigns")
-- require("plugins.illuminate")
require("plugins.conform")
require("plugins.nvim_lint")
require("persistence").load()
