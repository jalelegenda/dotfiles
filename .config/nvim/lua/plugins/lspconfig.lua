local map = vim.keymap.set

local set_desc = function(t, desc)
    t.desc = desc
    return t
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local opts = { noremap = true, silent = true }

        map("n", "<leader>e", vim.diagnostic.open_float, set_desc(opts, "Open diagnostics in floating window"))
        map("n", "[d", vim.diagnostic.goto_prev, set_desc(opts, "Go to previous diagnostic"))
        map("n", "]d", vim.diagnostic.goto_next, set_desc(opts, "Go to next diagnostic"))
        map("n", "<leader>q", vim.diagnostic.setloclist, set_desc(opts, "Open diagnostic list"))

        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            map("n", "glD", vim.lsp.buf.declaration, set_desc(opts, "Go to declaration"))
            map("n", "gld", vim.lsp.buf.definition, set_desc(opts, "Go to definition"))
            map("n", "glh", vim.lsp.buf.hover, set_desc(bufopts, "Hover info"))
            map("n", "gli", vim.lsp.buf.implementation, set_desc(bufopts, "Navigate to implementation"))
            map("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
            map("n", "glwa", vim.lsp.buf.add_workspace_folder, set_desc(bufopts, "Add workspace folder"))
            map("n", "glwr", vim.lsp.buf.remove_workspace_folder, set_desc(bufopts, "Remove workspace folder"))
            map("n", "glwl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, set_desc(bufopts, "List workspace folders"))
            map("n", "gltd", vim.lsp.buf.type_definition, bufopts)
            map("n", "glr", vim.lsp.buf.rename, set_desc(bufopts, "Rename symbol"))
            map("n", "glc", vim.lsp.buf.code_action, set_desc(bufopts, "Code actions"))
            map("n", "gla", require("telescope.builtin").lsp_references, set_desc(bufopts, "List all references"))
        end

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }

        local lsps = {
            ["pylsp"] = {
                pylsp = {
                    plugins = {
                        configurationSources = { "pycodestyle" },
                        jedi_completion = { enabled = true },
                        jedi_hover = { enabled = false },
                        jedi_references = { enabled = true },
                        jedi_signature_help = { enabled = true },
                        jedi_symbols = { enabled = true },
                        jedi = { environment = ".venv" },
                        pycodestyle = { enabled = false },
                        flake8 = { enabled = false },
                        pyflakes = {enabled = false },
                        mypy = { enabled = false },
                        isort = { enabled = false },
                        yapf = { enabled = false },
                        pylint = { enabled = false },
                        mccabe = { enabled = false },
                        preload = { enabled = false },
                        rope_completion = { enabled = true },
                    },
                },
            },
            ["lua_ls"] = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
            ["eslint"] = {},
            ["tsserver"] = {},
            --    ['terraformls'] = {},
            ["docker_compose_language_service"] = {},
            ["dockerls"] = {},
            ["graphql"] = {},
            ["cssls"] = {},
            ["html"] = {},
            ["tailwindcss"] = {},
        }

        for lsp, settings in pairs(lsps) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                flags = lsp_flags,
                settings = settings,
                capabilities = capabilities,
            })
        end
    end,
}
