-- ~/.hammerspoon/calc.lua
local calc = {}

-- Safe Math Evaluator
function calc.evaluate(query)
    -- Must contain at least one digit
    if not query or not query:match("%d") then return nil end
    
    -- Clean up trailing equals signs and spaces
    local cleanQuery = query:gsub("=$", ""):gsub("%s+$", "")
    
    -- Sandbox environment for safety
    local env = {
        pi = math.pi, abs = math.abs, sqrt = math.sqrt,
        sin = math.sin, cos = math.cos, tan = math.tan,
        log = math.log, exp = math.exp
    }
    
    local f, err = load("return " .. cleanQuery, "calc", "t", env)
    if not f then return nil end 
    
    local success, result = pcall(f)
    if success and type(result) == "number" then
        if result % 1 == 0 then
            return string.format("%d", result)
        else
            return string.format("%f", result):gsub("0+$", ""):gsub("%.$", "")
        end
    end
    return nil
end

return calc
