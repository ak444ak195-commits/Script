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
    SecretKey = "195",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "Chick🐔 17 script"
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






-- [[ 🪐 MY CUSTOM SCRIPT HUB (17 SCRIPTS LOADED - MOBILE EDITION) 🪐 ]]

-- ====================================================================
-- [[ 🖼️ BACKGROUND & TOGGLE BUTTON SETTINGS ]]
-- ====================================================================
local BACKGROUND_IMAGE = "rbxthumb://type=Asset&id=10263598954&w=420&h=420" 
local IMAGE_TRANSPARENCY = 0 

local IMG_SHOW = "rbxthumb://type=Asset&id=124752358019328&w=150&h=150" -- ตอนย่อ 
local IMG_MENU = "rbxthumb://type=Asset&id=7840756582&w=150&h=150"      -- ตอนกาง 

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ====================================================================
-- [[ 🛡️ GUI CORE ENGINE ]]
-- ====================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustom_GUI_Template"
ScreenGui.ResetOnSpawn = false

local success, hui = pcall(function() return gethui() end)
if success and hui then ScreenGui.Parent = hui else
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

-- ระบบลาก UI รองรับมือถือ (Touch) และ PC (Mouse)
local function MakeDraggable(frame)
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.BackgroundTransparency = 0.8 
ToggleBtn.Image = IMG_SHOW 
ToggleBtn.ScaleType = Enum.ScaleType.Fit 
MakeDraggable(ToggleBtn)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8) 

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.4, -160)
MainFrame.BackgroundTransparency = 1 
MainFrame.Visible = false 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
MakeDraggable(MainFrame)

local BackgroundImage = Instance.new("ImageLabel", MainFrame)
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = BACKGROUND_IMAGE
BackgroundImage.ImageTransparency = IMAGE_TRANSPARENCY
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = -2 
Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 10)

local Overlay = Instance.new("Frame", MainFrame)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.85 
Overlay.ZIndex = -1 
Instance.new("UICorner", Overlay).CornerRadius = UDim.new(0, 10)

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1, -10, 0, 35)
TitleBar.Position = UDim2.new(0, 12, 0, 0)
TitleBar.Text = "MY CUSTOM SCRIPT HUB 🚀 (17 Scripts)"  
TitleBar.TextColor3 = Color3.fromRGB(0, 165, 255)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 15
TitleBar.TextXAlignment = Enum.TextXAlignment.Left
TitleBar.BackgroundTransparency = 1

local Divider = Instance.new("Frame", MainFrame)
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.Position = UDim2.new(0, 0, 0, 35)
Divider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0

local SidebarContainer = Instance.new("Frame", MainFrame)
SidebarContainer.Size = UDim2.new(0, 110, 1, -43)
SidebarContainer.Position = UDim2.new(0, 8, 0, 40)
SidebarContainer.BackgroundTransparency = 1
local SidebarLayout = Instance.new("UIListLayout", SidebarContainer)
SidebarLayout.Padding = UDim.new(0, 5)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -134, 1, -43)
ContentContainer.Position = UDim2.new(0, 126, 0, 40)
ContentContainer.BackgroundTransparency = 1

local GuiVisible = false 
ToggleBtn.MouseButton1Click:Connect(function()
    GuiVisible = not GuiVisible
    MainFrame.Visible = GuiVisible
    ToggleBtn.Image = GuiVisible and IMG_MENU or IMG_SHOW
end)

-- ====================================================================
-- [[ 🗂️ TAB SYSTEM & UI BUILDER ]]
-- ====================================================================
local TabModules = {}
local function CreateTab(tabName, isDefault)
    local TabBtn = Instance.new("TextButton", SidebarContainer)
    TabBtn.Size = UDim2.new(1, 0, 0, 34)
    TabBtn.Text = tabName
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.TextSize = 13
    TabBtn.BackgroundTransparency = 0.4
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    local TabPage = Instance.new("ScrollingFrame", ContentContainer)
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.Visible = false
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabPage.ScrollBarThickness = 3
    
    local PageLayout = Instance.new("UIListLayout", TabPage)
    PageLayout.Padding = UDim.new(0, 6)
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)
    
    TabModules[tabName] = {Button = TabBtn, Page = TabPage}
    TabBtn.MouseButton1Click:Connect(function()
        for _, mod in pairs(TabModules) do
            mod.Page.Visible = false
            mod.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            mod.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        TabPage.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    if isDefault then
        TabPage.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
    return TabPage
end

local function CreateLauncherButton(parentTab, buttonText, targetGuiName, onClickFunc, isLogicToggle)
    local Btn = Instance.new("TextButton", parentTab)
    Btn.Size = UDim2.new(1, -5, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 14
    Btn.Text = " " .. buttonText
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local isLoaded = false
    local isGuiEnabled = false

    Btn.MouseButton1Click:Connect(function()
        if not isLoaded then
            isLoaded = true
            isGuiEnabled = true
            Btn.BackgroundColor3 = Color3.fromRGB(40, 140, 40)
            Btn.Text = " " .. buttonText .. ((targetGuiName or isLogicToggle) and " (ON)" or " (✅ Active)")
            task.spawn(onClickFunc, isGuiEnabled)
        else
            if targetGuiName or isLogicToggle then
                isGuiEnabled = not isGuiEnabled
                Btn.BackgroundColor3 = isGuiEnabled and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(140, 40, 40)
                Btn.Text = " " .. buttonText .. (isGuiEnabled and " (ON)" or " (OFF)")
                
                -- ซ่อน/แสดง GUI เป้าหมาย
                if targetGuiName then
                    local subGui = CoreGui:FindFirstChild(targetGuiName) or (LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild(targetGuiName))
                    if subGui and subGui:IsA("ScreenGui") then
                        subGui.Enabled = isGuiEnabled
                    end
                end
                
                -- สั่งเปิด/ปิด Logic ภายในสคริปต์ย่อย
                if isLogicToggle then
                    task.spawn(onClickFunc, isGuiEnabled)
                end
            end
        end
    end)
end

-- ====================================================================
-- [[ 📦 SCRIPT WRAPPERS (1-17) ]]
-- ====================================================================

-- 1. Infinite Camera Zoom
local zoomConnection
local function Script_InfiniteZoom(state)
    local INFINITE_ZOOM_VALUE = 100000
    if state then
        local function unlockZoom()
            pcall(function()
                if LocalPlayer.CameraMaxZoomDistance < INFINITE_ZOOM_VALUE then
                    LocalPlayer.CameraMaxZoomDistance = INFINITE_ZOOM_VALUE
                end
            end)
        end
        unlockZoom()
        zoomConnection = LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(unlockZoom)
    else
        if zoomConnection then 
            zoomConnection:Disconnect()
            zoomConnection = nil 
        end
        pcall(function() LocalPlayer.CameraMaxZoomDistance = 400 end) 
    end
end

-- 2. Air Walk V4
local function Script_AirWalk()
    local AirWalk_Enabled = false
    local Platform = nil
    local LockedY = 0 
    
    -- ลบอันเก่าถ้ามี
    if CoreGui:FindFirstChild("ScreenGui_AirWalk") then CoreGui.ScreenGui_AirWalk:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "ScreenGui_AirWalk"

    local AirButton = Instance.new("TextButton", ScreenGui)
    AirButton.Name = "AirWalkToggle"
    AirButton.Size = UDim2.new(0, 100, 0, 35)
    AirButton.Position = UDim2.new(0.85, 0, 0.1, 0) 
    AirButton.Text = "AIR: OFF"
    AirButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AirButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    AirButton.Font = Enum.Font.SourceSansBold
    AirButton.TextSize = 14
    Instance.new("UICorner", AirButton).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", AirButton)
    Stroke.Color = Color3.fromRGB(0, 170, 255)
    Stroke.Thickness = 1.5
    MakeDraggable(AirButton)

    local function CreatePlatform()
        local p = Instance.new("Part")
        p.Size = Vector3.new(6, 6, 6) 
        p.Transparency = 0.5           
        p.Color = Color3.fromRGB(0, 170, 255)
        p.Material = Enum.Material.Neon 
        p.Anchored = true
        p.CanCollide = true
        p.Parent = workspace
        return p
    end

    AirButton.MouseButton1Click:Connect(function()
        AirWalk_Enabled = not AirWalk_Enabled
        AirButton.Text = AirWalk_Enabled and "AIR: ON" or "AIR: OFF"
        AirButton.BackgroundColor3 = AirWalk_Enabled and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(30, 30, 30)
        local Character = LocalPlayer.Character
        if AirWalk_Enabled and Character and Character:FindFirstChild("HumanoidRootPart") then
            LockedY = Character.HumanoidRootPart.Position.Y - 5.5
            Platform = CreatePlatform()
        else
            if Platform then
                Platform:Destroy()
                Platform = nil
            end
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        local Character = LocalPlayer.Character
        if AirWalk_Enabled and Character and Character:FindFirstChild("HumanoidRootPart") and Platform then
            local RootPos = Character.HumanoidRootPart.Position
            Platform.CFrame = CFrame.new(RootPos.X, LockedY, RootPos.Z)
        end
    end)
end

-- 3. Multi-Warp Storage
local function Script_MultiWarp()
    local WarpStorage = {} 
    local TotalPointsCreated = 0 
    
    -- ล้างอันเก่า
    local targetParent = pcall(function() return gethui() end) and gethui() or CoreGui
    if targetParent:FindFirstChild("MultiWarpGUI_V1") then targetParent.MultiWarpGUI_V1:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "MultiWarpGUI_V1"
    gui.ResetOnSpawn = false
    gui.Parent = targetParent

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 300) 
    frame.Position = UDim2.new(0.5, -130, 0.5, -150)
    frame.BackgroundTransparency = 0.1
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Active = true
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    MakeDraggable(frame) -- ใช้ Custom Drag แทน .Draggable

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Text = "MULTI-WARP STORAGE"
    titleLabel.TextColor3 = Color3.fromRGB(0, 215, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 16
    titleLabel.BackgroundTransparency = 1

    local setWarpButton = Instance.new("TextButton", frame)
    setWarpButton.Size = UDim2.new(0.9, 0, 0, 38)
    setWarpButton.Position = UDim2.new(0.05, 0, 0, 40)
    setWarpButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    setWarpButton.Text = "➕ บันทึกจุดตำแหน่งปัจจุบัน"
    setWarpButton.TextColor3 = Color3.new(1, 1, 1)
    setWarpButton.Font = Enum.Font.SourceSansBold
    setWarpButton.TextSize = 15
    Instance.new("UICorner", setWarpButton).CornerRadius = UDim.new(0, 6)

    local listScroll = Instance.new("ScrollingFrame", frame)
    listScroll.Size = UDim2.new(0.9, 0, 0, 190)
    listScroll.Position = UDim2.new(0.05, 0, 0, 100)
    listScroll.BackgroundTransparency = 1
    listScroll.BorderSizePixel = 0
    listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScroll.ScrollBarThickness = 4

    local listLayout = Instance.new("UIListLayout", listScroll)
    listLayout.Padding = UDim.new(0, 5)

    local UpdateWarpListUI 
    UpdateWarpListUI = function()
        for _, child in ipairs(listScroll:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for id, data in pairs(WarpStorage) do
            local itemRow = Instance.new("Frame", listScroll)
            itemRow.Size = UDim2.new(1, -6, 0, 35) 
            itemRow.BackgroundTransparency = 1

            local warpBtn = Instance.new("TextButton", itemRow)
            warpBtn.Size = UDim2.new(0.75, 0, 1, 0)
            warpBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 85)
            warpBtn.Text = "🚀 " .. data.Name
            warpBtn.TextColor3 = Color3.new(1, 1, 1)
            warpBtn.Font = Enum.Font.SourceSansBold
            warpBtn.TextSize = 14
            Instance.new("UICorner", warpBtn).CornerRadius = UDim.new(0, 5)

            local delBtn = Instance.new("TextButton", itemRow)
            delBtn.Size = UDim2.new(0.22, 0, 1, 0)
            delBtn.Position = UDim2.new(0.78, 0, 0, 0)
            delBtn.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
            delBtn.Text = "ลบ"
            delBtn.TextColor3 = Color3.new(1, 1, 1)
            delBtn.Font = Enum.Font.SourceSansBold
            delBtn.TextSize = 13
            Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 5)

            warpBtn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = data.CFrameValue + Vector3.new(0, 3, 0)
                end
            end)
            delBtn.MouseButton1Click:Connect(function() WarpStorage[id] = nil; UpdateWarpListUI() end)
        end
        listScroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
    end

    setWarpButton.MouseButton1Click:Connect(function()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            TotalPointsCreated = TotalPointsCreated + 1
            local currentId = "Warp_" .. tostring(tick()) 
            WarpStorage[currentId] = { Name = "จุดวาปที่ " .. tostring(TotalPointsCreated), CFrameValue = character.HumanoidRootPart.CFrame }
            UpdateWarpListUI() 
        end
    end)
end

-- 4. Freecam / Observer Mobile
local function Script_FreecamMobile()
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local FREECAM_SPEED = 60 

    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("FreecamMobileGui") then playerGui.FreecamMobileGui:Destroy() end

    local FreecamGui = Instance.new("ScreenGui")
    FreecamGui.Name = "FreecamMobileGui"
    FreecamGui.ResetOnSpawn = false
    FreecamGui.Parent = playerGui

    local Button = Instance.new("TextButton", FreecamGui)
    Button.Size = UDim2.new(0, 75, 0, 75)
    Button.Position = UDim2.new(0.82, 0, 0.4, 0) 
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Button.BackgroundTransparency = 0.2
    Button.Text = "👁️"
    Button.TextSize = 36
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)
    local UIStroke = Instance.new("UIStroke", Button)
    UIStroke.Color = Color3.fromRGB(80, 150, 255)
    UIStroke.Thickness = 3
    MakeDraggable(Button)

    local isFreecamActive = false
    local freecamPart = nil
    local renderConnection = nil

    local function ToggleFreecam()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not root or not hum then return end

        isFreecamActive = not isFreecamActive
        if isFreecamActive then
            root.Anchored = true
            freecamPart = Instance.new("Part")
            freecamPart.Size = Vector3.new(1, 1, 1); freecamPart.Transparency = 1; freecamPart.CanCollide = false
            freecamPart.Anchored = true; freecamPart.CFrame = root.CFrame; freecamPart.Parent = workspace
            Camera.CameraSubject = freecamPart
            renderConnection = RunService.RenderStepped:Connect(function(deltaTime)
                if hum.Health <= 0 then ToggleFreecam(); return end
                if hum.MoveDirection.Magnitude > 0 then
                    local moveDir = hum.MoveDirection
                    local localMove = Camera.CFrame:VectorToObjectSpace(moveDir)
                    local flyVector = (Camera.CFrame.RightVector * localMove.X) + (Camera.CFrame.LookVector * -localMove.Z)
                    freecamPart.CFrame = freecamPart.CFrame + (flyVector * FREECAM_SPEED * deltaTime)
                end
            end)
            Button.Text = "👀"; UIStroke.Color = Color3.fromRGB(80, 255, 80)
        else
            if renderConnection then renderConnection:Disconnect() end
            if freecamPart then freecamPart:Destroy() end
            if root then root.Anchored = false end
            if hum then Camera.CameraSubject = hum end
            Button.Text = "👁️"; UIStroke.Color = Color3.fromRGB(80, 150, 255)
        end
    end

    Button.MouseButton1Click:Connect(function() ToggleFreecam() end)
end

-- 5. Hybrid Noclip Hub
local function Script_HybridNoclip()
    local RunService = game:GetService("RunService")
    local SETTINGS = { NOCLIP_ENABLED = false }
    
    if CoreGui:FindFirstChild("NoclipHubGui") then CoreGui.NoclipHubGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "NoclipHubGui"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 150, 0, 80)
    MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(0, 170, 255)
    MainStroke.Thickness = 1.5
    MakeDraggable(MainFrame)

    local Header = Instance.new("TextLabel", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 25)
    Header.Text = " 🌀 NOCLIP HUB"
    Header.TextColor3 = Color3.fromRGB(255, 255, 255)
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 11
    Header.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

    local ToggleBtn = Instance.new("TextButton", MainFrame)
    ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
    ToggleBtn.Position = UDim2.new(0.05, 0, 0, 35)
    ToggleBtn.Text = "NOCLIP: OFF"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.SourceSansBold
    ToggleBtn.TextSize = 14
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

    local noclipConnection = nil
    local function UpdateNoclipState()
        if SETTINGS.NOCLIP_ENABLED then
            ToggleBtn.Text = "NOCLIP: ON"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            if not noclipConnection then
                noclipConnection = RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                        end
                    end
                end)
            end
        else
            ToggleBtn.Text = "NOCLIP: OFF"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if part.Name == "HumanoidRootPart" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end
    end

    ToggleBtn.MouseButton1Click:Connect(function()
        SETTINGS.NOCLIP_ENABLED = not SETTINGS.NOCLIP_ENABLED
        UpdateNoclipState()
    end)
end

-- 6. Auto-Respawn Fly
local function Script_AutoFly()
    local function LoadFlyScript()
        pcall(function() loadstring(game:HttpGet(('https://gist.githubusercontent.com/meozoneYT/bf037dff9f0a70017304ddd67fdcd370/raw/e14e74f425b060df523343cf30b787074eb3c5d2/arceus%2520x%2520fly%25202%2520obflucator'),true))() end)
    end
    task.spawn(LoadFlyScript)
    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        newCharacter:WaitForChild("Humanoid")
        task.wait(0.5) 
        LoadFlyScript()
    end)
end

-- 7. Mobile Joystick Customizer
local function Script_JoystickCustomizer()
    local RunService = game:GetService("RunService")
    if CoreGui:FindFirstChild("JoystickCustomizerUI") then CoreGui.JoystickCustomizerUI:Destroy() end

    local CustomSettings = { Scale = 1.0, Transparency = 0.3, OffsetX = 0, OffsetY = 0 }
    local originalPositions = {}

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "JoystickCustomizerUI"

    local SettingsHub = Instance.new("Frame", ScreenGui)
    SettingsHub.Size = UDim2.new(0, 260, 0, 240)
    SettingsHub.Position = UDim2.new(0.5, -130, 0, 70)
    SettingsHub.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SettingsHub.BackgroundTransparency = 0.2
    Instance.new("UICorner", SettingsHub).CornerRadius = UDim.new(0, 8)
    MakeDraggable(SettingsHub)

    local SettingsTitle = Instance.new("TextLabel", SettingsHub)
    SettingsTitle.Size = UDim2.new(1, 0, 0, 40)
    SettingsTitle.Text = "Customize Controls"
    SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsTitle.Font = Enum.Font.SourceSansBold
    SettingsTitle.TextSize = 18
    SettingsTitle.BackgroundTransparency = 1

    local SettingList = Instance.new("Frame", SettingsHub)
    SettingList.Size = UDim2.new(1, -20, 1, -50)
    SettingList.Position = UDim2.new(0, 10, 0, 40)
    SettingList.BackgroundTransparency = 1
    local UIListLayout = Instance.new("UIListLayout", SettingList)
    UIListLayout.Padding = UDim.new(0, 10)

    local function CreateStepper(name, settingKey, min, max, stepAmount, decimalPlaces)
        local Row = Instance.new("Frame", SettingList)
        Row.Size = UDim2.new(1, 0, 0, 35); Row.BackgroundTransparency = 1

        local Label = Instance.new("TextLabel", Row)
        Label.Size = UDim2.new(0.4, 0, 1, 0); Label.BackgroundTransparency = 1; Label.Text = name; Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        Label.Font = Enum.Font.SourceSansBold; Label.TextSize = 15; Label.TextXAlignment = Enum.TextXAlignment.Left

        local ControlFrame = Instance.new("Frame", Row)
        ControlFrame.Size = UDim2.new(0.6, 0, 1, 0); ControlFrame.Position = UDim2.new(0.4, 0, 0, 0); ControlFrame.BackgroundTransparency = 1

        local MinusBtn = Instance.new("TextButton", ControlFrame)
        MinusBtn.Size = UDim2.new(0, 30, 0, 30); MinusBtn.Position = UDim2.new(0, 0, 0.5, -15); MinusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        MinusBtn.Text = "-"; MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255); MinusBtn.Font = Enum.Font.SourceSansBold; MinusBtn.TextSize = 18
        Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 6)

        local ValueLabel = Instance.new("TextLabel", ControlFrame)
        ValueLabel.Size = UDim2.new(1, -70, 1, 0); ValueLabel.Position = UDim2.new(0, 35, 0, 0); ValueLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255); ValueLabel.Font = Enum.Font.SourceSansBold; ValueLabel.TextSize = 15
        Instance.new("UICorner", ValueLabel).CornerRadius = UDim.new(0, 6)

        local PlusBtn = Instance.new("TextButton", ControlFrame)
        PlusBtn.Size = UDim2.new(0, 30, 0, 30); PlusBtn.Position = UDim2.new(1, -30, 0.5, -15); PlusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        PlusBtn.Text = "+"; PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255); PlusBtn.Font = Enum.Font.SourceSansBold; PlusBtn.TextSize = 18
        Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 6)

        local function UpdateText() ValueLabel.Text = string.format("%." .. decimalPlaces .. "f", CustomSettings[settingKey]) end
        UpdateText()

        MinusBtn.MouseButton1Click:Connect(function() CustomSettings[settingKey] = math.clamp(CustomSettings[settingKey] - stepAmount, min, max); UpdateText() end)
        PlusBtn.MouseButton1Click:Connect(function() CustomSettings[settingKey] = math.clamp(CustomSettings[settingKey] + stepAmount, min, max); UpdateText() end)
    end

    CreateStepper("Scale (Size)", "Scale", 0.5, 3.0, 0.1, 1)
    CreateStepper("Transparency", "Transparency", 0, 1, 0.1, 1)
    CreateStepper("Position X", "OffsetX", -300, 300, 10, 0)
    CreateStepper("Position Y", "OffsetY", -300, 300, 10, 0)

    local function GetThumbstick()
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui and playerGui:FindFirstChild("TouchGui") then
            local controlFrame = playerGui.TouchGui:FindFirstChild("TouchControlFrame")
            if controlFrame then return controlFrame:FindFirstChild("DynamicThumbstickFrame") or controlFrame:FindFirstChild("ThumbstickFrame") end
        end
        return nil
    end

    RunService.RenderStepped:Connect(function()
        local stick = GetThumbstick()
        if stick then
            local uiScale = stick:FindFirstChild("CustomThumbstickScale")
            if not uiScale then uiScale = Instance.new("UIScale"); uiScale.Name = "CustomThumbstickScale"; uiScale.Parent = stick end
            uiScale.Scale = CustomSettings.Scale

            for _, child in ipairs(stick:GetDescendants()) do
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then child.ImageTransparency = CustomSettings.Transparency end
            end

            if not originalPositions[stick] then originalPositions[stick] = stick.Position end
            local origPos = originalPositions[stick]
            stick.Position = UDim2.new(origPos.X.Scale, origPos.X.Offset + CustomSettings.OffsetX, origPos.Y.Scale, origPos.Y.Offset + CustomSettings.OffsetY)
        end
    end)
end

-- 8. Instant Proximity Prompt
local function Script_ProximityHack()
    local Workspace = game:GetService("Workspace")
    local function modifyPrompt(prompt)
        if prompt:IsA("ProximityPrompt") then
            pcall(function()
                prompt.HoldDuration = 0
                if prompt.MaxActivationDistance < 30 then prompt.MaxActivationDistance = 30 end
                prompt.RequiresLineOfSight = false
            end)
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do modifyPrompt(obj) end
    Workspace.DescendantAdded:Connect(function(obj) task.wait(0.1); modifyPrompt(obj) end)
end

-- 9. Fast Respawn Mobile V2
local function Script_FastRespawn()
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("FastRespawnMobileGui") then playerGui.FastRespawnMobileGui:Destroy() end

    local RespawnGui = Instance.new("ScreenGui")
    RespawnGui.Name = "FastRespawnMobileGui"
    RespawnGui.Parent = playerGui

    local Button = Instance.new("TextButton", RespawnGui)
    Button.Size = UDim2.new(0, 75, 0, 75)
    Button.Position = UDim2.new(0.82, 0, 0.2, 0)
    Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Button.Text = "💀"
    Button.TextSize = 36 
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1, 0)
    local UIStroke = Instance.new("UIStroke", Button)
    UIStroke.Color = Color3.fromRGB(255, 80, 80)
    UIStroke.Thickness = 3
    MakeDraggable(Button)

    local isCooldown = false
    Button.MouseButton1Click:Connect(function()
        if isCooldown then return end
        isCooldown = true
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.Health = 0 end
            pcall(function() char:BreakJoints() end)
        end
        task.wait(1.5); isCooldown = false
    end)
end

-- 10. Mobile Click-to-Teleport
local function Script_ClickTeleport()
    local Workspace = game:GetService("Workspace")
    local Camera = Workspace.CurrentCamera
    local isTeleportEnabled = false

    if CoreGui:FindFirstChild("MobileClickTeleport") then CoreGui.MobileClickTeleport:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "MobileClickTeleport"

    local ToggleFrame = Instance.new("Frame", ScreenGui)
    ToggleFrame.Size = UDim2.new(0, 110, 0, 45)
    ToggleFrame.Position = UDim2.new(0.5, -55, 0, 20) 
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)
    MakeDraggable(ToggleFrame)

    local ToggleBtn = Instance.new("TextButton", ToggleFrame)
    ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
    ToggleBtn.BackgroundTransparency = 1
    ToggleBtn.Font = Enum.Font.SourceSansBold
    ToggleBtn.Text = "TP: OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80) 
    ToggleBtn.TextSize = 18

    ToggleBtn.MouseButton1Click:Connect(function()
        isTeleportEnabled = not isTeleportEnabled
        ToggleBtn.Text = isTeleportEnabled and "TP: ON" or "TP: OFF"
        ToggleBtn.TextColor3 = isTeleportEnabled and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end 
        if isTeleportEnabled and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
            local character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            local unitRay = Camera:ScreenPointToRay(input.Position.X, input.Position.Y)
            local raycastParams = RaycastParams.new(); raycastParams.FilterDescendantsInstances = {character}; raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            local raycastResult = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 10000, raycastParams)
            if raycastResult then character.HumanoidRootPart.CFrame = CFrame.new(raycastResult.Position + Vector3.new(0, 3.5, 0)) end
        end
    end)
end

-- 11. Auto Speed Modifier
local function Script_SpeedModifier()
    if CoreGui:FindFirstChild("SpeedModifierGui") then CoreGui.SpeedModifierGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "SpeedModifierGui"
    local SpeedFrame = Instance.new("Frame", ScreenGui)
    SpeedFrame.Size = UDim2.new(0, 100, 0, 40)
    SpeedFrame.Position = UDim2.new(0.85, 0, 0.15, 0) 
    SpeedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", SpeedFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 1.5
    MakeDraggable(SpeedFrame)

    local SpeedInput = Instance.new("TextBox", SpeedFrame)
    SpeedInput.Size = UDim2.new(0, 90, 0, 30)
    SpeedInput.Position = UDim2.new(0.5, 0, 0.5, 0)
    SpeedInput.AnchorPoint = Vector2.new(0.5, 0.5)
    SpeedInput.BackgroundTransparency = 1
    SpeedInput.Text = "16" 
    SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedInput.Font = Enum.Font.SourceSansBold
    SpeedInput.TextSize = 18

    SpeedInput.FocusLost:Connect(function()
        local newSpeed = tonumber(SpeedInput.Text)
        if newSpeed then
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("Humanoid") then Character.Humanoid.WalkSpeed = newSpeed end
        else SpeedInput.Text = "16" end
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChild("Humanoid") then
            local currentTargetSpeed = tonumber(SpeedInput.Text)
            if currentTargetSpeed and Character.Humanoid.WalkSpeed ~= currentTargetSpeed then
                Character.Humanoid.WalkSpeed = currentTargetSpeed
            end
        end
    end)
end

-- 12. Mobile Spectate V2
local function Script_MobileSpectate()
    local Workspace = game:GetService("Workspace")
    local Camera = Workspace.CurrentCamera
    local validPlayers = {}; local selectedIndex = 1; local selectedPlayer = nil
    local emergencyConnections = {}

    if CoreGui:FindFirstChild("MobileSpectateV2GUI") then CoreGui.MobileSpectateV2GUI:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "MobileSpectateV2GUI"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 200, 0, 85); MainFrame.Position = UDim2.new(0.5, -100, 0, 80)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    MakeDraggable(MainFrame)

    local PrevBtn = Instance.new("TextButton", MainFrame)
    PrevBtn.Size = UDim2.new(0, 30, 0, 30); PrevBtn.Position = UDim2.new(0, 5, 0, 10); PrevBtn.BackgroundTransparency = 1; PrevBtn.Text = "<"; PrevBtn.TextColor3 = Color3.fromRGB(200, 200, 200); PrevBtn.Font = Enum.Font.SourceSansBold; PrevBtn.TextSize = 22
    
    local NextBtn = Instance.new("TextButton", MainFrame)
    NextBtn.Size = UDim2.new(0, 30, 0, 30); NextBtn.Position = UDim2.new(1, -35, 0, 10); NextBtn.BackgroundTransparency = 1; NextBtn.Text = ">"; NextBtn.TextColor3 = Color3.fromRGB(200, 200, 200); NextBtn.Font = Enum.Font.SourceSansBold; NextBtn.TextSize = 22

    local NameLabel = Instance.new("TextLabel", MainFrame)
    NameLabel.Size = UDim2.new(1, -70, 0, 30); NameLabel.Position = UDim2.new(0, 35, 0, 10); NameLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    NameLabel.Text = "Select Player..."; NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255); NameLabel.Font = Enum.Font.SourceSansBold; NameLabel.TextSize = 14
    Instance.new("UICorner", NameLabel).CornerRadius = UDim.new(0, 4)

    local WatchBtn = Instance.new("TextButton", MainFrame)
    WatchBtn.Size = UDim2.new(0.42, 0, 0, 30); WatchBtn.Position = UDim2.new(0, 10, 0, 45); WatchBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
    WatchBtn.Text = "Spectate"; WatchBtn.TextColor3 = Color3.fromRGB(0, 0, 0); WatchBtn.Font = Enum.Font.SourceSansBold; WatchBtn.TextSize = 14
    Instance.new("UICorner", WatchBtn).CornerRadius = UDim.new(0, 6)

    local BackBtn = Instance.new("TextButton", MainFrame)
    BackBtn.Size = UDim2.new(0.42, 0, 0, 30); BackBtn.Position = UDim2.new(1, -95, 0, 45); BackBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    BackBtn.Text = "Back to Me"; BackBtn.TextColor3 = Color3.fromRGB(255, 255, 255); BackBtn.Font = Enum.Font.SourceSansBold; BackBtn.TextSize = 14
    Instance.new("UICorner", BackBtn).CornerRadius = UDim.new(0, 6)

    local function refreshPlayers()
        validPlayers = {}
        for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(validPlayers, p) end end
    end

    local function changeSelection(step)
        refreshPlayers()
        if #validPlayers == 0 then NameLabel.Text = "No Players"; selectedPlayer = nil; return end
        selectedIndex = selectedIndex + step
        if selectedIndex > #validPlayers then selectedIndex = 1 end; if selectedIndex < 1 then selectedIndex = #validPlayers end
        selectedPlayer = validPlayers[selectedIndex]; NameLabel.Text = selectedPlayer.DisplayName
    end

    local function clearConnections()
        for _, conn in ipairs(emergencyConnections) do if conn then conn:Disconnect() end end; emergencyConnections = {}
    end

    local function backToMe()
        clearConnections()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LocalPlayer.Character.Humanoid end
    end

    local function startSpectating()
        if not selectedPlayer or not selectedPlayer.Parent then NameLabel.Text = "Player Left!"; return end
        local char = selectedPlayer.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            clearConnections(); Camera.CameraSubject = char.Humanoid
            table.insert(emergencyConnections, char.Humanoid.Died:Connect(function() backToMe() end))
            table.insert(emergencyConnections, selectedPlayer.CharacterRemoving:Connect(function() backToMe() end))
        end
    end

    PrevBtn.MouseButton1Click:Connect(function() changeSelection(-1) end); NextBtn.MouseButton1Click:Connect(function() changeSelection(1) end)
    WatchBtn.MouseButton1Click:Connect(function() startSpectating() end); BackBtn.MouseButton1Click:Connect(function() backToMe() end)
    changeSelection(0)
end

-- 13. Mega Cage 
local function Script_MegaCage()
    local Cage_Enabled = false
    local CageParts = {} 
    local LockedPos = nil 

    if CoreGui:FindFirstChild("MegaCageGui") then CoreGui.MegaCageGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "MegaCageGui"

    local CageButton = Instance.new("TextButton", ScreenGui)
    CageButton.Name = "MegaCageToggle"
    CageButton.Size = UDim2.new(0, 120, 0, 35)
    CageButton.Position = UDim2.new(0.85, -20, 0.15, 0)
    CageButton.Text = "MEGA CAGE: OFF"
    CageButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CageButton.Font = Enum.Font.SourceSansBold
    CageButton.TextSize = 14
    Instance.new("UICorner", CageButton).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", CageButton)
    Stroke.Color = Color3.fromRGB(0, 255, 150)
    Stroke.Thickness = 2
    MakeDraggable(CageButton)

    local function CreateWall(size, pos)
        local p = Instance.new("Part")
        p.Size = size; p.Transparency = 0.7; p.Color = Color3.fromRGB(0, 255, 150); p.Material = Enum.Material.ForceField
        p.Anchored = true; p.CanCollide = true; p.CFrame = pos; p.Parent = workspace
        table.insert(CageParts, p)
    end

    local function BuildMegaCage(centerPos)
        for _, v in pairs(CageParts) do v:Destroy() end
        CageParts = {}
        local Width = 20; local Height = 25; local Offset = 10 
        CreateWall(Vector3.new(Width, Height, 1), centerPos * CFrame.new(0, 0, Offset)) 
        CreateWall(Vector3.new(Width, Height, 1), centerPos * CFrame.new(0, 0, -Offset)) 
        CreateWall(Vector3.new(1, Height, Width), centerPos * CFrame.new(Offset, 0, 0))  
        CreateWall(Vector3.new(1, Height, Width), centerPos * CFrame.new(-Offset, 0, 0)) 
        CreateWall(Vector3.new(Width, 1, Width), centerPos * CFrame.new(0, -3.5, 0))
        CreateWall(Vector3.new(Width, 1, Width), centerPos * CFrame.new(0, Height/2, 0))
    end

    CageButton.MouseButton1Click:Connect(function()
        Cage_Enabled = not Cage_Enabled
        CageButton.Text = Cage_Enabled and "MEGA CAGE: ON" or "MEGA CAGE: OFF"
        CageButton.BackgroundColor3 = Cage_Enabled and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 30, 30)
        local Character = LocalPlayer.Character
        if Cage_Enabled and Character and Character:FindFirstChild("HumanoidRootPart") then
            LockedPos = Character.HumanoidRootPart.CFrame
            BuildMegaCage(LockedPos)
        else
            for _, v in pairs(CageParts) do v:Destroy() end
            CageParts = {}
        end
    end)
end

-- 14. Server Hop & Rejoin
local function Script_ServerHop()
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")

    if CoreGui:FindFirstChild("ServerHopGui") then CoreGui.ServerHopGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "ServerHopGui"
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 170, 0, 155)
    MainFrame.Position = UDim2.new(0.5, -85, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BackgroundTransparency = 0.1
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    MakeDraggable(MainFrame)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "🌐 SERVER MANAGER"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 14
    Title.BackgroundTransparency = 1

    local function createBtn(text, yPos, color)
        local btn = Instance.new("TextButton", MainFrame)
        btn.Size = UDim2.new(0.9, 0, 0, 32)
        btn.Position = UDim2.new(0.05, 0, 0, yPos)
        btn.Text = text
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = color
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local BtnRejoin = createBtn("🔄 Rejoin (เข้าเซิร์ฟเดิม)", 35, Color3.fromRGB(0, 120, 200))
    local BtnLow = createBtn("📉 เซิร์ฟคนน้อย (Low)", 72, Color3.fromRGB(40, 140, 40))
    local BtnMax = createBtn("📈 เซิร์ฟคนเยอะ (Full)", 109, Color3.fromRGB(180, 50, 50))

    local PlaceId = game.PlaceId
    local JobId = game.JobId

    BtnRejoin.MouseButton1Click:Connect(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\nRejoining...")
            task.wait()
            TeleportService:Teleport(PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer)
        end
    end)

    local function HopServer(ascending)
        local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=" .. (ascending and "Asc" or "Desc") .. "&limit=100"
        local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing and server.maxPlayers and server.id ~= JobId then
                    if server.playing < server.maxPlayers and server.playing > 0 then
                        TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
        end
    end

    BtnLow.MouseButton1Click:Connect(function() HopServer(true) end)
    BtnMax.MouseButton1Click:Connect(function() HopServer(false) end)
end

-- 15. Universal ESP
local function Script_UniversalESP()
    pcall(function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/cool83birdcarfly02six/UNIVERSALESPLTX/main/README.md'),true))()
    end)
end

-- 16. Infinite Jump
local function Script_InfJump()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    -- เช็คของเก่าและลบทิ้งป้องกันบัคสร้างหน้าต่างทับกัน
    if playerGui:FindFirstChild("DraggableGUI") then playerGui.DraggableGUI:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "DraggableGUI"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui
     
    local frame = Instance.new("Frame")
    frame.Name = "DraggableFrame"
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0, 100, 0, 100)
    frame.BackgroundTransparency = 0.4
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = gui
    MakeDraggable(frame) -- ใช้ Custom Drag ทำให้ลื่นบนมือถือ
     
    local button = Instance.new("TextButton")
    button.Name = "InfJumpButton"
    button.Size = UDim2.new(0.8, 0, 0, 30)
    button.Position = UDim2.new(0.1, 0, 0.5, -15)
    button.BackgroundColor3 = Color3.new(0, 0.5, 1)
    button.Font = Enum.Font.SourceSans
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Text = "InfJump"
    button.Parent = frame
     
    local label = Instance.new("TextLabel")
    label.Name = "CreatorLabel"
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 0, 0, -20)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSansBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.Text = "Made by Sar_exploit"
    label.Parent = frame
     
    local infiniteJumpEnabled = false
     
    local function onButtonClick()
        infiniteJumpEnabled = not infiniteJumpEnabled
        button.Text = infiniteJumpEnabled and "Disable InfJump" or "Enable InfJump"
    end
     
    button.MouseButton1Click:Connect(onButtonClick)
     
    UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end

-- 17. Brightness Hub
local function Script_Brightness()
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")

    local oldGui = CoreGui:FindFirstChild("BrightnessMobileHub") or LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BrightnessMobileHub")
    if oldGui then oldGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BrightnessMobileHub"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 180, 0, 95)
    MainFrame.Position = UDim2.new(0.5, -90, 0.1, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BackgroundTransparency = 0.2 
    MainFrame.BorderSizePixel = 0
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    MakeDraggable(MainFrame)

    local MainHeader = Instance.new("TextLabel", MainFrame)
    MainHeader.Size = UDim2.new(1, 0, 0, 25)
    MainHeader.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainHeader.BackgroundTransparency = 0.2
    MainHeader.Text = " ☀️ LIGHT HUB"
    MainHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainHeader.Font = Enum.Font.SourceSansBold
    MainHeader.TextSize = 14
    MainHeader.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", MainHeader).CornerRadius = UDim.new(0, 8)

    local MasterToggleBtn = Instance.new("TextButton", MainFrame)
    MasterToggleBtn.Size = UDim2.new(0.9, 0, 0, 28)
    MasterToggleBtn.Position = UDim2.new(0.05, 0, 0, 30)
    MasterToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MasterToggleBtn.Text = "MASTER BRIGHT: OFF"
    MasterToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MasterToggleBtn.Font = Enum.Font.SourceSansBold
    MasterToggleBtn.TextSize = 14
    Instance.new("UICorner", MasterToggleBtn).CornerRadius = UDim.new(0, 6)

    local OpenSettingsBtn = Instance.new("TextButton", MainFrame)
    OpenSettingsBtn.Size = UDim2.new(0.9, 0, 0, 25)
    OpenSettingsBtn.Position = UDim2.new(0.05, 0, 0, 63)
    OpenSettingsBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OpenSettingsBtn.Text = "⚙️ Settings"
    OpenSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenSettingsBtn.Font = Enum.Font.SourceSansBold
    OpenSettingsBtn.TextSize = 13
    Instance.new("UICorner", OpenSettingsBtn).CornerRadius = UDim.new(0, 6)

    local SettingsFrame = Instance.new("Frame", ScreenGui)
    SettingsFrame.Size = UDim2.new(0, 180, 0, 150)
    SettingsFrame.Position = UDim2.new(0.5, 100, 0.1, 0)
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    SettingsFrame.BackgroundTransparency = 0.2
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.Visible = false 
    Instance.new("UICorner", SettingsFrame).CornerRadius = UDim.new(0, 8)
    MakeDraggable(SettingsFrame)

    local SettingsHeader = Instance.new("TextLabel", SettingsFrame)
    SettingsHeader.Size = UDim2.new(1, 0, 0, 25)
    SettingsHeader.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SettingsHeader.BackgroundTransparency = 0.2
    SettingsHeader.Text = " ⚙️ ADVANCED SETTINGS"
    SettingsHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsHeader.Font = Enum.Font.SourceSansBold
    SettingsHeader.TextSize = 12
    SettingsHeader.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", SettingsHeader).CornerRadius = UDim.new(0, 8)

    local CloseSettingsBtn = Instance.new("TextButton", SettingsHeader)
    CloseSettingsBtn.Size = UDim2.new(0, 25, 1, 0)
    CloseSettingsBtn.Position = UDim2.new(1, -25, 0, 0)
    CloseSettingsBtn.BackgroundTransparency = 1
    CloseSettingsBtn.Text = "X"
    CloseSettingsBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseSettingsBtn.Font = Enum.Font.SourceSansBold
    CloseSettingsBtn.TextSize = 14

    OpenSettingsBtn.MouseButton1Click:Connect(function() SettingsFrame.Visible = not SettingsFrame.Visible end)
    CloseSettingsBtn.MouseButton1Click:Connect(function() SettingsFrame.Visible = false end)

    local Configs = { ForceDay = true, NoFog = true, NoShadows = true, DisableAtmosphere = true }
    local lightingConnection
    local masterEnabled = false

    local function CreateSettingToggle(name, yPos, configKey)
        local Btn = Instance.new("TextButton", SettingsFrame)
        Btn.Size = UDim2.new(0.9, 0, 0, 25)
        Btn.Position = UDim2.new(0.05, 0, 0, yPos)
        Btn.BackgroundColor3 = Configs[configKey] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
        Btn.Text = name .. (Configs[configKey] and ": ON" or ": OFF")
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.Font = Enum.Font.SourceSansBold
        Btn.TextSize = 12
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        
        Btn.MouseButton1Click:Connect(function()
            Configs[configKey] = not Configs[configKey]
            Btn.BackgroundColor3 = Configs[configKey] and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
            Btn.Text = name .. (Configs[configKey] and ": ON" or ": OFF")
        end)
    end

    CreateSettingToggle("Force Day (12:00)", 30, "ForceDay")
    CreateSettingToggle("Remove Fog", 60, "NoFog")
    CreateSettingToggle("No Shadows", 90, "NoShadows")
    CreateSettingToggle("Del Atmosphere", 120, "DisableAtmosphere")

    local function UpdateLighting()
        if Configs.ForceDay then Lighting.ClockTime = 12; Lighting.TimeOfDay = "12:00:00" end
        Lighting.Ambient = Color3.fromRGB(255, 255, 255); Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255); Lighting.Brightness = 2
        if Configs.NoShadows then Lighting.GlobalShadows = false end
        if Configs.NoFog then Lighting.FogEnd = 1000000 end
        if Configs.DisableAtmosphere then
            for _, v in pairs(Lighting:GetDescendants()) do if v:IsA("Atmosphere") or v:IsA("ColorCorrectionEffect") then v.Enabled = false end end
        end
    end

    MasterToggleBtn.MouseButton1Click:Connect(function()
        masterEnabled = not masterEnabled
        if masterEnabled then
            MasterToggleBtn.Text = "MASTER BRIGHT: ON"
            MasterToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 180, 0) 
            MasterToggleBtn.TextColor3 = Color3.fromRGB(25, 25, 25)
            lightingConnection = RunService.RenderStepped:Connect(UpdateLighting)
        else
            MasterToggleBtn.Text = "MASTER BRIGHT: OFF"
            MasterToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MasterToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            if lightingConnection then lightingConnection:Disconnect(); lightingConnection = nil end
        end
    end)
end

-- ====================================================================
-- [[ 🛠️ MENU BUILDER ]]
-- ====================================================================

local PagePlayer   = CreateTab("👤 PLAYER", true)
local PageMovement = CreateTab("🏃‍♂️ MOVEMENT", false)
local PageVision   = CreateTab("👁️ VISION", false)
local PageTeleport = CreateTab("🚀 TELEPORT", false)
local PageControls = CreateTab("📱 CONTROLS", false)
local PageUtils    = CreateTab("⚡ UTILITIES", false)
local PageServer   = CreateTab("🌐 SERVER", false)

-- แท็บ PLAYER
CreateLauncherButton(PagePlayer, "ปลดล็อคซูมกล้อง (Infinite Zoom)", nil, Script_InfiniteZoom, true)
CreateLauncherButton(PagePlayer, "ปุ่มรีเซ็ตตัวละคร (Fast Respawn)", "FastRespawnMobileGui", Script_FastRespawn, false)

-- แท็บ MOVEMENT
CreateLauncherButton(PageMovement, "เดินบนอากาศ V4 (Air Walk)", "ScreenGui_AirWalk", Script_AirWalk, false)
CreateLauncherButton(PageMovement, "ทะลุกำแพง (Noclip Hub)", "NoclipHubGui", Script_HybridNoclip, false)
CreateLauncherButton(PageMovement, "สคริปต์บินแบบ Auto-Respawn", nil, Script_AutoFly, false)
CreateLauncherButton(PageMovement, "ปรับแต่งความเร็ว (Speed Modifier)", "SpeedModifierGui", Script_SpeedModifier, false)
CreateLauncherButton(PageMovement, "กระโดดไม่จำกัด (Inf Jump)", "DraggableGUI", Script_InfJump, false)

-- แท็บ VISION
CreateLauncherButton(PageVision, "โหมดสอดแนม (Freecam Mobile)", "FreecamMobileGui", Script_FreecamMobile, false)
CreateLauncherButton(PageVision, "แอบดูผู้เล่นอื่น (Mobile Spectate)", "MobileSpectateV2GUI", Script_MobileSpectate, false)
CreateLauncherButton(PageVision, "มองทะลุกำแพง (Universal ESP)", nil, Script_UniversalESP, false)
CreateLauncherButton(PageVision, "ปรับแสงสว่างสูงสุด (Brightness Hub)", "BrightnessMobileHub", Script_Brightness, false)

-- แท็บ TELEPORT
CreateLauncherButton(PageTeleport, "เมนูเซฟจุดวาร์ป (Multi-Warp)", "MultiWarpGUI_V1", Script_MultiWarp, false)
CreateLauncherButton(PageTeleport, "แตะเพื่อวาร์ป (Click-to-Teleport)", "MobileClickTeleport", Script_ClickTeleport, false)

-- แท็บ CONTROLS
CreateLauncherButton(PageControls, "ปรับแต่งจอยสติ๊ก (Joystick Mod)", "JoystickCustomizerUI", Script_JoystickCustomizer, false)

-- แท็บ UTILITIES
CreateLauncherButton(PageUtils, "แฮ็กปุ่มกด (Instant Prompt + X-Ray)", nil, Script_ProximityHack, false)
CreateLauncherButton(PageUtils, "เสกกรงป้องกัน (Mega Cage)", "MegaCageGui", Script_MegaCage, false)

-- แท็บ SERVER
CreateLauncherButton(PageServer, "ย้ายเซิร์ฟเวอร์ / Rejoin", "ServerHopGui", Script_ServerHop, false)

print("✅ [Hub] Successfully Loaded & Optimized 17 Scripts (Mobile Edition)!")

