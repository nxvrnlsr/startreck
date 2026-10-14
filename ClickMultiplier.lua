-- ClickMultiplier.lua
-- Loaded at runtime via loadstring(game:HttpGet(...))()
-- Sets click multiplier to 35x for the clicking game

local MULTIPLIER = 35
local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local clicksValue = leaderstats:WaitForChild("Clicks")

-- Hook the click event if a click part exists
local function onCharacterAdded(character)
    local clickPart = character:FindFirstChild("ClickPart") or character:FindFirstChildWhichIsA("Part")
    if not clickPart then return end

    local function onClick()
        clicksValue.Value = clicksValue.Value + MULTIPLIER
    end

    -- Connect to the click event (adjust event name as needed)
    if clickPart:FindFirstChild("ClickDetector") then
        clickPart.ClickDetector.Click:Connect(onClick)
    elseif clickPart:FindFirstChild("ProximityPrompt") then
        clickPart.PromptTriggered:Connect(function()
            onClick()
        end)
    end
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end

print("[ClickMultiplier] Loaded with multiplier:", MULTIPLIER)