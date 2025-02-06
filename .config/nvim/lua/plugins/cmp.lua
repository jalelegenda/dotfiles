return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "folke/lazydev.nvim",
    },
    opts = {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    },
    config = function(_, opts)
        local cmp = require("cmp")
        opts.window = {
            documentation = cmp.config.window.bordered({
                border = "single",
                winblend = 0,
                max_width = 20,
                max_height = 20,
            }),
            completion = cmp.config.window.bordered({
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                winblend = 0,
            }),
        }
        opts.mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
        })
        opts.sources = cmp.config.sources({
            { name = "nvim_lsp", priority = 11 },
            { name = "luasnip", priority = 7 },
            { name = "nvim_lua", priority = 9 },
            { name = "nvim_lsp_signature_help", priority = 10 },
            { name = "path", priority = 5 },
            { name = "render-markdown" },
        })
        opts.preselect = { cmp.PreselectMode.None }
        cmp.setup(opts)
    end,
}
