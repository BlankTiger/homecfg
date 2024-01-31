local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local dap_install_status_ok, dap_install = pcall(require, "dap-install")
if not dap_install_status_ok then
  return
end

local ext_path = 'C:/Users/work/.vscode/extensions/lldb-172/'
local codelldb_path = ext_path .. "adapter/codelldb"
-- local liblldb_path = ext_path .. "lldb/lib/liblldb.dll"

local port = '3434'

dap.adapters.codelldb = {
  type = 'server',
  port = port,
  -- port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = codelldb_path,
    -- args = {"--port", "${port}"},
    args = {"--port", port},

    -- On windows you may have to uncomment this:
    detached = false,
  }
}

-- dap.configurations.python = {
-- 	{
-- 		type = 'python';
-- 		request = 'launch';
-- 		name = 'Launch file';
-- 		program = '${file}';
-- 		pythonPath = function()
-- 			return 'C:/Users/work/AppData/Local/Programs/Python/Python310/python.exe'
-- 		end;
-- 	}
-- }

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}

dap.configurations.rust = dap.configurations.cpp
dap.configurations.c = dap.configurations.cpp


dap_install.setup()
--
-- dap_install.config("python", {})
-- dap_install.config("rust", {})
-- -- add other configs here
--
--
-- dapui.setup {
--   layouts = {
-- 	{
-- 	elements = {
-- 		'scopes',
-- 		'breakpoints',
-- 		'stacks',
-- 		'watches',
-- 	},
-- 	size = 40,
-- 	position = 'left', -- Can be "left", "right", "top", "bottom"
-- 	},
-- 	{
-- 	elements = {
-- 		'repl',
-- 		'console',
-- 	},
-- 	size = 10,
-- 	position = 'bottom',
-- 	},
--   },
-- }

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
