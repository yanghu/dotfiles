-- ~/.hammerspoon/omnibar.lua
local launcher = require("launcher")
local clipboard = require("clipboard")
local calc = require("calculator")

local currentMode = "apps"
local appChoices = launcher.getAppChoices()

-- Helper function for Raycast-style fuzzy matching
local function fuzzyMatch(str, query)
	if not str then
		return false
	end
	str = tostring(str):lower()
	query = tostring(query):lower()

	for word in query:gmatch("%S+") do
		if not str:find(word, 1, true) then
			return false
		end
	end
	return true
end

-- Create the unified Chooser
local omnibar = hs.chooser.new(function(choice)
	if not choice then
		currentMode = "apps"
		return
	end

	if choice.isCalculator then
		clipboard.paste({ rawText = choice.text, isImage = false })
	elseif currentMode == "apps" then
		launcher.launchApp(choice)
	elseif currentMode == "clipboard" then
		clipboard.paste(choice)
	end

	currentMode = "apps"
end)

omnibar:bgDark(true)

-- The Smart Callback
omnibar:queryChangedCallback(function(query)
	-- The Magic Switch
	if query == "c " and currentMode == "apps" then
		currentMode = "clipboard"
		hs.timer.doAfter(0.05, function()
			omnibar:query("")
			omnibar:placeholderText("Search Clipboard...")
			omnibar:choices(clipboard.history)
		end)
		return
	end

	local data = (currentMode == "apps") and appChoices or clipboard.history

	if not query or query == "" then
		omnibar:choices(data)
		return
	end

	local filtered = {}

	-- Check for math equations using our new module
	if currentMode == "apps" then
		local mathResult = calc.evaluate(query)
		if mathResult then
			table.insert(filtered, {
				text = mathResult,
				subText = "Calculator = " .. query .. " (Press Enter to Paste)",
				isCalculator = true,
				image = hs.image.imageFromAppBundle("com.apple.calculator"),
			})
		end
	end

	for _, item in ipairs(data) do
		if fuzzyMatch(item.text, query) or fuzzyMatch(item.subText, query) then
			table.insert(filtered, item)
		end
	end

	omnibar:choices(filtered)
end)

-- Bind Cmd + Space
hs.hotkey.bind({ "cmd" }, "space", function()
	currentMode = "apps"
	omnibar:placeholderText("Search Apps, or type Math... ('c ' for Clipboard)")
	omnibar:choices(appChoices)
	omnibar:query("")
	omnibar:show()
end)
