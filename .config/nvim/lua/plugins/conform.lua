local map = vim.keymap.set
local conform = require("conform")

local opts = { noremap = true, silent = true }

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
    },
})

map({ "n", "v" }, "<leader>F", conform.format, opts)
