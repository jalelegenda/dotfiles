return {
    {
        "milanglacier/minuet-ai.nvim",
        config = function()
            require("minuet").setup({})
        end,
        dependecies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "Saghen/blink.cmp" },
    },
}
