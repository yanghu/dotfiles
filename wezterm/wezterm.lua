-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- These are vars to put things in later (i dont use em all yet)
local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

-- This is for newer wezterm vertions to use the config builder
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Default config settings
-- These are the default config settins needed to use Wezterm
-- Just add this and return config and that's all the basics you need

-- Color scheme, Wezterm has 100s of them you can see here:
-- https://wezfurlong.org/wezterm/colorschemes/index.html
-- config.color_scheme = "Oceanic Next (Gogh)"
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Google Dark (Gogh)"
-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("Fira Code")
config.font_size = 16
config.launch_menu = launch_menu
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- makes my cursor blink
-- config.default_cursor_style = "BlinkingBar"
--
--
--
config.disable_default_key_bindings = true
-- this adds the ability to use ctrl+v to paste the system clipboard
-- config.keys = { { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") } }
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = require("keymap").leader
config.keys = require("keymap").keymaps
config.mouse_bindings = mouse_bindings
-- There are mouse binding to mimc Windows Terminal and let you copy
-- To copy just highlight something and right click. Simple
mouse_bindings = {
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "NONE",
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}
--
-- -- This is used to make my foreground (text, etc) brighter than my background
-- config.foreground_text_hsb = {
-- 	hue = 1.0,
-- 	saturation = 1.2,
-- 	brightness = 1.5,
-- }
-- --
-- -- -- This is used to set an image as my background
-- -- config.background = {
-- -- 	{
-- -- 		source = { File = { path = "C:/Users/hueyh/Downloads/wp4615523-terminal-wallpapers.png", speed = 0.2 } },
-- -- 		opacity = 0.4,
-- -- 		hue = 1.0,
-- -- 		saturation = 1.0,
-- -- 		width = "100%",
-- -- 		hsb = { brightness = 0.2 },
-- -- 	},
-- -- }

-- config.window_background_opacity = 0.5
-- config.win32_system_backdrop = "Acrylic"
config.hide_tab_bar_if_only_one_tab = true

config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Ubuntu",

		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.

		distribution = "Ubuntu",

		-- The username to use when spawning commands in the distribution.
		-- If omitted, the default user for that distribution will be used.
		username = "huyang",

		-- The current working directory to use when spawning commands, if
		-- the SpawnCommand doesn't otherwise specify the directory.
		default_cwd = "~",

		-- The default command to run, if the SpawnCommand doesn't otherwise
		-- override it.  Note that you may prefer to use `chsh` to set the
		-- default shell for your user inside WSL to avoid needing to
		-- specify it here

		-- default_prog = {"fish"}
	},
}
-- IMPORTANT: Sets WSL2 UBUNTU as the defualt when opening Wezterm
-- config.default_domain = "WSL:Ubuntu-22.04"
-- config.default_domain = "WSL:Ubuntu"

config.default_cwd = "~"
return config
