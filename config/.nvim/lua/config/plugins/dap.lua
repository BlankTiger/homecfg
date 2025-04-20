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
                        local file =
                            vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        vim.notify(file)
                        return file
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    -- args = { "--port", "13000" },
                },

                {
                    name = "Launch file with args",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        local file =
                            vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        vim.notify(file)
                        return file
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = function()
                        local argument_string = vim.fn.input("Program arguments: ")
                        return vim.fn.split(argument_string, " ", true)
                    end,
                },
            }

            -- dap.configurations.rust = dap.configurations.cpp
            -- dap.configurations.rust = {
            --     {
            --         name = "hello-world",
            --         type = "lldb",
            --         request = "launch",
            --         program = function()
            --             return vim.fn.getcwd() .. "/target/debug/hello-world"
            --         end,
            --         cwd = "${workspaceFolder}",
            --         stopOnEntry = false,
            --     },
            --     {
            --         name = "hello-dap",
            --         type = "lldb",
            --         request = "launch",
            --         program = function()
            --             return vim.fn.getcwd() .. "/target/debug/hello-dap"
            --         end,
            --         cwd = "${workspaceFolder}",
            --         stopOnEntry = false,
            --     },
            -- }

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
        end,
    },
}
