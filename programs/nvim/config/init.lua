require("config.prepare_lazy")
local plugins = require("user.plugins")
require("lazy").setup(plugins)
require("user.settings")
require("user.custom-commands")
require("user.autocmds")
