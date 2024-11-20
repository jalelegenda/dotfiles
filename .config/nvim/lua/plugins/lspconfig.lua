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
            common.set_desc(common.opts, "Open diagnostics in floating window")
        )
        common.map("n", "[d", vim.diagnostic.goto_prev, common.set_desc(common.opts, "Go to previous diagnostic"))
        common.map("n", "]d", vim.diagnostic.goto_next, common.set_desc(common.opts, "Go to next diagnostic"))
        common.map("n", "<leader>q", vim.diagnostic.setloclist, common.set_desc(common.opts, "Open diagnostic list"))

        local on_attach = function(client, bufnr)
            -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            common.map("n", "glh", vim.lsp.buf.hover, common.set_desc(bufopts, "Hover info"))
            -- common.map("n", "glD", vim.lsp.buf.declaration, common.set_desc(common.opts, "Go to declaration"))
            common.map("n", "gli", vim.lsp.buf.implementation, common.set_desc(bufopts, "Navigate to implementation"))
            common.map("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
            common.map("n", "glwa", vim.lsp.buf.add_workspace_folder, common.set_desc(bufopts, "Add workspace folder"))
            common.map(
                "n",
                "glwr",
                vim.lsp.buf.remove_workspace_folder,
                common.set_desc(bufopts, "Remove workspace folder")
            )
            common.map("n", "gltd", vim.lsp.buf.type_definition, bufopts)
            common.map("n", "glr", vim.lsp.buf.rename, common.set_desc(bufopts, "Rename symbol"))
            common.map("n", "glc", vim.lsp.buf.code_action, common.set_desc(bufopts, "Code actions"))
            common.map(
                "n",
                "gla",
                require("telescope.builtin").lsp_references,
                common.set_desc(bufopts, "List all references")
            )
        end

        local lsp_flags = {
            -- This is the default in Nvim 0.7+
            debounce_text_changes = 150,
        }

        local lsps = {
            basedpyright = {},
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
                            location = "/home/jakov/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            },
            volar = {
                init_options = {
                    typescript = {
                        tsdk = "~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib",
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
            },
            -- autotools_ls = {},
        }

        for lsp, settings in pairs(lsps) do
            -- if lsp == "ts_ls" then
            --     require("notify").notify(lsp, "debug", opts)
            -- end
            lspconfig[lsp].setup({
                on_attach = on_attach,
                flags = lsp_flags,
                settings = settings,
                capabilities = capabilities,
            })
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
