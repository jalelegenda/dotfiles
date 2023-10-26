return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                },
            },
            move = {
                enable = true,
                lookahead = true,
                goto_next_start = {
                    ["mf"] = "@function.outer",
                    ["mc"] = "@class.outer",
                },
                goto_next_end = {
                    ["mef"] = "@function.outer",
                    ["mec"] = "@class.outer",
                },
                goto_previous_start = {
                    ["Mf"] = "@function.outer",
                    ["Mc"] = "@class.outer",
                },
                goto_previous_end = {
                    ["mef"] = "@function.outer",
                    ["mec"] = "@class.outer",
                },
            },
        },
    },
}
