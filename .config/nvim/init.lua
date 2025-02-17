local common = require("core.common")
require("core.options")
require("core.keymap")

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
    { "L3MON4D3/LuaSnip", lazy = true },
    { "rafamadriz/friendly-snippets" },
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
            require("catppuccin").setup({
                transparent = true,
            })
            vim.cmd([[colorscheme catppuccin]])
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
    {

        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    -- {
    --     "kndndrj/nvim-dbee",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    --     build = function()
    --         -- Install tries to automatically detect the install method.
    --         -- if it fails, try calling it with one of these parameters:
    --         --    "curl", "wget", "bitsadmin", "go"
    --         require("dbee").install()
    --     end,
    --     config = function()
    --         local dbee = require("dbee")
    --         dbee.setup(
    --             map("n", "<leader>-", dbee.open(), set_desc(common.opts, "Open Dbee UI"))
    --         )
    --     end,
    -- },
    require("plugins.lspconfig"),
    require("plugins.cmp"),
    require("plugins.mason"),
    require("plugins.gitsigns"),
    require("plugins.telescope"),
    require("plugins.lualine"),
    require("plugins.treesitter"),
    require("plugins.dap"),
    require("plugins.conform"),
    require("plugins.nvim_tree"),
    require("plugins.noice"),
    require("plugins.barbar"),
    require("plugins.yaml_companion"),
    require("plugins.vim_illuminate"),
    require("plugins.yanky"),
    require("plugins.whichkey"),
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
