local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
  return
end

dashboard.setup {
  theme = 'hyper',
  config = {
    project = { enable = false, },
    header = {},
    footer = {},
    week_header = {
      enable = false,
    },
    shortcut = {
      -- { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
      -- {
      --   desc = ' Files',
      --   group = 'Label',
      --   action = 'Telescope find_files',
      --   key = 'f',
      -- },
      -- {
      --   desc = ' Apps',
      --   group = 'DiagnosticHint',
      --   action = 'Telescope app',
      --   key = 'a',
      -- },
      {
        desc = ' Find File',
        group = 'Number',
        action = 'require("telescope.builtin").find_files()',
        key = 'a',
      },
    },
  },
}
