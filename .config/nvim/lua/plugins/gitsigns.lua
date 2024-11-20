local common = require("core.common")
return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },
    },
    config = function(_, opts)
        local gitsigns = require("gitsigns")
        local on_attach = function(bufnr)
            local function map(mode, l, r, opts_)
                opts_ = opts_ or {}
                opts_.buffer = bufnr
                vim.keymap.set(mode, l, r, opts_)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end)

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end)

            -- Actions
            map("n", "gss", gitsigns.stage_hunk, common.set_desc(common.opts, { desc = "Stage hunk" }))
            map("n", "gsr", gitsigns.reset_hunk, common.set_desc(common.opts, { desc = "Reset hunk" }))
            map("v", "gss", function()
                gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, common.set_desc(common.opts, { desc = "Git stage hunk" }))
            map("v", "gsr", function()
                gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, common.set_desc(common.opts, { desc = "Git stage hunk" }))
            -- map("n", "<leader>hS", gitsigns.stage_buffer)
            -- map("n", "<leader>hu", gitsigns.undo_stage_hunk)
            -- map("n", "<leader>hR", gitsigns.reset_buffer)
            -- map("n", "<leader>hR", gitsigns.reset_buffer)
            -- map("n", "<leader>hp", gitsigns.preview_hunk)
            -- map("n", "gsb", function()
            --     gitsigns.blame_line({ full = true })
            -- end)
            map("n", "gsb", gitsigns.toggle_current_line_blame, common.set_desc(common.opts, { desc = "Toggle line blame" }))
            map("n", "gsd", function()
                gitsigns.diffthis("~")
            end, common.set_desc(common.opts, { desc = "Show file diff" }))
            map("n", "gsl", gitsigns.toggle_deleted, common.set_desc(common.opts, { desc = "Toggle deleted lines" }))

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end
        gitsigns.setup({ opts = opts, on_attach = on_attach })
    end,
}
