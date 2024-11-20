local common = require('core.common')

return {
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
        common.map("n", "<leader>.", "<Cmd>Mason<CR>", common.opts)
    end,
}
