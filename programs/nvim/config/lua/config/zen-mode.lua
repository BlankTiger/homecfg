local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
	return
end

local status_ok_twilight, twilight = pcall(require, "twilight")
if not status_ok_twilight then
	return
end

-- twilight.setup()
zen_mode.setup({
	window = {
		-- backdrop = 0.95,
		width = 130,
	},
	plugins = {
		twilight = { enabled = false },
		gitsigns = { enabled = false },
		tmux = { enabled = false },
		-- alacritty = {
		--     enabled = true,
		--     font = "20",
		-- },
	},
})
