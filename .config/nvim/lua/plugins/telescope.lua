local common = require("core.common")
return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.4",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "someone-stole-my-name/yaml-companion.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--follow", -- Follow symbolic links
                    "--hidden", -- Search for hidden files
                    "--no-heading", -- Don't group matches by each file
                    "--with-filename", -- Print the file path with the matched lines
                    "--line-number", -- Show line numbers
                    "--column", -- Show column numbers
                    "--smart-case", -- Smart case search

                    -- Exclude some patterns from search
                    "--glob=!**/.git/*",
                    "--glob=!**/.idea/*",
                    "--glob=!**/.vscode/*",
                    "--glob=!**/build/*",
                    "--glob=!**/dist/*",
                    "--glob=!**/yarn.lock",
                    "--glob=!**/package-lock.json",
                },
            },
            hidden = true,
            pickers = {
                find_files = {
                    layout_config = { width = 0.8, height = 0.6 },
                    hidden = true,
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/build/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/yarn.lock",
                        "--glob=!**/package-lock.json",
                        "--glob=!**/__pycache__/*",
                        "--glob=!**/.venv/*",
                    },
                    theme = "dropdown",
                },
            },
        })

        common.map("n", "<leader>ff", builtin.find_files, common.set_desc(common.opts, { desc = "Search for files" }))
        common.map("n", "<leader>fw", builtin.live_grep, common.set_desc(common.opts, { desc = "Search in files" }))
        common.map("n", "<leader>fb", builtin.buffers, common.set_desc(common.opts, { desc = "List buffers" }))
        common.map(
            "n",
            "<leader>fs",
            builtin.grep_string,
            common.set_desc(common.opts, { desc = "Search for string under cursor" })
        )
        common.map(
            "n",
            "<leader>fm",
            builtin.lsp_document_symbols,
            common.set_desc(common.opts, { desc = "List document symbols" })
        )
        common.map(
            "n",
            "<leader>fc",
            builtin.lsp_dynamic_workspace_symbols,
            common.set_desc(common.opts, { desc = "List workspace symbols" })
        )
        common.map("n", "<leader>fR", builtin.registers, common.set_desc(common.opts, { desc = "List registers" }))
        common.map(
            "n",
            "<leader>fn",
            "<Cmd>Telescope notify<CR>",
            common.set_desc(common.opts, { desc = "List notifications" })
        )
        telescope.load_extension("yaml_schema")
    end,
}
