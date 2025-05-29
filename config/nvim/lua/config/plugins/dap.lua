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

                {
                    name = "Debug Zig Tests",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        -- Build test executable first
                        vim.fn.system(
                            "zig test --test-no-exec -femit-bin=zig-out/test " .. vim.fn.expand("%")
                        )
                        return vim.fn.getcwd() .. "/zig-out/test"
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.configurations.c = dap.configurations.cpp

            for _, v in pairs(dap.configurations.python) do
                v["justMyCode"] = false
            end

            local togglable = {
                left = { "scopes", "breakpoints", "stacks", "watches" },
                bottom = { "console", "repl" },
            }

            local elements_left = {
                "scopes",
            }
            local elements_bottom = {
                "console",
            }

            local dapui_setup = function(left, bottom)
                dapui.setup({
                    controls = { enabled = false },
                    layouts = {
                        {
                            elements = left,
                            size = 90,
                            position = "left",
                        },
                        {
                            elements = bottom,
                            size = 20,
                            position = "bottom",
                        },
                    },
                })
            end
            dapui_setup(elements_left, elements_bottom)

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

            -- Function to toggle UI elements with a menu
            local function toggle_ui_element()
                -- Create list of all togglable elements
                local togglable_ui = {}
                for position, elements in pairs(togglable) do
                    for _, element in ipairs(elements) do
                        table.insert(togglable_ui, element)
                    end
                end

                vim.ui.select(togglable_ui, {
                    prompt = "Select UI element to toggle:",
                    format_item = function(item)
                        return "󰙳 " .. item:gsub("^%l", string.upper) -- Add icon and capitalize first letter
                    end,
                }, function(choice, idx)
                    if choice then
                        -- Close current UI
                        dapui.close()

                        -- Determine which position this element belongs to
                        local target_position = nil
                        for position, elements in pairs(togglable) do
                            for _, element in ipairs(elements) do
                                if element == choice then
                                    target_position = position
                                    break
                                end
                            end
                            if target_position then
                                break
                            end
                        end

                        -- Toggle the element in the appropriate elements table
                        if target_position == "left" then
                            -- Check if element is already in elements_left
                            local found_index = nil
                            for i, element in ipairs(elements_left) do
                                if element == choice then
                                    found_index = i
                                    break
                                end
                            end

                            if found_index then
                                -- Remove element
                                table.remove(elements_left, found_index)
                            else
                                -- Add element
                                table.insert(elements_left, choice)
                            end
                        elseif target_position == "bottom" then
                            -- Check if element is already in elements_bottom
                            local found_index = nil
                            for i, element in ipairs(elements_bottom) do
                                if element == choice then
                                    found_index = i
                                    break
                                end
                            end

                            if found_index then
                                -- Remove element
                                table.remove(elements_bottom, found_index)
                            else
                                -- Add element
                                table.insert(elements_bottom, choice)
                            end
                        end

                        -- Recreate UI with new configuration
                        dapui_setup(elements_left, elements_bottom)

                        -- Reopen UI
                        dapui.open()

                        vim.notify("Toggled " .. choice, vim.log.levels.INFO)
                    end
                end)
            end

            local set = vim.keymap.set

            set("n", "<F4>", dap.pause)
            set("n", "<F5>", dap.continue)
            set("n", "<F6>", dap.step_over)
            set("n", "<F7>", dap.step_into)
            set("n", "<F8>", dap.step_out)
            set("n", "<F9>", toggle_ui_element, { desc = "Toggle DAP UI element" })
            set("n", "<leader>dt", dap.terminate)
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
