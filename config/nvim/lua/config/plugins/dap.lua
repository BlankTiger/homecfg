return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    {
                        "mfussenegger/nvim-dap-python",
                        ft = "python",
                        config = function(_, _)
                            local path = "~/venv/bin/python"
                            require("dap-python").setup(path)
                        end,
                    },
                    {
                        "leoluz/nvim-dap-go",
                        config = function()
                            require("dap-go").setup()
                        end,
                    },
                    "jay-babu/mason-nvim-dap.nvim",
                    "nvim-neotest/nvim-nio",
                },
                config = function()
                    local dap = require("dap")
                    local dapui = require("dapui")
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
                end,
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local mason_dap = require("mason-nvim-dap")

            mason_dap.setup({
                ensure_installed = { "cppdbg", "delve" },
                automatic_installation = true,
                handlers = {
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                name = "lldb",
                executable = {
                    command = "/home/blanktiger/.local/share/nvim/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = true,
                },
            }

            dap.configurations.zig = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },

                {
                    name = "Launch file (args)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = function()
                        local input = vim.fn.input("args: ")
                        return vim.split(input, " ")
                    end,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            for _, v in pairs(dap.configurations.python) do
                v["justMyCode"] = false
            end

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            "scopes",
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40,
                        position = "left", -- Can be "left", "right", "top", "bottom"
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
            )
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
            )

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            local set = vim.keymap.set

            set("n", "<F4>", dap.pause)
            set("n", "<F5>", dap.continue)
            set("n", "<F6>", dap.step_over)
            set("n", "<F7>", dap.step_into)
            set("n", "<F8>", dap.step_out)
            set("n", "<F9>", dap.terminate)
            set("n", "<leader>db", dap.toggle_breakpoint)
            set("n", "<leader>dB", function()
                local conditional = vim.fn.input("Break if -> ")
                require("dap").set_breakpoint(conditional)
            end)
            set("n", "<leader>du", dapui.toggle)
            set("n", "<leader>dr", dap.repl.toggle)
        end,
    },
}
