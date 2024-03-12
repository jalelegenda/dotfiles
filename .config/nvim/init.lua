local common = require("core.common")
require("core.options")
require("core.keymap")

local set_desc = function(t, desc)
    t.desc = desc
    return t
end

local keymap_opts = { noremap = true, silent = true }
local map = vim.keymap.set

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.lsp.set_log_level("debug")

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
                border = "single",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            map("n", "<leader>.", "<Cmd>Mason<CR>", keymap_opts)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        tag = "0.1.4",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "someone-stole-my-name/yaml-companion.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                pickers = { find_files = { hidden = true } },
            })

            map("n", "<leader>ff", builtin.find_files, set_desc(keymap_opts, "Search for files"))
            map("n", "<leader>fw", builtin.live_grep, set_desc(keymap_opts, "Search in files"))
            map("n", "<leader>fb", builtin.buffers, set_desc(keymap_opts, "List buffers"))
            map("n", "<leader>fs", builtin.grep_string, set_desc(keymap_opts, "Search for string under cursor"))
            map("n", "<leader>fm", builtin.lsp_document_symbols, set_desc(keymap_opts, "List document symbols"))
            map(
                "n",
                "<leader>fc",
                builtin.lsp_dynamic_workspace_symbols,
                set_desc(keymap_opts, "List workspace symbols")
            )
            map("n", "<leader>fR", builtin.registers, set_desc(keymap_opts, "List registers"))
            map("n", "<leader>fn", "<Cmd>Telescope notify<CR>", set_desc(keymap_opts, "List notifications"))
            telescope.load_extension("yaml_schema")
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
            })
            opts.preselect = { cmp.PreselectMode.None }
            cmp.setup(opts)
        end,
    },
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
    { "Bilal2453/luvit-meta", lazy = true },
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
    -- {
    --     "echasnovski/mini.animate",
    --     config = true,
    --     version = "*",
    --     opts = {
    --         cursor = {
    --             timing = function(_, n)
    --                 return 100 / n
    --             end,
    --         },
    --         scroll = {
    --             timing = function(_, n)
    --                 return 50 / n
    --             end,
    --         },
    --     },
    -- },
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
            map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { remap = true, silent = true })
            map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { remap = true, silent = true })
            map("n", "<leader>lf", "<Cmd>NvimTreeFindFile<CR>", { remap = true, silent = true })
        end,
    },
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                italics = true,
                transparent_background_level = 1,
            })
            vim.cmd([[colorscheme everforest]])
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
                signature = {
                    enabled = true,
                    auto_open = { enabled = false },
                },
            },
            views = {
                mini = {
                    win_options = {
                        winblend = 0,
                    },
                },
                notify = {
                    win_options = {
                        winblend = 0,
                    },
                },
                popup = {
                    win_options = {
                        winblend = 0,
                    },
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
    -- {
    --     "mfussenegger/nvim-lint",
    --     config = function()
    --         require("lint").linters_by_ft = {
    --             python = { "pylint" },
    --         }
    --         vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    --             callback = function()
    --                 require("lint").try_lint()
    --             end,
    --         })
    --     end,
    -- },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        opts = {
            schemas = {
                {
                    name = "Kubernetes 1.22.4",
                    uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
                },
            },
        },
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
    --             map("n", "<leader>-", dbee.open(), set_desc(keymap_opts, "Open Dbee UI"))
    --         )
    --     end,
    -- },
    -- require("plugins.gitsigns"),
    require("plugins.lualine"),
    require("plugins.lspconfig"),
    require("plugins.treesitter"),
    require("plugins.dap"),
    require("plugins.conform"),
}, {
    ui = {
        border = "single",
    },
})

map("n", "<leader>,", "<cmd>Lazy<cr>", keymap_opts)
map("n", "<leader>ls", [[<cmd>lua require("persistence").load()<cr>]], set_desc(keymap_opts, "Load directory session"))
