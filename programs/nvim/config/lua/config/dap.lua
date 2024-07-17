local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local ext_path = "C:/Users/work/.vscode/extensions/lldb-172/"
local codelldb_path = ext_path .. "adapter/codelldb"
-- local liblldb_path = ext_path .. "lldb/lib/liblldb.dll"

local port = "3434"

dap.adapters.codelldb = {
    type = "executable",
    command = "/home/blanktiger/.local/share/nvim/mason/bin/codelldb", -- adjust as needed
    name = "lldb",
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

-- dap.configurations.rust = dap.configurations.cpp
dap.configurations.rust = {
    {
        name = "hello-world",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/hello-world"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
    {
        name = "hello-dap",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/hello-dap"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
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
