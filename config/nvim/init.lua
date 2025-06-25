vim.deprecated = function() end
require("config.setup_lazy")
require("user.settings")
require("user.custom-commands")
require("user.autocmds")
require("user.keymaps")
require("user.custom-qf")
vim.o.quickfixtextfunc = "v:lua.MyQuickfixtextfunc"
