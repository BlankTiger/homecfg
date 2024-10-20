local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        path_display = { "smart" },
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.95,
            height = 0.9,
            prompt_position = "top",
        },

        mappings = {
            i = {
                ["<Up>"] = actions.cycle_history_next,
                ["<Down>"] = actions.cycle_history_prev,

                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,

                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        find_files = {
            path_display = { "absolute" },
            -- theme = "dropdown",
        },
        git_files = {
            path_display = { "absolute" },
            -- theme = "dropdown",
        },
        live_grep = {
            path_display = { "absolute" },
            -- theme = "dropdown",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        notify = {},
        git_diffs = {
            git_command = { "git", "log", "--oneline", "--decorate", "--all", "." }, -- list result
        },
        ripgrep = {
            path_display = { "absolute" },
            default_args_text = "--vimgrep --glob-case-insensitive -i",
            default_args_files = "--files --glob-case-insensitive -i -g",
        },
        aqf = { path_display = { "absolute" } },
    },
})
