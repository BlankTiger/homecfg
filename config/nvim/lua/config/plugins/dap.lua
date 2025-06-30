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
                            local venv_path = os.getenv("VIRTUAL_ENV") or ""
                            local path = ""
                            if #venv_path > 0 then
                                path = venv_path .. "/bin/python"
                            end
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
                            "zig test --test-no-exec -femit-bin=zig-out/test -fllvm "
                                .. vim.fn.expand("%")
                        )
                        return vim.fn.getcwd() .. "/zig-out/test"
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },

                {
                    name = "Debug Zig Tests (gdb)",
                    type = "cppdbg",
                    miDebuggerPath = "/usr/bin/gdb",
                    request = "launch",
                    program = function()
                        -- Build test executable first
                        vim.fn.system(
                            "zig test --test-no-exec -femit-bin=zig-out/test -fllvm "
                                .. vim.fn.expand("%")
                        )
                        return vim.fn.getcwd() .. "/zig-out/test"
                    end,
                    cwd = "${workspaceFolder}",
                    setupCommands = {
                        -- {
                        --     text = "target record-full",
                        --     description = "enable stepping back",
                        --     ignoreFailures = false,
                        -- },
                        {
                            text = "-enable-pretty-printing",
                            description = "enable pretty printing",
                            ignoreFailures = false,
                        },
                    },
                    stopOnEntry = true,
                    stopAtEntry = true,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            table.insert(dap.configurations.python, {
                type = "python",
                request = "launch",
                name = "pytest: current file",
                module = "pytest",
                args = {
                    "${file}",
                    "-v",
                    "-s",
                    "--tb=short",
                },
                console = "integratedTerminal",
                -- NOTE: dont forget to install stuff like pytest and pytest-mock
                cwd = "${workspaceFolder}",
            })

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

            function find_dap_repl_buffer()
                local buffers = vim.api.nvim_list_bufs()

                for _, bufnr in ipairs(buffers) do
                    if vim.api.nvim_buf_is_valid(bufnr) then
                        local name = vim.api.nvim_buf_get_name(bufnr)
                        local is_loaded = vim.api.nvim_buf_is_loaded(bufnr)

                        if is_loaded and name:match("dap%-repl%-") then
                            return bufnr
                        end
                    end
                end

                return nil
            end

            local repl_buffer = nil
            local repl_window = nil

            local function toggle_floating_repl()
                if not repl_buffer then
                    dap.repl.open()
                    repl_buffer = find_dap_repl_buffer()
                    dap.repl.toggle()
                end

                if repl_window and vim.api.nvim_win_is_valid(repl_window) then
                    vim.api.nvim_win_close(repl_window, true)
                    repl_window = nil
                    return
                end

                local width = vim.api.nvim_get_option("columns")
                local height = vim.api.nvim_get_option("lines")

                local win_height = math.ceil(height * 0.9)
                local win_width = math.ceil(width * 0.9)

                local row = math.floor((height - win_height) / 2)
                local col = math.floor((width - win_width) / 2)

                local opts = {
                    relative = "editor",
                    width = win_width,
                    height = win_height,
                    row = row,
                    col = col,
                    style = "minimal",
                    border = "rounded",
                }

                repl_window = vim.api.nvim_open_win(repl_buffer, true, opts)

                vim.api.nvim_win_set_option(repl_window, "cursorline", true)
                vim.api.nvim_win_set_option(repl_window, "winhl", "Normal:NormalFloat")

                local close_keys = { "<Esc>", "q" }
                for _, key in ipairs(close_keys) do
                    vim.api.nvim_buf_set_keymap(
                        repl_buffer,
                        "n",
                        key,
                        "<cmd>ToggleRepl<cr>",
                        { noremap = true, silent = true }
                    )
                end
            end
            vim.api.nvim_create_user_command("ToggleRepl", toggle_floating_repl, {})

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
            set("n", "<leader>dU", dapui.toggle)
            set("n", "<leader>du", dap.up)
            set("n", "<leader>dd", dap.down)
            set("n", "<leader>dp", dap.step_back)
            set("n", "<leader>dc", dap.run_to_cursor)
            set("n", "<leader>dr", toggle_floating_repl)
        end,
    },
}
