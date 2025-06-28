local common = require("core.common")

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
    config = function(_, opts)
        local barbar = require("barbar")
        common.map("n", "H", "<Cmd>BufferPrevious<CR>", common.opts)
        common.map("n", "L", "<Cmd>BufferNext<CR>", common.opts)
        common.map(
            "n",
            "<leader>x",
            "<Cmd>BufferClose<CR>",
            common.set_desc(common.opts, { desc = "Close current buffer" })
        )
        common.map(
            "n",
            "<leader>X",
            "<Cmd>BufferCloseAllButCurrent<CR>",
            common.set_desc(common.opts, { desc = "Close all buffers except current one" })
        )
        common.map(
            "n",
            "<leader>XL",
            "<Cmd>BufferCloseBuffersRight<CR>",
            common.set_desc(common.opts, { desc = "Close all buffers to the right" })
        )
        common.map(
            "n",
            "<leader>XH",
            "<Cmd>BufferCloseBuffersLeft<CR>",
            common.set_desc(common.opts, { desc = "Close all buffers to the left" })
        )
        common.map(
            "n",
            "<leader>r",
            "<Cmd>BufferRestore<CR>",
            common.set_desc(common.opts, { desc = "Restore closed buffer" })
        )
        common.map(
            "n",
            "<leader>c",
            "<Cmd>BufferPick<CR>",
            common.set_desc(common.opts, { desc = "Magic pick buffer" })
        )
        common.map(
            "n",
            "<leader>oc",
            "<Cmd>BufferPickDelete<CR>",
            common.set_desc(common.opts, { desc = "Magic pick close buffer" })
        )
        common.map(
            "n",
            "<leader>od",
            "<Cmd>BufferOrderByDirectory<CR>",
            common.set_desc(common.opts, { desc = "Order buffers by directory" })
        )

        barbar.setup(opts)
    end,
    version = "^1.0.0",
}
