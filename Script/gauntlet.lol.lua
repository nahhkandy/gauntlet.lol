local cref = cloneref or function(O) return O end

local StarterGui = cref(game:GetService("StarterGui"))
local Players = cref(game:GetService("Players"))
local TweenService = cref(game:GetService("TweenService"))
local UserInputService = cref(game:GetService("UserInputService"))
local RunService = cref(game:GetService("RunService"))
local HttpService = cref(game:GetService("HttpService"))

local TrajectoryFolder = Instance.new("Folder")
TrajectoryFolder.Name = "TrajectoryViewer"
TrajectoryFolder.Parent = workspace

if getgenv().GauntletLoaded then
    return StarterGui:SetCore("SendNotification", {
    Title = "gauntlet.lol Error Message";
    Text = "You cannot run multiple instance of gauntlet.lol!";
    Duration = 5;
})
end

getgenv().GauntletLoaded = true

local ThumbType = Enum.ThumbnailType.HeadShot
local ThumbSize = Enum.ThumbnailSize.Size420x420
local LocalPlayer = Players.LocalPlayer
local ID = LocalPlayer.UserId

local Mouse = LocalPlayer:GetMouse()
local force = 1000
local draggingSlider = false


local SG = Instance.new("ScreenGui")
SG.Name = ""
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("ImageLabel")
Main.Name = "Main"
Main.BorderSizePixel = 0
Main.BackgroundColor3 = Color3.new(0.26, 0.26, 0.26)
Main.ImageTransparency = 0.30000001192092896
Main.Image = "rbxassetid://6975920113"
Main.Size = UDim2.new(0.25, 100.00, 0.49, 100.00)
Main.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
Main.Position = UDim2.new(0.38, 0.00, 0.12, 0.00)
Main.Parent = SG

local User = Instance.new("TextLabel")
User.Name = "User"
User.BorderSizePixel = 0
User.BackgroundColor3 = Color3.new(0.14, 0.14, 0.14)
User.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
User.TextXAlignment = Enum.TextXAlignment.Left
User.TextSize = 40
User.Size = UDim2.new(0.22, 200.00, 0.01, 50.00)
User.Text = "Hello, " .. LocalPlayer.Name .. "!"
User.TextColor3 = Color3.new(1.00, 1.00, 1.00)
User.BackgroundTransparency = 1
User.Position = UDim2.new(-0.00, 0.00, 0.89, 0.00)
User.Parent = Main

local drg = Instance.new("Frame")
drg.Name = "drg"
drg.Size = UDim2.new(1.00, 0.00, 0.11, 0.00)
drg.BorderColor3 = Color3.new(0.26, 0.26, 0.26)
drg.Position = UDim2.new(0.00, 0.00, -0.00, 0.00)
drg.BorderSizePixel = 0
drg.ZIndex = 0
drg.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
drg.Parent = Main

local Profile = Instance.new("ImageLabel")
Profile.Name = "Profile"
Profile.BorderSizePixel = 0
Profile.BackgroundColor3 = Color3.new(0.29, 0.29, 0.29)
Profile.Image = Players:GetUserThumbnailAsync(ID, ThumbType, ThumbSize)
Profile.Size = UDim2.new(0.09, 0.00, 0.11, 0.00)
Profile.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
Profile.Position = UDim2.new(0.28, 0.00, 0.89, 0.00)
Profile.Parent = Main

local function updateProfilePosition()
    Profile.Position = UDim2.new(0, User.TextBounds.X + 10, 0.89, 0)
end

updateProfilePosition()
User:GetPropertyChangedSignal("TextBounds"):Connect(updateProfilePosition)

local uic2 = Instance.new("UICorner")
uic2.Name = "uic2"
uic2.CornerRadius = UDim.new(1.00, 1.00)
uic2.Parent = Profile

local yo_title____ = Instance.new("TextLabel")
yo_title____.Name = "yo title?!?!"
yo_title____.TextStrokeTransparency = 0
yo_title____.BorderSizePixel = 0
yo_title____.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
yo_title____.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
yo_title____.TextStrokeColor3 = Color3.new(1.00, 1.00, 1.00)
yo_title____.TextSize = 35
yo_title____.Size = UDim2.new(0.20, 200.00, 0.01, 50.00)
yo_title____.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
yo_title____.Text = "gauntlet.lol (public release)"
yo_title____.TextColor3 = Color3.new(0.98, 0.89, 0.21)
yo_title____.BackgroundTransparency = 1
yo_title____.Position = UDim2.new(0.19, 0.00, 0.00, 0.00)
yo_title____.Parent = Main

local uic = Instance.new("UICorner")
uic.Name = "uic"
uic.Parent = Main

local log = Instance.new("TextLabel")
log.Name = "log"
log.TextWrapped = true
log.BorderSizePixel = 0
log.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
log.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
log.TextSize = 40
log.Size = UDim2.new(0.01, 200.00, 0.46, 50.00)
log.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
log.Text = "changelog --------------------public release!"
log.TextColor3 = Color3.new(1.00, 1.00, 1.00)
log.BackgroundTransparency = 1
log.Position = UDim2.new(0.31, 0.00, 0.18, 0.00)
log.Parent = Main

local VersionText = Instance.new("TextLabel")
VersionText.Name = "VersionText"
VersionText.BorderSizePixel = 0
VersionText.BackgroundTransparency = 1
VersionText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
VersionText.TextSize = 14
VersionText.Size = UDim2.new(0.2, 0, 0.05, 0)
VersionText.Text = "fetching version..."
VersionText.TextColor3 = Color3.new(1, 1, 1)
VersionText.TextTransparency = 0.7
VersionText.Position = UDim2.new(0.8, 0, 0.95, 0)
VersionText.Parent = Main

local function fetchVersion()
    if true then
        VersionText.Text = "VERSION: 1.00a (release)"
    else
        VersionText.Text = "failed fetching version :("
    end
end

fetchVersion()

local miscB = Instance.new("TextButton")
miscB.Name = "miscB"
miscB.TextWrapped = true
miscB.BorderSizePixel = 0
miscB.TextScaled = true
miscB.BackgroundColor3 = Color3.new(0.26, 0.26, 0.26)
miscB.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
miscB.TextSize = 14
miscB.Size = UDim2.new(0.14, 0.00, 0.10, 0.00)
miscB.TextColor3 = Color3.new(1.00, 1.00, 1.00)
miscB.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
miscB.Text = "Misc"
miscB.Position = UDim2.new(-0.14, 0.00, 0.13, 0.00)
miscB.Parent = Main

local mainB = Instance.new("TextButton")
mainB.Name = "mainB"
mainB.TextWrapped = true
mainB.BorderSizePixel = 0
mainB.TextScaled = true
mainB.BackgroundColor3 = Color3.new(0.26, 0.26, 0.26)
mainB.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
mainB.TextSize = 14
mainB.Size = UDim2.new(0.14, 0.00, 0.10, 0.00)
mainB.TextColor3 = Color3.new(1.00, 1.00, 1.00)
mainB.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
mainB.Text = "Main"
mainB.Position = UDim2.new(-0.14, 0.00, 0.05, 0.00)
mainB.Parent = Main

local homeB = Instance.new("TextButton")
homeB.Name = "homeB"
homeB.TextWrapped = true
homeB.BorderSizePixel = 0
homeB.TextScaled = true
homeB.BackgroundColor3 = Color3.new(0.26, 0.26, 0.26)
homeB.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
homeB.TextSize = 14
homeB.Size = UDim2.new(0.14, 0.00, 0.10, 0.00)
homeB.TextColor3 = Color3.new(1.00, 1.00, 1.00)
homeB.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
homeB.Text = "Home"
homeB.Position = UDim2.new(-0.14, 0.00, 0.21, 0.00)
homeB.Parent = Main

local FBool = Instance.new("TextLabel")
FBool.Name = "FBool"
FBool.BorderSizePixel = 0
FBool.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
FBool.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
FBool.TextSize = 25
FBool.Size = UDim2.new(0.40, 0.00, 0.16, 0.00)
FBool.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
FBool.Text = "Fling Enabled?"
FBool.TextColor3 = Color3.new(1.00, 1.00, 1.00)
FBool.BackgroundTransparency = 1
FBool.Position = UDim2.new(0.07, 0.00, 0.18, 0.00)
FBool.Visible = false
FBool.Parent = Main

local Checkorx = Instance.new("TextButton")
Checkorx.Name = "Checkorx"
Checkorx.BorderSizePixel = 0
Checkorx.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
Checkorx.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Checkorx.TextStrokeColor3 = Color3.new(1.00, 1.00, 1.00)
Checkorx.TextSize = 20
Checkorx.Size = UDim2.new(0.19, 0.00, 0.44, 0.00)
Checkorx.TextColor3 = Color3.new(0.00, 0.00, 0.00)
Checkorx.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
Checkorx.Text = "✅"
Checkorx.BackgroundTransparency = 1
Checkorx.Position = UDim2.new(0.81, 0.00, 0.30, 0.00)
Checkorx.Visible = false
Checkorx.Parent = FBool

local ForceSlider = Instance.new("Frame")
ForceSlider.Name = "ForceSlider"
ForceSlider.Size = UDim2.new(0.5, 0, 0.05, 0)
ForceSlider.Position = UDim2.new(0.07, 0, 0.4, 0)
ForceSlider.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
ForceSlider.BorderSizePixel = 0
ForceSlider.Visible = false
ForceSlider.Parent = Main

local SliderKnob = Instance.new("Frame")
SliderKnob.Name = "SliderKnob"
SliderKnob.Size = UDim2.new(0.05, 0, 2, 0)
SliderKnob.Position = UDim2.new(0, 0, -0.5, 0)
SliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
SliderKnob.BorderSizePixel = 0
SliderKnob.Parent = ForceSlider

local ForceLabel = Instance.new("TextLabel")
ForceLabel.Name = "ForceLabel"
ForceLabel.Size = UDim2.new(0.4, 0, 0.16, 0)
ForceLabel.Position = UDim2.new(0.07, 0, 0.3, 0)
ForceLabel.BackgroundTransparency = 1
ForceLabel.Text = "Force: " .. tostring(force)
ForceLabel.TextColor3 = Color3.new(1, 1, 1)
ForceLabel.TextSize = 25
ForceLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
ForceLabel.Visible = false
ForceLabel.Parent = Main

local AutoClickerLabel = Instance.new("TextLabel")
AutoClickerLabel.Name = "AutoClickerLabel"
AutoClickerLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
AutoClickerLabel.Position = UDim2.new(0.1, 0, 0.3, 0)
AutoClickerLabel.BackgroundTransparency = 1
AutoClickerLabel.Text = "Autoclicker"
AutoClickerLabel.TextColor3 = Color3.new(1, 1, 1)
AutoClickerLabel.TextSize = 20
AutoClickerLabel.Visible = false
AutoClickerLabel.Parent = Main

local KeyInputsFrame = Instance.new("Frame")
KeyInputsFrame.Name = "KeyInputsFrame"
KeyInputsFrame.Size = UDim2.new(0.8, 0, 0.3, 0)
KeyInputsFrame.Position = UDim2.new(0.1, 0, 0.45, 0)
KeyInputsFrame.BackgroundTransparency = 1
KeyInputsFrame.Visible = false
KeyInputsFrame.Parent = Main

local OnKeyLabel = Instance.new("TextLabel")
OnKeyLabel.Size = UDim2.new(0.45, 0, 0.3, 0)
OnKeyLabel.Position = UDim2.new(0, 0, 0, 0)
OnKeyLabel.BackgroundTransparency = 1
OnKeyLabel.Text = "Toggle On Key:"
OnKeyLabel.TextColor3 = Color3.new(1, 1, 1)
OnKeyLabel.TextSize = 16
OnKeyLabel.Parent = KeyInputsFrame

local OffKeyLabel = Instance.new("TextLabel")
OffKeyLabel.Size = UDim2.new(0.45, 0, 0.3, 0)
OffKeyLabel.Position = UDim2.new(0.55, 0, 0, 0)
OffKeyLabel.BackgroundTransparency = 1
OffKeyLabel.Text = "Toggle Off Key:"
OffKeyLabel.TextColor3 = Color3.new(1, 1, 1)
OffKeyLabel.TextSize = 16
OffKeyLabel.Parent = KeyInputsFrame

local onKey = Instance.new("TextBox")
onKey.Size = UDim2.new(0.45, 0, 0.3, 0)
onKey.Position = UDim2.new(0, 0, 0.4, 0)
onKey.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
onKey.Text = "Press any key"
onKey.TextColor3 = Color3.new(1, 1, 1)
onKey.TextSize = 16
onKey.Parent = KeyInputsFrame

local offKey = Instance.new("TextBox")
offKey.Size = UDim2.new(0.45, 0, 0.3, 0)
offKey.Position = UDim2.new(0.55, 0, 0.4, 0)
offKey.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
offKey.Text = "Press any key"
offKey.TextColor3 = Color3.new(1, 1, 1)
offKey.TextSize = 16
offKey.Parent = KeyInputsFrame

local MiscScrollingFrame = Instance.new("ScrollingFrame")
MiscScrollingFrame.Name = "MiscScrollingFrame"
MiscScrollingFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
MiscScrollingFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MiscScrollingFrame.BackgroundTransparency = 1
MiscScrollingFrame.ScrollBarThickness = 4
MiscScrollingFrame.Visible = false
MiscScrollingFrame.Parent = Main

local AntiAFKLabel = Instance.new("TextLabel")
AntiAFKLabel.Name = "AntiAFKLabel"
AntiAFKLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
AntiAFKLabel.Position = UDim2.new(0.1, 0, 0, 0)
AntiAFKLabel.BackgroundTransparency = 1
AntiAFKLabel.Text = "Anti-AFK"
AntiAFKLabel.TextColor3 = Color3.new(1, 1, 1)
AntiAFKLabel.TextSize = 20
AntiAFKLabel.Parent = MiscScrollingFrame

local AntiAFKToggle = Instance.new("TextButton")
AntiAFKToggle.Name = "AntiAFKToggle"
AntiAFKToggle.Size = UDim2.new(0.2, 0, 0.1, 0)
AntiAFKToggle.Position = UDim2.new(0.7, 0, 0, 0)
AntiAFKToggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
AntiAFKToggle.Text = "❌"
AntiAFKToggle.TextColor3 = Color3.new(1, 1, 1)
AntiAFKToggle.TextSize = 20
AntiAFKToggle.Parent = MiscScrollingFrame

AutoClickerLabel.Parent = MiscScrollingFrame
AutoClickerLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
KeyInputsFrame.Parent = MiscScrollingFrame
KeyInputsFrame.Position = UDim2.new(0.1, 0, 0.3, 0)


local TrajectoryToggle = Instance.new("TextLabel")
TrajectoryToggle.Name = "TrajectoryToggle"
TrajectoryToggle.BorderSizePixel = 0
TrajectoryToggle.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
TrajectoryToggle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
TrajectoryToggle.TextSize = 25
TrajectoryToggle.Size = UDim2.new(0.40, 0.00, 0.16, 0.00)
TrajectoryToggle.Text = "Show Trajectory?"
TrajectoryToggle.TextColor3 = Color3.new(1.00, 1.00, 1.00)
TrajectoryToggle.BackgroundTransparency = 1
TrajectoryToggle.Position = UDim2.new(0.07, 0.00, 0.5, 0.00)
TrajectoryToggle.Visible = false
TrajectoryToggle.Parent = Main

local TrajectoryButton = Instance.new("TextButton")
TrajectoryButton.Name = "TrajectoryButton"
TrajectoryButton.BorderSizePixel = 0
TrajectoryButton.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
TrajectoryButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TrajectoryButton.TextSize = 20
TrajectoryButton.Size = UDim2.new(0.19, 0.00, 0.44, 0.00)
TrajectoryButton.TextColor3 = Color3.new(0.00, 0.00, 0.00)
TrajectoryButton.Text = "❌"
TrajectoryButton.BackgroundTransparency = 1
TrajectoryButton.Position = UDim2.new(0.81, 0.00, 0.62, 0.00)
TrajectoryButton.Visible = false
TrajectoryButton.Parent = TrajectoryToggle

local function toggleCheckorx()
    local isChecked = Checkorx.Text == "✅"
    local goal = { Rotation = isChecked and 180 or 0 }
    TweenService:Create(Checkorx, TweenInfo.new(0.3), goal):Play()
    wait(0.15)
    Checkorx.Text = isChecked and "❌" or "✅"
end

local function toggleMainView()
    local isVisible = FBool.Visible
    FBool.Visible = not isVisible
    Checkorx.Visible = not isVisible
    ForceSlider.Visible = not isVisible
    ForceLabel.Visible = not isVisible
    TrajectoryToggle.Visible = not isVisible
    TrajectoryButton.Visible = not isVisible
    log.Visible = false
    MiscScrollingFrame.Visible = false
    AutoClickerLabel.Visible = false
    KeyInputsFrame.Visible = false
end

local function showChangelog()
    FBool.Visible = false
    Checkorx.Visible = false
    log.Visible = true
    ForceSlider.Visible = false
    ForceLabel.Visible = false
    MiscScrollingFrame.Visible = false
    AutoClickerLabel.Visible = false
    KeyInputsFrame.Visible = false
    TrajectoryToggle.Visible = false
    TrajectoryButton.Visible = false
end

local function thingie()
    FBool.Visible = false
    Checkorx.Visible = false
    log.Visible = false
    ForceSlider.Visible = false
    ForceLabel.Visible = false
    MiscScrollingFrame.Visible = true
    AutoClickerLabel.Visible = true
    KeyInputsFrame.Visible = true
    TrajectoryToggle.Visible = false
    TrajectoryButton.Visible = false
end

Checkorx.MouseButton1Click:Connect(toggleCheckorx)
mainB.MouseButton1Click:Connect(toggleMainView)
homeB.MouseButton1Click:Connect(showChangelog)
miscB.MouseButton1Click:Connect(thingie)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (input.Position - dragStart).X, startPos.Y.Scale, startPos.Y.Offset + (input.Position - dragStart).Y)
end

drg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

drg.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)


local function updateForce(input)
    if not draggingSlider then return end
    
    local pos = math.clamp((input.Position.X - ForceSlider.AbsolutePosition.X) / ForceSlider.AbsoluteSize.X, 0, 1)
    SliderKnob.Position = UDim2.new(pos, 0, -0.5, 0)
    force = math.floor(pos * 2000)
    ForceLabel.Text = "Force: " .. force
end

SliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        
        local moveConn
        local releaseConn
        
        moveConn = UserInputService.InputChanged:Connect(function(moveInput)
            if moveInput.UserInputType == Enum.UserInputType.MouseMovement or 
               moveInput.UserInputType == Enum.UserInputType.Touch then
                updateForce(moveInput)
            end
        end)
        
        releaseConn = UserInputService.InputEnded:Connect(function(releaseInput)
            if releaseInput.UserInputType == Enum.UserInputType.MouseButton1 or 
               releaseInput.UserInputType == Enum.UserInputType.Touch then
                moveConn:Disconnect()
                releaseConn:Disconnect()
                draggingSlider = false
            end
        end)
    end
end)

UserInputService.InputBegan:Connect(function(key, processed)
    if key.KeyCode == Enum.KeyCode.F and not processed then
        if Checkorx.Text == "✅" then
            local char = LocalPlayer.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local hit = Mouse.Hit.p
                    local dir = (hit - root.Position).Unit
                    
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity = dir * force
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.P = 10000
                    bv.Parent = root
                    
                    local bav = Instance.new("BodyAngularVelocity")
                    bav.AngularVelocity = Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)) * 5
                    bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    bav.P = 10000
                    bav.Parent = root
                    
                    game:GetService("Debris"):AddItem(bv, 0.1)
                    game:GetService("Debris"):AddItem(bav, 0.1)
                end
            end
        end
    end
end)
local autoClickerEnabled = false
local clickConnection = nil

local function handleKeyInput(input, textBox)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        textBox.Text = input.KeyCode.Name
        return input.KeyCode
    end
end

local onKeyCode = nil
local offKeyCode = nil

onKey.Focused:Connect(function()
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            onKeyCode = handleKeyInput(input, onKey)
            onKey:ReleaseFocus()
            connection:Disconnect()
        end
    end)
end)

offKey.Focused:Connect(function()
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            offKeyCode = handleKeyInput(input, offKey)
            offKey:ReleaseFocus()
            connection:Disconnect()
        end
    end)
end)
local function startAutoClicker()
    if clickConnection then return end
    
    autoClickerEnabled = true
    clickConnection = RunService.Heartbeat:Connect(function()
        if autoClickerEnabled then
            mouse1press()
            wait()
            mouse1release()
        end
    end)
end

local function stopAutoClicker()
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
    autoClickerEnabled = false
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == onKeyCode then
        startAutoClicker()
    elseif input.KeyCode == offKeyCode then
        stopAutoClicker()
    end
end)

local antiAFKEnabled = false
local antiAFKConnection = nil

local function toggleAntiAFK()
    antiAFKEnabled = not antiAFKEnabled
    AntiAFKToggle.Text = antiAFKEnabled and "✅" or "❌"
    
    if antiAFKEnabled then
        local VirtualUser = game:GetService("VirtualUser")
        antiAFKConnection = RunService.Heartbeat:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
    end
end

AntiAFKToggle.MouseButton1Click:Connect(toggleAntiAFK)
MiscScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local function createTrajectoryPoint(size, transparency)
    local point = Instance.new("Part")
    point.Shape = Enum.PartType.Ball
    point.Size = Vector3.new(size, size, size)
    point.Material = Enum.Material.Neon
    point.Color = Color3.new(0, 1, 1)
    point.CanCollide = false
    point.Anchored = true
    point.Transparency = transparency
    point.Parent = TrajectoryFolder
    return point
end

local trajectoryPoints = {}
local maxPoints = 200
local showingTrajectory = false

local function clearTrajectory()
    for _, point in ipairs(trajectoryPoints) do
        point:Destroy()
    end
    trajectoryPoints = {}
end

local function performRaycast(origin, direction, ignoreList)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = ignoreList
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result
end
local function updateTrajectory()
    if not showingTrajectory then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local hit = Mouse.Hit.p
    local dir = (hit - root.Position).Unit
    local velocity = dir * force
    local position = root.Position
    local timeStep = 0.016  
    
    clearTrajectory()
    
    local ignoreList = {char, TrajectoryFolder}
    local hasHitSomething = false
    local pointSize = 0.3 
    
    for i = 1, maxPoints do
        if hasHitSomething then break end
        
        local point = createTrajectoryPoint(pointSize, 0.5)
        point.Position = position
        table.insert(trajectoryPoints, point)
        
        if i > 1 and i < maxPoints then
            local prevPoint = trajectoryPoints[i-1]
            local midPosition = prevPoint.Position:Lerp(position, 0.5)
            local midPoint = createTrajectoryPoint(pointSize * 0.7, 0.7)
            midPoint.Position = midPosition
            table.insert(trajectoryPoints, midPoint)
        end
        
        local nextPosition = position + velocity * timeStep
        local rayDirection = nextPosition - position
        local rayResult = performRaycast(position, rayDirection, ignoreList)
        
        if rayResult then
            local impactPoint = createTrajectoryPoint(pointSize * 2, 0.1)
            impactPoint.Position = rayResult.Position
            impactPoint.Color = Color3.new(1, 0, 0)
            table.insert(trajectoryPoints, impactPoint)
            
            for j = 1, 8 do
                local angle = (j/8) * math.pi * 2
                local offset = Vector3.new(math.cos(angle), math.sin(angle), math.cos(angle)) * 0.5
                local ringPoint = createTrajectoryPoint(pointSize * 0.5, 0.3)
                ringPoint.Position = rayResult.Position + offset
                ringPoint.Color = Color3.new(1, 0.5, 0)
                table.insert(trajectoryPoints, ringPoint)
            end
            
            hasHitSomething = true
            break
        end
    
        position = nextPosition
        velocity = velocity + Vector3.new(0, -196.2, 0) * timeStep
    end
end

TrajectoryButton.MouseButton1Click:Connect(function()
    showingTrajectory = not showingTrajectory
    TrajectoryButton.Text = showingTrajectory and "✅" or "❌"
    
    if not showingTrajectory then
        clearTrajectory()
    end
end)

local trajectoryUpdateConnection = RunService.Heartbeat:Connect(function()
    if showingTrajectory and Checkorx.Text == "✅" then
        updateTrajectory()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        trajectoryUpdateConnection:Disconnect()
        TrajectoryFolder:Destroy()
    end
end)
