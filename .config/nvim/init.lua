local common = require("core.common")
require("core.options")
require("core.keymap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local excludes = {
    "minuet",
    "rest",
    "dbee",
    "toggleterm",
}

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
    { "Pocco81/auto-save.nvim", config = true },
    { "echasnovski/mini.align", config = true },
    { "echasnovski/mini.pairs", config = true },
    { "echasnovski/mini.indentscope", config = true },
    { "Bilal2453/luvit-meta", lazy = true },
    { "echasnovski/mini.comment", config = true, version = "*" },
    {
        "folke/lazydev.nvim",
        dependencies = { "Bilal2453/luvit-meta" },
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "gbprod/nord.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-frappe]])
        end,
    }, -- {
    --     "AlexvZyl/nordic.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("nordic").load({ transparent = { bg = true, float = true } })
    --     end,
    -- },
    {
        "folke/persistence.nvim",
        {
            "folke/persistence.nvim",
            event = "BufReadPre",
            opts = {},
        },
    },
    {
        "johmsalas/text-case.nvim",
        event = "VeryLazy",
        config = function()
            require("textcase").setup({})
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- Dynamically load all plugins from the plugins directory
    unpack(common.require_plugins(excludes)),
}, {
    ui = {
        border = "single",
    },
})

common.map("n", "<leader>,", "<cmd>Lazy<cr>", common.opts)
common.map(
    "n",
    "<leader>ls",
    [[<cmd>lua require("persistence").load()<cr>]],
    common.set_desc(common.opts, { desc = "Load directory session" })
)
vim.lsp.set_log_level("error")
require("luasnip.loaders.from_vscode").lazy_load()
