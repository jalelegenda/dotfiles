local common = require("core.common")

return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        capabilities.offsetEncoding = "utf-8"

        common.map(
            "n",
            "<leader>e",
            vim.diagnostic.open_float,
            common.set_desc(common.opts, { desc = "Open diagnostics in floating window" })
        )
        common.map(
            "n",
            "[d",
            vim.diagnostic.goto_prev,
            common.set_desc(common.opts, { desc = "Go to previous diagnostic" })
        )
        common.map(
            "n",
            "]d",
            vim.diagnostic.goto_next,
            common.set_desc(common.opts, { desc = "Go to next diagnostic" })
        )
        common.map(
            "n",
            "<leader>q",
            vim.diagnostic.setloclist,
            common.set_desc(common.opts, { desc = "Open diagnostic list" })
        )

        local on_attach = function(client, bufnr)
            -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            common.map("n", "<leader>h", vim.lsp.buf.hover, common.set_desc(bufopts, { desc = "Hover info" }))
            common.map("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
            common.map(
                "n",
                "glwa",
                vim.lsp.buf.add_workspace_folder,
                common.set_desc(bufopts, { desc = "Add workspace folder" })
            )
            common.map(
                "n",
                "glwr",
                vim.lsp.buf.remove_workspace_folder,
                common.set_desc(bufopts, { desc = "Remove workspace folder" })
            )
            common.map("n", "glr", vim.lsp.buf.rename, common.set_desc(bufopts, { desc = "Rename symbol" }))
            common.map("n", "glc", vim.lsp.buf.code_action, common.set_desc(bufopts, { desc = "Code actions" }))
            common.map(
                "n",
                "gla",
                require("telescope.builtin").lsp_references,
                common.set_desc(bufopts, { desc = "List all references" })
            )
        end

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }

        local lsps = {
            -- pylsp = {},
            basedpyright = {
                basedpyright = {
                    analysis = {
                        diagnosticSeverityOverrides = {
                            reportUnusedCallResult = "none",
                            reportAny = "none",
                            reportUnannotatedClassAttribute = "none",
                            reportImplicitStringConcatenation = "none",
                        },
                        autoImportCompletions = true,
                    },
                },
            },
            lua_ls = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
            terraformls = {},
            docker_compose_language_service = {},
            dockerls = {},
            graphql = {},
            tailwindcss = {},
            cssls = {},
            html = { filetypes = { "html", "htmldjango", "templ" } },
            bashls = {},
            yamlls = {
                yaml = {
                    schemaStore = {
                        enable = false,
                    },
                    schemas = {
                        kubernetes = "*/*k8s*/*.{yml,yaml}",
                        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*compose*.{yml,yaml}",
                        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                    },
                },
            },
            clangd = {},
            zls = {},
            gopls = {},
            ts_ls = {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "/home/jakov/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            },
            volar = {},
            -- autotools_ls = {},
            gdscript = {
                cmd = { "nvim", "--listen", "/tmp/godot.pipe" },
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            },
            djlsp = {},
            buf_ls = {},
            jsonls = {},
        }

        for lsp, settings in pairs(lsps) do
            local opts = {
                on_attach = on_attach,
                flags = lsp_flags,
                capabilities = capabilities,
            }
            if lsp == "ts_ls" then
                opts.init_options = settings.init_options
                opts.filetypes = settings.filetypes
            else
                opts.settings = settings
            end
            lspconfig[lsp].setup(opts)
        end
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = "sh",
        --     callback = function()
        --         vim.lsp.start({
        --             name = "bash-language-server",
        --             cmd = { "bash-language-server", "start" },
        --         })
        --     end,
        -- })
    end,
}
