return {
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
}
