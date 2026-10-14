-- ClickLoader.lua
-- Dashboard for setting click multiplier. Execute in an exploit tool.

local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local clicksValue = leaderstats:WaitForChild("Clicks")

local MULTIPLIER = 1  -- default, changed via dashboard

-- ---------- Dashboard GUI ----------
local gui = Instance.new("ScreenGui")
gui.Name = "ClickMultiplierDashboard"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Click Multiplier Dashboard"
title.Parent = frame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.85, 0, 0, 40)
inputBox.Position = UDim2.new(0.075, 0, 0, 45)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.BackgroundTransparency = 0.5
inputBox.PlaceholderText = "Enter multiplier (e.g. 35)"
inputBox.Text = ""
inputBox.Parent = frame

local setBtn = Instance.new("TextButton")
setBtn.Size = UDim2.new(0.85, 0, 0, 40)
setBtn.Position = UDim2.new(0.075, 0, 0, 95)
setBtn.Font = Enum.Font.GothamBold
setBtn.TextSize = 16
setBtn.TextColor3 = Color3.new(1, 1, 1)
setBtn.backgroundColor3 = Color3.fromRGB(40, 100, 200)
setBtn.Text = "Set Multiplier"
setBtn.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 30)
statusLabel.Position = UDim2.new(0.5, 0, 0, 145)
statusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
statusLabel.Text = "Multiplier: 1"
statusLabel.Parent = frame

local function applyMultiplier()
    local val = tonumber(inputBox.Text)
    if val and val > 0 then
        MULTIPLIER = math.floor(val)
        statusLabel.Text = "Multiplier: " .. MULTIPLIER
        statusLabel.TextColor3 = Color3.new(0.5, 1, 0.5)
    else
        statusLabel.Text = "Invalid number!"
        statusLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
    end
end

setBtn.MouseButton1Click:Connect(applyMultiplier)

-- ---------- Click hook ----------
local function onCharacterAdded(character)
    local clickPart = character:FindFirstChild("ClickPart") or character:FindFirstChildWhichIsA("Part")
    if not clickPart then return end

    local function onClick()
        clicksValue.Value = clicksValue.Value + MULTIPLIER
    end

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

print("[ClickLoader] Dashboard loaded. Current multiplier:", MULTIPLIER)