local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Quality x",
    Icon = "rbxassetid://138614699274576",
    Author = "Hello, I'm Txr, I'm cool.",
    Folder = "MySuperHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Name = LocalPlayer.Name,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId,
        Callback = function() end,
    },
})

Window:EditOpenButton({ Enabled = false })

local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("ImageButton")

ScreenGui.Name = "WindUI_Toggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://138614699274576" 
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local opened = true

local function toggle()
    opened = not opened
    if Window.UI then
        Window.UI.Enabled = opened
    else
        Window:Toggle()
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    ToggleBtn:TweenSize(
        UDim2.new(0, 56, 0, 56),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.12,
        true,
        function()
            ToggleBtn:TweenSize(
                UDim2.new(0, 50, 0, 50),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.12,
                true
            )
        end
    )
    toggle()
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        toggle()
    end
end)


if not LocalPlayer.Character then
LocalPlayer.CharacterAdded:Wait()
end

-- ========================================
-- TAB : Main
-- ========================================
local MainTab =
    Window:Tab(
    {
        Title = "General",
        Icon = "globe"
    }
)

-- ========================================
-- Button : Spawn Rainbow Block (10 times)
-- ========================================
MainTab:Button({
    Title = "Spawn Rainbow Block",
    Description = "Spawn Rainbow Block x10",
    Callback = function()
        local remote = ReplicatedStorage:WaitForChild("SpawnRainbowBlock")
        for i = 1, 10 do
            remote:FireServer()
            task.wait(0.05) -- กันสแปมเร็วเกิน
        end
    end
})

-- ========================================
-- Button : Spawn Galaxy Block (10 times)
-- ========================================
MainTab:Button({
    Title = "Spawn Galaxy Block",
    Description = "Spawn Galaxy Block x10",
    Callback = function()
        local remote = ReplicatedStorage:WaitForChild("SpawnGalaxyBlock")
        for i = 1, 10 do
            remote:FireServer()
            task.wait(0.05)
        end
    end
})

-- ========================================
-- WalkSpeed (Persist after death)
-- ========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local WalkSpeedValue = 16

local function applyWalkSpeed(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = WalkSpeedValue
end

-- ตัวละครปัจจุบัน
if LocalPlayer.Character then
    applyWalkSpeed(LocalPlayer.Character)
end

-- เกิดใหม่หลังตาย
LocalPlayer.CharacterAdded:Connect(function(character)
    applyWalkSpeed(character)
end)

-- Slider
PlayerTab:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 200,
        Default = WalkSpeedValue
    },
    Callback = function(v)
        WalkSpeedValue = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end
})

-- ========================================
-- JumpPower (Persist after death)
-- ========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local JumpPowerValue = 50 -- ค่าเริ่มต้น Roblox

local function applyJumpPower(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.UseJumpPower = true
    humanoid.JumpPower = JumpPowerValue
end

-- ตัวละครปัจจุบัน
if LocalPlayer.Character then
    applyJumpPower(LocalPlayer.Character)
end

-- ตาย / เกิดใหม่
LocalPlayer.CharacterAdded:Connect(function(character)
    applyJumpPower(character)
end)

-- Slider
PlayerTab:Slider({
    Title = "JumpPower",
    Step = 1,
    Value = {
        Min = 50,
        Max = 300,
        Default = JumpPowerValue
    },
    Callback = function(v)
        JumpPowerValue = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = LocalPlayer.Character.Humanoid
            humanoid.UseJumpPower = true
            humanoid.JumpPower = v
        end
    end
})
