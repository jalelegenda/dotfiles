local common = require("core.common")

return {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
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
        common.map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { remap = true, silent = true })
        common.map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { remap = true, silent = true })
        common.map("n", "<leader>lf", "<Cmd>NvimTreeFindFile<CR>", { remap = true, silent = true })
    end,
}
