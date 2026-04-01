-- Function to launch or focus an application by Name OR Bundle ID
local function launchOrFocusApp(appIdentifier)
	-- If the identifier contains a dot, we assume it's a Bundle ID
	if string.find(appIdentifier, "%.") then
		hs.application.launchOrFocusByBundleID(appIdentifier)
	else
		-- Otherwise, use the standard app name
		hs.application.launchOrFocus(appIdentifier)
	end
end

-- Define hotkeys for specific applications
-- Use the *exact name* of the application bundle as seen by macOS
-- App ID obtained with command "osascript -e 'id of app "Google Chat"'"
local appHotkeys = {
	{ "Gmail", { "cmd", "shift" }, "1" }, -- For the Chrome App "Cider-V"
	{ "WezTerm", { "cmd", "shift" }, "2" }, -- For the Chrome App "Google Chat"
	{ "com.google.Chrome.app.mdpkiolbdkhdjpekfbkbmhigcaggjagi", { "cmd", "shift" }, "3" }, -- Google Chat
	-- Add more applications:
	{ "com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep", { "cmd", "shift" }, "4" }, -- Example for Chrome App "Calendar"
	{ "com.google.Chrome.app.kjgfgldnnfoeklkmfkjfagphfepbbdan", { "cmd", "shift" }, "5" }, -- Example for Chrome App "Calendar"
}

-- Bind each hotkey
for _, appInfo in ipairs(appHotkeys) do
	local appName = appInfo[1]
	local modifiers = appInfo[2]
	local key = appInfo[3]

	hs.hotkey.bind(modifiers, key, function()
		launchOrFocusApp(appName)
	end)
end


