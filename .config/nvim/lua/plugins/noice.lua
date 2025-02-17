local common = require("core.common")

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            signature = {
                enabled = true,
                auto_open = { enabled = false },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            },
            notify = {
                win_options = {
                    winblend = 0,
                },
            },
            popup = {
                win_options = {
                    winblend = 0,
                },
            },
        },
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function(_, opts)
        common.map(
            "n",
            "<leader>dd",
            "<Cmd>NoiceDismiss<CR>",
            common.set_desc(common.opts, { desc = "Dismiss notifications" })
        )
        require("noice").setup(opts)
    end,
}
