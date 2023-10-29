return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
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
                        jedi_hover = { enabled = true },
                        jedi_references = { enabled = true },
                        jedi_signature_help = { enabled = true },
                        jedi_symbols = { enabled = true },
                        jedi = { environment = ".venv" },
                        pycodestyle = { enabled = true },
                        flake8 = { enabled = false },
                        mypy = { enabled = true },
                        isort = { enabled = true },
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
    end
}