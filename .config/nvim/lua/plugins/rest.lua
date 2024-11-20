return {
    "rest-nvim/rest.nvim",
    configure = function()
        local telescope = require("telescope")
        telescope.load_extension("rest")
    end,
}
