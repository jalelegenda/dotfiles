return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/noice.nvim",
    },
    config = function()
        local lualine = require("lualine")
        local noice = require("noice")
        local opts = {
            sections = {
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                    {
                        noice.api.statusline.mode.get,
                        cond = noice.api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                },
            },
            options = {
                theme = "auto",
            },
        }
        lualine.setup(opts)
    end,
}
