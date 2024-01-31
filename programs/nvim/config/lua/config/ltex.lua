require("lspconfig").ltex.setup {
    on_attach = function(client, bufnr)
        -- your other on_attach functions.
        require("ltex_extra").setup {
            load_langs = { "pl-PL" }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true,        -- boolean : whether to load dictionaries on startup
            path = nil,               -- string : path to store dictionaries. Relative path uses current working directory
            log_level = "warn",       -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        }
    end,
    settings = {
        ltex = {
          checkFrequency = "save",
            -- your settings.
        }
    }
}
