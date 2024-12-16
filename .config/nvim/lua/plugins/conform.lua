local common = require("core.common")

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = {
                    -- "ruff_format",
                    "isort",
                    "black",
                    "autoflake",
                },
                -- Use a sub-list to run only the first available formatter
                javascript = { "prettierd", "prettier" },
                yaml = { "prettier" },
                docker = { "prettier" },
                css = { "prettier" },
            },
            formatters = {
                autoflake = {
                    command = "autoflake",
                    args = function(_, bufnr)
                        return {
                            "--remove-unused-variables",
                            "--remove-all-unused-imports",
                            "--in-place",
                            vim.api.nvim_buf_get_name(bufnr.buf),
                        }
                    end,
                    stdin = false,
                },
            },
        })

        -- conform.formatters.ruff_format = {
        --     options = {
        --         line_width = 99,
        --     },
        -- }
        --
        common.map({ "n", "v" }, "<leader>F", conform.format, common.opts)
    end,
}
