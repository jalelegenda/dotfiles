local common = require("core.common")

return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", --[[ "ruff_format" ]] "black" },
                -- Use a sub-list to run only the first available formatter
                javascript = { "prettierd", "prettier" },
                yaml = { "prettier" },
                docker = { "prettier" },
                css = { "prettier" },
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
