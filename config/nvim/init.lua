vim.deprecated = function() end
vim.g.theme = vim.env.NVIM_THEME or "ayu"
require("config.setup_lazy")
require("user.settings")
require("user.custom-commands")
require("user.autocmds")
require("user.keymaps")
require("user.custom-qf")
require("user.theme")
require("user.todo-highlight").setup()
