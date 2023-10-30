require("options")
require("keymap")

local keymap_opts = { noremap = true, silent = true }
local map = vim.keymap.set

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
            vim.keymap.set("n", "<leader>.", "<Cmd>Mason<CR>", keymap_opts)
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
        opts = {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
        },
        config = function(_, opts)
            local cmp = require("cmp")
            opts.completion = cmp.config.window.bordered()
            opts.window = {
                documentation = cmp.config.window.bordered(),
            }
            opts.mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            })
            opts.sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lua" },
                { name = "nvim_lsp_signature_help" },
                { name = "path" },
            })
            cmp.setup(opts)
        end,
    },
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
        version = "*",
    },
    {
        "echasnovski/mini.animate",
        config = true,
        version = "*",
        opts = {
            cursor = {
                timing = function(_, n)
                    return 100 / n
                end,
            },
            scroll = {
                timing = function(_, n)
                    return 100 / n
                end,
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sort_by = "case_sensitive",
            view = {
                width = 30,
            },
            git = {
                enable = false,
            },
        },
        config = function(_, opts)
            require("nvim-tree").setup(opts)
            vim.keymap.set("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { remap = true, silent = true })
        end,
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
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "folke/noice.nvim",
        },
        config = function()
            local lualine = require("lualine")
            local noice = require("noice")
            local opts = {
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                        },
                        {
                            noice.api.statusline.mode.get,
                            cond = noice.api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                    },
                },
                options = {
                    theme = "tokyonight",
                },
            }
            lualine.setup(opts)
        end,
    },
    {
        "johmsalas/text-case.nvim",
        event = "VeryLazy",
        config = function()
            require("textcase").setup({})
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 100,
                filetype_overrides = {},
                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                    "fugitive",
                },
                filetypes_allowlist = {},
                modes_denylist = {},
                modes_allowlist = {},
                providers_regex_syntax_denylist = {},
                providers_regex_syntax_allowlist = {},
                under_cursor = true,
                large_file_cutoff = 5000,
                large_file_overrides = nil,
                min_count_to_highlight = 1,
                should_enable = function()
                    return true
                end,
                case_insensitive_regex = false,
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                python = { "pylint" },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform will run multiple formatters sequentially
                    python = { "isort", "black" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                },
            })

            map({ "n", "v" }, "<leader>F", conform.format, keymap_opts)
        end,
    },
    require("plugins.gitsigns"),
    require("plugins.lspconfig"),
    require("plugins.treesitter"),
}, {
    ui = {
        border = "rounded",
    },
})

map("n", "<leader>,", "<cmd>Lazy<cr>", keymap_opts)
require("persistence").load()
