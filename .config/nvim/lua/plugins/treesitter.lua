return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function ()
        require("nvim-treesitter.configs").setup({
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
                        ["<leader>af"] = "@function.outer",
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
                        ["mfs"] = "@function.outer",
                        ["mcs"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["mfe"] = "@function.outer",
                        ["mce"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["MFS"] = "@function.outer",
                        ["MCS"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["MFE"] = "@function.outer",
                        ["MCE"] = "@class.outer",
                    },
                },
            },
        })
    end,
}
