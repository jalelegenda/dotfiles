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
        {
            "onsails/lspkind.nvim",
            config = function()
                local lspkind = require("lspkind")
                lspkind.init({
                    symbol_map = {
                        Copilot = "",
                    },
                })
                vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

            end,
        },
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
        local lspkind = require("lspkind")
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
            { name = "copilot", group_index = 2 },
            { name = "nvim_lsp", priority = 11 },
            { name = "luasnip", priority = 7 },
            { name = "nvim_lua", priority = 9 },
            { name = "nvim_lsp_signature_help", priority = 10 },
            { name = "path", priority = 5 },
            { name = "render-markdown" },
        })
        opts.formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = {
                    menu = 50,
                    abbr = 50,
                },
                ellipsis_char = "...",
                show_labelDetails = true,
                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    -- ...
                    return vim_item
                end,
            }),
        }
        opts.preselect = { cmp.PreselectMode.None }
        cmp.setup(opts)
    end,
}
