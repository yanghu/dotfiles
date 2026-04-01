-- ~/.hammerspoon/launcher.lua
local launcher = {}

function launcher.getAppChoices()
    local choices = {}
    local appDirs = {
        "/Applications",
        "/System/Applications",
        "/System/Applications/Utilities",
        "/Applications/Utilities",
        os.getenv("HOME") .. "/Applications"
    }

    for _, dir in ipairs(appDirs) do
        if hs.fs.attributes(dir) then
            for file in hs.fs.dir(dir) do
                if file:sub(-4) == ".app" and file:sub(1, 1) ~= "." then
                    local appName = file:sub(1, -5)
                    local appPath = dir .. "/" .. file
                    table.insert(choices, {
                        text = appName,
                        subText = appPath,
                        path = appPath,
                        image = hs.image.iconForFile(appPath)
                    })
                end
            end
        end
    end
    
    table.sort(choices, function(a, b) return a.text:lower() < b.text:lower() end)
    return choices
end

function launcher.launchApp(choice)
    hs.application.launchOrFocus(choice.path)
end

return launcher
