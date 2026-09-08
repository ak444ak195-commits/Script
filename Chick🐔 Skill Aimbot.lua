--[[
    ================================================================
    [ SCRIPT INFORMATION ]
    Project: Custom Script
    Author: OYB
    YouTube: https://www.youtube.com/channel/UCAlXXV1Hbvf7WbfXARuVtiQ
    
    [ TERMS AND CONDITIONS ]
    - You ARE allowed to use and modify this script for your own games.
    - You ARE NOT allowed to re-upload, redistribute, or claim 
      ownership of this script.
    - Removing or altering these credits is strictly prohibited.
    
    Copyright (c) 2026 OYB. All rights reserved.
    ================================================================
]]

-- ⚠️ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) ⚠️

local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "196",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "Chick🐔 Skill Aimbot"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- 👇 YOUR MAIN SCRIPT CODE STARTS HERE 👇
-------------------------------------------------------------------------------

print(ProtectionConfig.HubName .. " Loaded Successfully!")




-- [[ 🎯 V10.3 HYBRID STRICT LOCK - RED DOT ALWAYS ON + NO FOV CIRCLE 🎯 ]]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- [[ 0. CONFIG FILE & SAVE/LOAD SYSTEM ]]
local FILE_NAME = "HybridAim_Config_V10_3.json"

local SETTINGS = {
    CENTER_X = 0,
    CENTER_Y = -70,
    PREDICTION_TIME = 0.3,
    FOV_RADIUS = 120, -- ยังเก็บค่านี้ไว้ใช้เป็นระยะกวาดหาเป้าหมาย (แต่ไม่แสดงวงกลมแล้ว)
    LOCK_ENABLED = false,
    LOCK_STYLE = "Sticky",
    TARGET_MODE = "Monster",
    AIM_PART = "Torso",
    HIGHLIGHT_COLOR = {255, 255, 0}
}

local function SaveConfig()
    pcall(function()
        if writefile then writefile(FILE_NAME, HttpService:JSONEncode(SETTINGS)) end
    end)
end

local function LoadConfig()
    pcall(function()
        if readfile and isfile and isfile(FILE_NAME) then
            local decoded = HttpService:JSONDecode(readfile(FILE_NAME))
            for k, v in pairs(decoded) do SETTINGS[k] = v end
        end
    end)
end
LoadConfig()

-- [[ 1. GUI INITIALIZATION & CLEANUP ]]
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "HybridAimGui" then gui:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HybridAimGui"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- 📱 ฟังก์ชันลากหน้าจอสำหรับมือถือ (Touch Support)
local function MakeDraggable(frame, header)
    local dragging, dragInput, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- ==========================================
-- 🟢 MAIN HUB
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 150, 0, 143)
MainFrame.Position = UDim2.new(0.8, -160, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(80, 80, 80)

local MainHeader = Instance.new("TextLabel", MainFrame)
MainHeader.Size = UDim2.new(1, 0, 0, 25)
MainHeader.Text = " MAIN HUB"
MainHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
MainHeader.Font = Enum.Font.SourceSansBold; MainHeader.TextSize = 14
MainHeader.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainHeader.BackgroundTransparency = 0.2
Instance.new("UICorner", MainHeader).CornerRadius = UDim.new(0, 8)
MakeDraggable(MainFrame, MainHeader)

local function CreateButton(parent, text, yPos, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = text; btn.BackgroundColor3 = color; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local ToggleBtn = CreateButton(MainFrame, SETTINGS.LOCK_ENABLED and "AIM: ON" or "AIM: OFF", 30, SETTINGS.LOCK_ENABLED and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(60, 60, 60))
local LockStyleBtn = CreateButton(MainFrame, "LOCK: " .. SETTINGS.LOCK_STYLE:upper(), 58, SETTINGS.LOCK_STYLE == "Sticky" and Color3.fromRGB(150, 80, 0) or Color3.fromRGB(150, 0, 150))
local ModeBtn = CreateButton(MainFrame, "MODE: " .. SETTINGS.TARGET_MODE:upper(), 86, SETTINGS.TARGET_MODE == "Monster" and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(200, 50, 50))
local SettingsToggleBtn = CreateButton(MainFrame, "⚙️ SETTINGS", 114, Color3.fromRGB(40, 40, 40))

-- ==========================================
-- ⚙️ SETTINGS HUB
-- ==========================================
local SetFrame = Instance.new("Frame", ScreenGui)
SetFrame.Size = UDim2.new(0, 160, 0, 185)
SetFrame.Position = UDim2.new(0.8, -330, 0.2, 0)
SetFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SetFrame.BackgroundTransparency = 0.2
SetFrame.Visible = false; SetFrame.ZIndex = 2
Instance.new("UICorner", SetFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", SetFrame).Color = Color3.fromRGB(100, 100, 100)

local SetHeader = Instance.new("TextLabel", SetFrame)
SetHeader.Size = UDim2.new(1, 0, 0, 25)
SetHeader.Text = " SETTINGS"
SetHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
SetHeader.Font = Enum.Font.SourceSansBold; SetHeader.TextSize = 14
SetHeader.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SetHeader.BackgroundTransparency = 0.2; SetHeader.ZIndex = 2
Instance.new("UICorner", SetHeader).CornerRadius = UDim.new(0, 8)
MakeDraggable(SetFrame, SetHeader)

local function CreateAdjuster(parent, labelPrefix, currentValue, yPos)
    local minus = Instance.new("TextButton", parent)
    minus.Size = UDim2.new(0.2, 0, 0, 22); minus.Position = UDim2.new(0.05, 0, 0, yPos)
    minus.Text = "-"; minus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    minus.TextColor3 = Color3.fromRGB(255, 255, 255); minus.Font = Enum.Font.SourceSansBold; minus.ZIndex = 2
    Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 4)

    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(0.45, 0, 0, 22); label.Position = UDim2.new(0.275, 0, 0, yPos)
    label.Text = labelPrefix .. currentValue; label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    label.TextColor3 = Color3.fromRGB(220, 220, 220); label.Font = Enum.Font.SourceSansBold; label.TextSize = 13; label.ZIndex = 2
    Instance.new("UICorner", label).CornerRadius = UDim.new(0, 4)

    local plus = Instance.new("TextButton", parent)
    plus.Size = UDim2.new(0.2, 0, 0, 22); plus.Position = UDim2.new(0.75, 0, 0, yPos)
    plus.Text = "+"; plus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    plus.TextColor3 = Color3.fromRGB(255, 255, 255); plus.Font = Enum.Font.SourceSansBold; plus.ZIndex = 2
    Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 4)
    return minus, plus, label
end

local XMinus, XPlus, XLabel = CreateAdjuster(SetFrame, "X: ", SETTINGS.CENTER_X, 32)
local YMinus, YPlus, YLabel = CreateAdjuster(SetFrame, "Y: ", SETTINGS.CENTER_Y, 58)

local PredLabel = Instance.new("TextLabel", SetFrame)
PredLabel.Size = UDim2.new(0.45, 0, 0, 22); PredLabel.Position = UDim2.new(0.05, 0, 0, 84)
PredLabel.Text = " PREDICT:"
PredLabel.BackgroundTransparency = 1; PredLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
PredLabel.Font = Enum.Font.SourceSansBold; PredLabel.TextSize = 13; PredLabel.TextXAlignment = Enum.TextXAlignment.Left; PredLabel.ZIndex = 2

local PredBox = Instance.new("TextBox", SetFrame)
PredBox.Size = UDim2.new(0.4, 0, 0, 22); PredBox.Position = UDim2.new(0.55, 0, 0, 84)
PredBox.Text = tostring(SETTINGS.PREDICTION_TIME); PredBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PredBox.TextColor3 = Color3.fromRGB(255, 255, 100); PredBox.Font = Enum.Font.SourceSansBold; PredBox.TextSize = 13; PredBox.ClearTextOnFocus = false; PredBox.ZIndex = 2
Instance.new("UICorner", PredBox).CornerRadius = UDim.new(0, 4)

local AimColors = {Head = Color3.fromRGB(180, 50, 50), Torso = Color3.fromRGB(0, 120, 200), Feet = Color3.fromRGB(150, 100, 50)}
local AimPartBtn = CreateButton(SetFrame, "AIM: " .. SETTINGS.AIM_PART:upper(), 112, AimColors[SETTINGS.AIM_PART] or Color3.fromRGB(0, 120, 200))
AimPartBtn.ZIndex = 2
local SaveBtn = CreateButton(SetFrame, "💾 SAVE CONFIG", 148, Color3.fromRGB(40, 80, 40))
SaveBtn.ZIndex = 2

-- [[ 2. VISUALS (เหลือแค่จุดแดง) ]]
local RedDot = Instance.new("Frame", ScreenGui)
RedDot.Size = UDim2.new(0, 6, 0, 6); RedDot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RedDot.AnchorPoint = Vector2.new(0.5, 0.5)
RedDot.Visible = true -- บังคับให้แสดงตลอดเวลา
Instance.new("UICorner", RedDot).CornerRadius = UDim.new(1, 0)

local TargetHighlight = Instance.new("Highlight")
TargetHighlight.FillTransparency = 1; TargetHighlight.OutlineColor = Color3.fromRGB(SETTINGS.HIGHLIGHT_COLOR[1], SETTINGS.HIGHLIGHT_COLOR[2], SETTINGS.HIGHLIGHT_COLOR[3]); TargetHighlight.Enabled = false

-- [[ 3. TARGETING & DUAL PART SYSTEM ]]
local GlobalTarget = nil 
local FacePrediction = nil   
local SkillPrediction = nil  
local LastClosestUpdate = 0 

local function GetCenterPart(Char)
    return Char:FindFirstChild("UpperTorso") or Char:FindFirstChild("Torso") or Char:FindFirstChild("HumanoidRootPart")
end

local function GetSkillAimPart(Char)
    if SETTINGS.AIM_PART == "Head" then
        return Char:FindFirstChild("Head") or Char:FindFirstChild("HumanoidRootPart")
    elseif SETTINGS.AIM_PART == "Feet" then
        return Char:FindFirstChild("LeftFoot") or Char:FindFirstChild("RightFoot") or Char:FindFirstChild("LowerTorso") or Char:FindFirstChild("HumanoidRootPart")
    else
        return GetCenterPart(Char)
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)
        Camera = workspace.CurrentCamera
        if not SETTINGS.LOCK_ENABLED then
            GlobalTarget = nil
        else
            if SETTINGS.LOCK_STYLE == "Sticky" then
                -- 📌 STICKY LOCK (ทำงานตามเดิม อิงระยะจากจุดแดง)
                local KeepCurrent = false
                if GlobalTarget and GlobalTarget:FindFirstChild("Humanoid") then
                    if GlobalTarget.Humanoid.Health > 0 and GlobalTarget.Parent ~= nil then 
                        KeepCurrent = true 
                    end
                end

                if not KeepCurrent then
                    local NewTarget, MinDist = nil, SETTINGS.FOV_RADIUS 
                    local CrosshairPos = Vector2.new((Camera.ViewportSize.X / 2) + SETTINGS.CENTER_X, (Camera.ViewportSize.Y / 2) + SETTINGS.CENTER_Y)

                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Humanoid") and obj.Health > 0 and obj.Parent then
                            local TChar = obj.Parent
                            if TChar ~= LocalPlayer.Character and TChar:FindFirstChild("HumanoidRootPart") then
                                local IsPlayer = Players:GetPlayerFromCharacter(TChar)
                                if (SETTINGS.TARGET_MODE == "Monster" and not IsPlayer) or (SETTINGS.TARGET_MODE == "Player" and IsPlayer) then
                                    local CenterPart = GetCenterPart(TChar)
                                    if CenterPart then
                                        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(CenterPart.Position)
                                        if OnScreen then
                                            local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - CrosshairPos).Magnitude
                                            if Dist < MinDist then MinDist = Dist; NewTarget = TChar end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    GlobalTarget = NewTarget
                end

            elseif SETTINGS.LOCK_STYLE == "Closest" then
                -- 📌 CLOSEST LOCK (เช็ครอบตัว)
                local MyChar = LocalPlayer.Character
                local MyRoot = MyChar and MyChar:FindFirstChild("HumanoidRootPart")
                
                if MyRoot then
                    if tick() - LastClosestUpdate >= 1 then
                        LastClosestUpdate = tick()
                        local NewTarget, MinDist = nil, math.huge
                        
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("Humanoid") and obj.Health > 0 and obj.Parent then
                                local TChar = obj.Parent
                                if TChar ~= MyChar and TChar:FindFirstChild("HumanoidRootPart") then
                                    local IsPlayer = Players:GetPlayerFromCharacter(TChar)
                                    if (SETTINGS.TARGET_MODE == "Monster" and not IsPlayer) or (SETTINGS.TARGET_MODE == "Player" and IsPlayer) then
                                        local TargetRoot = TChar.HumanoidRootPart
                                        local Dist = (TargetRoot.Position - MyRoot.Position).Magnitude
                                        if Dist < MinDist then
                                            MinDist = Dist
                                            NewTarget = TChar
                                        end
                                    end
                                end
                            end
                        end
                        GlobalTarget = NewTarget
                    end
                end
                
                if GlobalTarget and GlobalTarget:FindFirstChild("Humanoid") then
                    if GlobalTarget.Humanoid.Health <= 0 or not GlobalTarget.Parent then
                        GlobalTarget = nil
                    end
                end
            end
        end
    end
end)

-- [[ 4. RENDER LOOP & FACE LOCK ]]
RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera
    
    -- 📌 อัปเดตตำแหน่งจุดแดงตลอดเวลา และให้แสดงไว้ตลอด
    local CrossX = (Camera.ViewportSize.X / 2) + SETTINGS.CENTER_X
    local CrossY = (Camera.ViewportSize.Y / 2) + SETTINGS.CENTER_Y
    RedDot.Position = UDim2.new(0, CrossX, 0, CrossY)

    local Char = LocalPlayer.Character
    local MyHumanoid = Char and Char:FindFirstChild("Humanoid")
    local MyRoot = Char and Char:FindFirstChild("HumanoidRootPart")

    if SETTINGS.LOCK_ENABLED and GlobalTarget and GlobalTarget:FindFirstChild("HumanoidRootPart") then
        local TargetRoot = GlobalTarget.HumanoidRootPart
        local CenterPart = GetCenterPart(GlobalTarget)
        local SkillPart = GetSkillAimPart(GlobalTarget)
        
        local Velocity = TargetRoot.AssemblyLinearVelocity or TargetRoot.Velocity or Vector3.zero
        local VelocityOffset = Vector3.new(Velocity.X, 0, Velocity.Z) * SETTINGS.PREDICTION_TIME

        FacePrediction = CenterPart.Position + VelocityOffset
        SkillPrediction = SkillPart.Position + VelocityOffset

        if MyHumanoid then MyHumanoid.AutoRotate = false end 
        if MyRoot then
            local lookAtPos = Vector3.new(FacePrediction.X, MyRoot.Position.Y, FacePrediction.Z)
            MyRoot.CFrame = CFrame.lookAt(MyRoot.Position, lookAtPos)
        end

        local _, OnScreen = Camera:WorldToViewportPoint(CenterPart.Position)
        if OnScreen then
            if TargetHighlight.Parent ~= GlobalTarget then TargetHighlight.Parent = GlobalTarget end
            TargetHighlight.Enabled = true
        else
            TargetHighlight.Enabled = false 
        end
    else
        if MyHumanoid and not MyHumanoid.AutoRotate then MyHumanoid.AutoRotate = true end
        FacePrediction = nil; SkillPrediction = nil; TargetHighlight.Enabled = false
    end
end)

-- [[ 5. STRICT METATABLE HOOK ]]
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__index = newcclosure(function(self, index)
    if not checkcaller() and SETTINGS.LOCK_ENABLED and SkillPrediction then
        if self == Mouse and (index == "Hit" or index == "TargetPoint") then
            return (index == "Hit" and CFrame.new(SkillPrediction) or SkillPrediction)
        end
    end
    return oldIndex(self, index)
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and SETTINGS.LOCK_ENABLED and SkillPrediction then
        if self == UserInputService and (method == "GetMouseLocation" or method == "GetMousePosition") then
            local ScreenPos, _ = Camera:WorldToViewportPoint(SkillPrediction)
            return Vector2.new(ScreenPos.X, ScreenPos.Y)
        end
        if method == "Raycast" and self == workspace then
            local args = {...}
            if typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
                local originalMagnitude = args[2].Magnitude 
                args[2] = (SkillPrediction - args[1]).Unit * originalMagnitude 
                return oldNamecall(self, unpack(args))
            end
        end
        if (method == "ViewportPointToRay" or method == "ScreenPointToRay") and self == workspace.CurrentCamera then
            local origin = self.CFrame.Position
            return Ray.new(origin, (SkillPrediction - origin).Unit)
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- [[ 6. BUTTON EVENTS ]]
local function ResetAutoRotate()
    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("Humanoid") then Char.Humanoid.AutoRotate = true end
end

ToggleBtn.MouseButton1Click:Connect(function()
    SETTINGS.LOCK_ENABLED = not SETTINGS.LOCK_ENABLED
    GlobalTarget = nil
    ToggleBtn.Text = SETTINGS.LOCK_ENABLED and "AIM: ON" or "AIM: OFF"
    ToggleBtn.BackgroundColor3 = SETTINGS.LOCK_ENABLED and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(60, 60, 60)
    if not SETTINGS.LOCK_ENABLED then TargetHighlight.Enabled = false; ResetAutoRotate() end
    SaveConfig()
end)

LockStyleBtn.MouseButton1Click:Connect(function()
    GlobalTarget = nil
    SETTINGS.LOCK_STYLE = SETTINGS.LOCK_STYLE == "Sticky" and "Closest" or "Sticky"
    LockStyleBtn.Text = "LOCK: " .. SETTINGS.LOCK_STYLE:upper()
    LockStyleBtn.BackgroundColor3 = SETTINGS.LOCK_STYLE == "Sticky" and Color3.fromRGB(150, 80, 0) or Color3.fromRGB(150, 0, 150)
    TargetHighlight.Enabled = false; SaveConfig()
end)

ModeBtn.MouseButton1Click:Connect(function()
    GlobalTarget = nil 
    SETTINGS.TARGET_MODE = SETTINGS.TARGET_MODE == "Monster" and "Player" or "Monster"
    ModeBtn.Text = "MODE: " .. SETTINGS.TARGET_MODE:upper()
    ModeBtn.BackgroundColor3 = SETTINGS.TARGET_MODE == "Monster" and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(200, 50, 50)
    TargetHighlight.Enabled = false; ResetAutoRotate(); SaveConfig()
end)

SettingsToggleBtn.MouseButton1Click:Connect(function()
    SetFrame.Visible = not SetFrame.Visible
    SettingsToggleBtn.BackgroundColor3 = SetFrame.Visible and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(40, 40, 40)
end)

AimPartBtn.MouseButton1Click:Connect(function()
    if SETTINGS.AIM_PART == "Torso" then SETTINGS.AIM_PART = "Head"
    elseif SETTINGS.AIM_PART == "Head" then SETTINGS.AIM_PART = "Feet"
    else SETTINGS.AIM_PART = "Torso" end
    AimPartBtn.Text = "AIM: " .. SETTINGS.AIM_PART:upper(); AimPartBtn.BackgroundColor3 = AimColors[SETTINGS.AIM_PART]
    SaveConfig()
end)

XMinus.MouseButton1Click:Connect(function() SETTINGS.CENTER_X = SETTINGS.CENTER_X - 1; XLabel.Text = "X: " .. SETTINGS.CENTER_X; end)
XPlus.MouseButton1Click:Connect(function() SETTINGS.CENTER_X = SETTINGS.CENTER_X + 1; XLabel.Text = "X: " .. SETTINGS.CENTER_X; end)
YMinus.MouseButton1Click:Connect(function() SETTINGS.CENTER_Y = SETTINGS.CENTER_Y - 1; YLabel.Text = "Y: " .. SETTINGS.CENTER_Y; end)
YPlus.MouseButton1Click:Connect(function() SETTINGS.CENTER_Y = SETTINGS.CENTER_Y + 1; YLabel.Text = "Y: " .. SETTINGS.CENTER_Y; end)

PredBox.FocusLost:Connect(function()
    local num = tonumber(PredBox.Text)
    if num then SETTINGS.PREDICTION_TIME = num else PredBox.Text = tostring(SETTINGS.PREDICTION_TIME) end
end)

SaveBtn.MouseButton1Click:Connect(function()
    SaveConfig(); SaveBtn.Text = "✅ SAVED!"; SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    task.wait(1); SaveBtn.Text = "💾 SAVE CONFIG"; SaveBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
end)



