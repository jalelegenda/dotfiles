local common = require("core.common")
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_python = require("dap-python")

        dapui.setup()
        dap_python.setup("python")

        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = { "-m", "debugpy.adapter" },
        }
        dap.adapters.python_attach = {
            type = "server",
            port = 5678,
        }

        dap.configurations.python = {
            {
                name = "Launch Django",
                type = "python",
                request = "launch",
                env = {
                    -- PYTHONUNBUFFERED = 1,
                    DJANGO_SETTINGS_MODULE = "televend3.settings.local",
                    PYDEVD_USE_CYTHON = "NO",
                    CONF = "dev",
                },
                program = "${workspaceFolder}/manage.py",
                args = { "runserver", "--noreload" },
                console = "integratedTerminal",
                justMyCode = false,
                subProcess = false,
            },
            {
                name = "Launch FastAPI",
                type = "python",
                request = "launch",
                module = "uvicorn",
                args = { "service.main:app", "--host", "0.0.0.0", "--port", "8001" },
                console = "integratedTerminal",
                justMyCode = false,
            },
            {
                name = "Attach to Django",
                type = "python_attach",
                request = "attach",
                connect = {
                    host = "127.0.0.1",
                    port = 5678,
                },
            },
            {
                name = "Pytest: Current File",
                type = "python",
                request = "launch",
                module = "pytest",
                args = {
                    "${file}",
                    "-rxXs",
                    "--reuse-db",
                    "--no-cov",
                },
                console = "integratedTerminal",
            },
        }

        common.map(
            "n",
            "<leader>db",
            "<Cmd>DapToggleBreakpoint<CR>",
            common.set_desc(common.opts, { desc = "Toggle breakpoint" })
        )
        common.map("n", "<F5>", "<Cmd>DapContinue<CR>", common.set_desc(common.opts, { desc = "Debug start/continue" }))
        common.map("n", "<F10>", "<Cmd>DapStepOver<CR>", common.set_desc(common.opts, { desc = "Step over" }))
        common.map("n", "<F11>", "<Cmd>DapStepInto<CR>", common.set_desc(common.opts, { desc = "Step into" }))
        common.map("n", "<F12>", "<Cmd>DapStepOut<CR>", common.set_desc(common.opts, { desc = "Step out" }))
        common.map("n", "<leader>dpr", function()
            dap_python.test_method()
        end, common.set_desc(common.opts, { desc = "Run test method" }))
    end,
}
