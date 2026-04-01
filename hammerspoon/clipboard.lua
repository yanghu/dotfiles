-- ~/.hammerspoon/clipboard.lua
local clipboard = {}

clipboard.history = {}
local maxHistorySize = 50
local lastChangeCount = hs.pasteboard.changeCount()
clipboard.isPastingFromHammerspoon = false

local function handleClipboardChange()
	local currentChangeCount = hs.pasteboard.changeCount()
	if currentChangeCount == lastChangeCount then
		return
	end
	lastChangeCount = currentChangeCount

	if clipboard.isPastingFromHammerspoon then
		clipboard.isPastingFromHammerspoon = false
		return
	end

	local text = hs.pasteboard.readString()
	local image = hs.pasteboard.readImage()
	local newItem = nil

	if image then
		local size = image:size()
		newItem = {
			text = "🖼️ Image (" .. math.floor(size.w) .. "x" .. math.floor(size.h) .. ")",
			subText = "Copied Image",
			image = image,
			rawImage = image,
			isImage = true,
		}
	elseif text and text ~= "" then
		for i, item in ipairs(clipboard.history) do
			if item.rawText == text then
				table.remove(clipboard.history, i)
				break
			end
		end

		newItem = {
			text = text,
			subText = string.len(text) > 60 and (string.sub(text, 1, 60) .. "...") or "",
			rawText = text,
			isImage = false,
		}
	end

	if newItem then
		table.insert(clipboard.history, 1, newItem)
		if #clipboard.history > maxHistorySize then
			table.remove(clipboard.history)
		end
	end
end

-- Start watcher immediately and attach it to the module so it survives Garbage Collection!
clipboard.watcher = hs.pasteboard.watcher.new(handleClipboardChange)
clipboard.watcher:start()

function clipboard.paste(choice)
	-- 1. Lock the watcher
	clipboard.isPastingFromHammerspoon = true

	-- 2. Write to macOS clipboard
	if choice.isImage then
		hs.pasteboard.writeObjects(choice.rawImage)
	else
		hs.pasteboard.setContents(choice.rawText)
	end

	-- 3. Trigger the paste
	hs.timer.doAfter(0.1, function()
		hs.eventtap.keyStroke({ "cmd" }, "v")

		-- 4. THE FIX: The Fail-Safe Unlock
		-- Force the flag back to false after pasting so it never gets stuck
		hs.timer.doAfter(0.2, function()
			clipboard.isPastingFromHammerspoon = false
		end)
	end)
end
--
-- function clipboard.paste(choice)
-- 	clipboard.isPastingFromHammerspoon = true
-- 	if choice.isImage then
-- 		hs.pasteboard.writeObjects(choice.rawImage)
-- 	else
-- 		hs.pasteboard.setContents(choice.rawText)
-- 	end
-- 	hs.timer.doAfter(0.1, function()
-- 		hs.eventtap.keyStroke({ "cmd" }, "v")
-- 	end)
-- end

-- Grab whatever is currently on the clipboard on startup so it isn't empty
local initialText = hs.pasteboard.readString()
if initialText and initialText ~= "" then
	table.insert(clipboard.history, {
		text = initialText,
		subText = string.len(initialText) > 60 and (string.sub(initialText, 1, 60) .. "...") or "",
		rawText = initialText,
		isImage = false,
	})
end

return clipboard
