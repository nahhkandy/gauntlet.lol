local cref = cloneref or function(O) return O end

local StarterGui = cref(game:GetService("StarterGui"))
local Players = cref(game:GetService("Players"))
local TweenService = cref(game:GetService("TweenService"))
local UserInputService = cref(game:GetService("UserInputService"))
local RunService = cref(game:GetService("RunService"))
local ReplicatedStorage = cref(game:GetService("ReplicatedStorage"))
local LocalPlayer = Players.LocalPlayer
local stealthMode = false
local guiVisibleBeforeStealth = true
local mapTable = {"bfur", "Line"} -- change, worst maps for cheating (imo)

local TrajectoryFolder = Instance.new("Folder")
TrajectoryFolder.Name = "TrajectoryViewer"
TrajectoryFolder.Parent = workspace

local SG = Instance.new("ScreenGui")
SG.Name = ""
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function notify(title, message, type, duration)
    duration = duration or 5

    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, 20, 1, -100)
    notification.BackgroundTransparency = 0.1
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.Parent = SG

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification

    local sideBar = Instance.new("Frame")
    sideBar.Size = UDim2.new(0, 4, 1, 0)
    sideBar.Position = UDim2.new(0, 0, 0, 0)
    sideBar.BorderSizePixel = 0
    sideBar.Parent = notification

    local typeColors = {
        error = Color3.fromRGB(255, 64, 64),
        info = Color3.fromRGB(64, 156, 255),
        warning = Color3.fromRGB(255, 164, 64),
        success = Color3.fromRGB(64, 255, 128)
    }
    sideBar.BackgroundColor3 = typeColors[type] or Color3.fromRGB(200, 200, 200)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 0, 40)
    messageLabel.Position = UDim2.new(0, 15, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.Parent = notification

    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 0, 4)
    progressBar.Position = UDim2.new(0, 0, 1, -4)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = notification

    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBar

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6026984224"
    sound.Volume = 1
    sound.Parent = notification
    sound:Play()

    local tweenIn = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -100)})
    tweenIn:Play()

    local progressTween = TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 4)})
    progressTween:Play()

    task.delay(duration, function()
        local fadeOut = TweenService:Create(notification, TweenInfo.new(0.3), {Position = UDim2.new(1, 20, 1, -100)})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

if _G.GauntletLoaded then
    notify("gauntlet.lol Error", "You cannot run multiple instances of gauntlet.lol!", "error", 5)
    return
end
_G.GauntletLoaded = true

local ThumbType = Enum.ThumbnailType.HeadShot
local ThumbSize = Enum.ThumbnailSize.Size420x420
local ID = LocalPlayer.UserId

local Mouse = LocalPlayer:GetMouse()
local force = 1000
local draggingSlider = false

notify("gauntlet.lol Info", "Script executed successfully", "success", 5)

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 400, 0, 500)
Main.Position = UDim2.new(0.5, -200, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Main.BorderSizePixel = 0
Main.Parent = SG

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar


local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "gauntlet.lol"
Title.TextColor3 = Color3.fromRGB(250, 227, 54)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local User = Instance.new("TextLabel")
User.Name = "User"
User.Size = UDim2.new(0.5, 0, 0, 40)
User.Position = UDim2.new(0.02, 0, 0.9, 0)
User.BackgroundTransparency = 1
User.Text = "Hello, " .. LocalPlayer.Name .. "!"
User.TextColor3 = Color3.fromRGB(255, 255, 255)
User.TextSize = 18
User.Font = Enum.Font.GothamMedium
User.TextXAlignment = Enum.TextXAlignment.Left
User.Parent = Main

local Profile = Instance.new("ImageLabel")
Profile.Name = "Profile"
Profile.Size = UDim2.new(0, 40, 0, 40)
Profile.Position = UDim2.new(0, User.TextBounds.X + 15, 0.9, 0)
Profile.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
Profile.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Profile.Parent = Main

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(1, 0)
ProfileCorner.Parent = Profile

local function updateProfilePosition()
    Profile.Position = UDim2.new(0, User.TextBounds.X + 10, 0.89, 0)
end

updateProfilePosition()
User:GetPropertyChangedSignal("TextBounds"):Connect(updateProfilePosition)


local VersionText = Instance.new("TextLabel")
VersionText.Name = "VersionText"
VersionText.Size = UDim2.new(0.2, 0, 0, 20)
VersionText.Position = UDim2.new(0.78, 0, 0.93, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "fetching version..."
VersionText.TextColor3 = Color3.new(1, 1, 1)
VersionText.TextTransparency = 0.7
VersionText.TextSize = 14
VersionText.Font = Enum.Font.Gotham
VersionText.Parent = Main

local function fetchVersion()
    if true then
        VersionText.Text = "v1.01a"
    else
        VersionText.Text = "failed fetching version :("
    end
end

fetchVersion()

local function createNavButton(name, posY)
    local button = Instance.new("TextButton")
    button.Name = name .. "B"
    button.Size = UDim2.new(0.14, 0, 0.08, 0)
    button.Position = UDim2.new(-0.14, 0, posY, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.GothamMedium
    button.Parent = Main
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    return button
end

local mainB = createNavButton("Main", 0.05)
local miscB = createNavButton("Misc", 0.13)
local homeB = createNavButton("Home", 0.21)

local log = Instance.new("TextLabel")
log.Name = "log"
log.Size = UDim2.new(0.8, 0, 0.6, 0)
log.Position = UDim2.new(0.1, 0, 0.2, 0)
log.BackgroundTransparency = 1
log.Text = "stealth mode (for streaming) and auto voting!"
log.TextColor3 = Color3.fromRGB(255, 255, 255)
log.TextSize = 16
log.Font = Enum.Font.GothamMedium
log.TextWrapped = true
log.Visible = false
log.Parent = Main

local FBool = Instance.new("TextLabel")
FBool.Name = "FBool"
FBool.Size = UDim2.new(0.4, 0, 0.08, 0)
FBool.Position = UDim2.new(0.07, 0, 0.18, 0)
FBool.BackgroundTransparency = 1
FBool.Text = "Fling Enabled?"
FBool.TextColor3 = Color3.fromRGB(255, 255, 255)
FBool.TextSize = 18
FBool.Font = Enum.Font.GothamBold
FBool.Visible = false
FBool.Parent = Main

local FlingKeyLabel = Instance.new("TextLabel")
FlingKeyLabel.Name = "FlingKeyLabel"
FlingKeyLabel.Size = UDim2.new(0.4, 0, 0.08, 0)
FlingKeyLabel.Position = UDim2.new(0.07, 0, 0.68, 0)
FlingKeyLabel.BackgroundTransparency = 1
FlingKeyLabel.Text = "Fling Key:"
FlingKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingKeyLabel.TextSize = 18
FlingKeyLabel.Font = Enum.Font.GothamBold
FlingKeyLabel.Visible = false
FlingKeyLabel.Parent = Main

local FlingKeyInput = Instance.new("TextBox")
FlingKeyInput.Name = "FlingKeyInput"
FlingKeyInput.Size = UDim2.new(0.15, 0, 0.08, 0)
FlingKeyInput.Position = UDim2.new(0.48, 0, 0.68, 0)
FlingKeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
FlingKeyInput.Text = "F"
FlingKeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingKeyInput.TextSize = 16
FlingKeyInput.Font = Enum.Font.GothamBold
FlingKeyInput.Visible = false
FlingKeyInput.Parent = Main

local FlingKeyCorner = Instance.new("UICorner")
FlingKeyCorner.CornerRadius = UDim.new(0, 8)
FlingKeyCorner.Parent = FlingKeyInput

local Checkorx = Instance.new("TextButton")
Checkorx.Name = "Checkorx"
Checkorx.Size = UDim2.new(0.08, 0, 0.08, 0)
Checkorx.Position = UDim2.new(0.48, 0, 0.18, 0)
Checkorx.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Checkorx.Text = "✅"
Checkorx.TextColor3 = Color3.fromRGB(255, 255, 255)
Checkorx.TextSize = 16
Checkorx.Font = Enum.Font.GothamBold
Checkorx.Visible = false
Checkorx.Parent = Main

local CheckorxCorner = Instance.new("UICorner")
CheckorxCorner.CornerRadius = UDim.new(0, 8)
CheckorxCorner.Parent = Checkorx

local ForceSlider = Instance.new("Frame")
ForceSlider.Name = "ForceSlider"
ForceSlider.Size = UDim2.new(0.5, 0, 0.04, 0)
ForceSlider.Position = UDim2.new(0.07, 0, 0.4, 0)
ForceSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ForceSlider.BorderSizePixel = 0
ForceSlider.Visible = false
ForceSlider.Parent = Main

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(1, 0)
SliderCorner.Parent = ForceSlider

local SliderKnob = Instance.new("Frame")
SliderKnob.Name = "SliderKnob"
SliderKnob.Size = UDim2.new(0.05, 0, 2, 0)
SliderKnob.Position = UDim2.new(0, 0, -0.5, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(250, 227, 54)
SliderKnob.BorderSizePixel = 0
SliderKnob.Parent = ForceSlider

local KnobCorner = Instance.new("UICorner")
KnobCorner.CornerRadius = UDim.new(1, 0)
KnobCorner.Parent = SliderKnob

local ForceLabel = Instance.new("TextLabel")
ForceLabel.Name = "ForceLabel"
ForceLabel.Size = UDim2.new(0.4, 0, 0.08, 0)
ForceLabel.Position = UDim2.new(0.07, 0, 0.3, 0)
ForceLabel.BackgroundTransparency = 1
ForceLabel.Text = "Force: 1000"
ForceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ForceLabel.TextSize = 18
ForceLabel.Font = Enum.Font.GothamMedium
ForceLabel.Visible = false
ForceLabel.Parent = Main

local TrajectoryToggle = Instance.new("TextLabel")
TrajectoryToggle.Name = "TrajectoryToggle"
TrajectoryToggle.Size = UDim2.new(0.4, 0, 0.08, 0)
TrajectoryToggle.Position = UDim2.new(0.07, 0, 0.5, 0)
TrajectoryToggle.BackgroundTransparency = 1
TrajectoryToggle.Text = "Show Trajectory?"
TrajectoryToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TrajectoryToggle.TextSize = 18
TrajectoryToggle.Font = Enum.Font.GothamBold
TrajectoryToggle.Visible = false
TrajectoryToggle.Parent = Main

local TrajectoryButton = Instance.new("TextButton")
TrajectoryButton.Name = "TrajectoryButton"
TrajectoryButton.Size = UDim2.new(0.08, 0, 0.08, 0)
TrajectoryButton.Position = UDim2.new(0.48, 0, 0.5, 0)
TrajectoryButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TrajectoryButton.Text = "❌"
TrajectoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TrajectoryButton.TextSize = 16
TrajectoryButton.Font = Enum.Font.GothamBold
TrajectoryButton.Visible = false
TrajectoryButton.Parent = Main

local TrajectoryButtonCorner = Instance.new("UICorner")
TrajectoryButtonCorner.CornerRadius = UDim.new(0, 8)
TrajectoryButtonCorner.Parent = TrajectoryButton

local MiscScrollingFrame = Instance.new("ScrollingFrame")
MiscScrollingFrame.Name = "MiscScrollingFrame"
MiscScrollingFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
MiscScrollingFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MiscScrollingFrame.BackgroundTransparency = 1
MiscScrollingFrame.ScrollBarThickness = 4
MiscScrollingFrame.Visible = false
MiscScrollingFrame.Parent = Main
MiscScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)

local AntiAFKLabel = Instance.new("TextLabel")
AntiAFKLabel.Name = "AntiAFKLabel"
AntiAFKLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
AntiAFKLabel.Position = UDim2.new(0.1, 0, 0, 0)
AntiAFKLabel.BackgroundTransparency = 1
AntiAFKLabel.Text = "Anti-AFK"
AntiAFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAFKLabel.TextSize = 18
AntiAFKLabel.Font = Enum.Font.GothamBold
AntiAFKLabel.Parent = MiscScrollingFrame

local AntiAFKToggle = Instance.new("TextButton")
AntiAFKToggle.Name = "AntiAFKToggle"
AntiAFKToggle.Size = UDim2.new(0.15, 0, 0.1, 0)
AntiAFKToggle.Position = UDim2.new(0.75, 0, 0, 0)
AntiAFKToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
AntiAFKToggle.Text = "❌"
AntiAFKToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAFKToggle.TextSize = 16
AntiAFKToggle.Font = Enum.Font.GothamBold
AntiAFKToggle.Parent = MiscScrollingFrame

local AntiAFKToggleCorner = Instance.new("UICorner")
AntiAFKToggleCorner.CornerRadius = UDim.new(0, 8)
AntiAFKToggleCorner.Parent = AntiAFKToggle

local AutoClickerLabel = Instance.new("TextLabel")
AutoClickerLabel.Name = "AutoClickerLabel"
AutoClickerLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
AutoClickerLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
AutoClickerLabel.BackgroundTransparency = 1
AutoClickerLabel.Text = "Autoclicker"
AutoClickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickerLabel.TextSize = 18
AutoClickerLabel.Font = Enum.Font.GothamBold
AutoClickerLabel.Parent = MiscScrollingFrame

local KeyInputsFrame = Instance.new("Frame")
KeyInputsFrame.Name = "KeyInputsFrame"
KeyInputsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInputsFrame.Size = UDim2.fromScale(0.8, 0.3)
KeyInputsFrame.Position = UDim2.fromScale(0.5, 0.45)
KeyInputsFrame.BackgroundTransparency = 1
KeyInputsFrame.Visible = false
KeyInputsFrame.Parent = Main

local OnKeyLabel = Instance.new("TextLabel")
OnKeyLabel.Size = UDim2.fromScale(0.45, 0.3)
OnKeyLabel.Position = UDim2.fromScale(0, 0)
OnKeyLabel.BackgroundTransparency = 1
OnKeyLabel.Text = "Toggle On Key:"
OnKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OnKeyLabel.TextSize = 16
OnKeyLabel.Font = Enum.Font.Gotham
OnKeyLabel.Parent = KeyInputsFrame

local OffKeyLabel = Instance.new("TextLabel")
OffKeyLabel.Size = UDim2.fromScale(0.45, 0.3)
OffKeyLabel.Position = UDim2.fromScale(0.55, 0)
OffKeyLabel.BackgroundTransparency = 1
OffKeyLabel.Text = "Toggle Off Key:"
OffKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OffKeyLabel.TextSize = 16
OffKeyLabel.Font = Enum.Font.Gotham
OffKeyLabel.Parent = KeyInputsFrame

local onKey = Instance.new("TextBox")
onKey.Size = UDim2.fromScale(0.45, 0.3)
onKey.Position = UDim2.fromScale(0, 0.4)
onKey.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
onKey.Text = "Press any key"
onKey.TextColor3 = Color3.fromRGB(255, 255, 255)
onKey.TextSize = 16
onKey.Font = Enum.Font.Gotham
onKey.BorderSizePixel = 0
onKey.Parent = KeyInputsFrame

local offKey = Instance.new("TextBox")
offKey.Size = UDim2.fromScale(0.45, 0.3)
offKey.Position = UDim2.fromScale(0.55, 0.4)
offKey.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
offKey.Text = "Press any key"
offKey.TextColor3 = Color3.fromRGB(255, 255, 255)
offKey.TextSize = 16
offKey.Font = Enum.Font.Gotham
offKey.BorderSizePixel = 0
offKey.Parent = KeyInputsFrame

local StealthButton = Instance.new("TextButton")
StealthButton.Name = "StealthButton"
StealthButton.Size = UDim2.new(0, 30, 0, 30)
StealthButton.Position = UDim2.new(0.92, 0, 0.5, -15)
StealthButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
StealthButton.Text = "👁️"
StealthButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StealthButton.TextSize = 16
StealthButton.Font = Enum.Font.GothamBold
StealthButton.Parent = TopBar

local StealthButtonCorner = Instance.new("UICorner")
StealthButtonCorner.CornerRadius = UDim.new(0, 8)
StealthButtonCorner.Parent = StealthButton


local StealthKeyLabel = Instance.new("TextLabel")
StealthKeyLabel.Name = "StealthKeyLabel"
StealthKeyLabel.Size = UDim2.new(0.4, 0, 0.08, 0)
StealthKeyLabel.Position = UDim2.new(0.07, 0, 0.78, 0)
StealthKeyLabel.BackgroundTransparency = 1
StealthKeyLabel.Text = "Stealth Mode Key:"
StealthKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StealthKeyLabel.TextSize = 18
StealthKeyLabel.Font = Enum.Font.GothamBold
StealthKeyLabel.Visible = false
StealthKeyLabel.Parent = Main

local StealthKeyInput = Instance.new("TextBox")
StealthKeyInput.Name = "StealthKeyInput"
StealthKeyInput.Size = UDim2.new(0.15, 0, 0.08, 0)
StealthKeyInput.Position = UDim2.new(0.48, 0, 0.78, 0)
StealthKeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
StealthKeyInput.Text = "X"
StealthKeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
StealthKeyInput.TextSize = 16
StealthKeyInput.Font = Enum.Font.GothamBold
StealthKeyInput.Visible = false
StealthKeyInput.Parent = Main

local StealthKeyCorner = Instance.new("UICorner")
StealthKeyCorner.CornerRadius = UDim.new(0, 8)
StealthKeyCorner.Parent = StealthKeyInput

local function updateMiscScrollingFrame()
    AutoClickerLabel.Size = UDim2.new(0.8, 0, 0.08, 0)
    AutoClickerLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
    
    local keyInputsContainer = Instance.new("Frame")
    keyInputsContainer.Name = "KeyInputsContainer"
    keyInputsContainer.Size = UDim2.new(1, 0, 0.3, 0)
    keyInputsContainer.Position = UDim2.new(0, 0, 0.25, 0)
    keyInputsContainer.BackgroundTransparency = 1
    keyInputsContainer.Parent = MiscScrollingFrame
    
    OnKeyLabel.Size = UDim2.new(0.45, 0, 0.3, 0)
    OnKeyLabel.Position = UDim2.new(0.1, 0, 0, 0)
    OnKeyLabel.Parent = keyInputsContainer
    
    OffKeyLabel.Size = UDim2.new(0.45, 0, 0.3, 0)
    OffKeyLabel.Position = UDim2.new(0.1, 0, 0.35, 0)
    OffKeyLabel.Parent = keyInputsContainer
    
    onKey.Size = UDim2.new(0.3, 0, 0.25, 0)
    onKey.Position = UDim2.new(0.6, 0, 0, 0)
    onKey.Parent = keyInputsContainer
    
    offKey.Size = UDim2.new(0.3, 0, 0.25, 0)
    offKey.Position = UDim2.new(0.6, 0, 0.35, 0)
    offKey.Parent = keyInputsContainer
    
    AntiAFKLabel.Size = UDim2.new(0.8, 0, 0.08, 0)
    AntiAFKLabel.Position = UDim2.new(0.1, 0, 0, 0)
    
    AntiAFKToggle.Size = UDim2.new(0.15, 0, 0.08, 0)
    AntiAFKToggle.Position = UDim2.new(0.75, 0, 0, 0)
end

local function animateToggle(button, enabled)
    local rotation = enabled and 0 or 180
    local finalText = enabled and "✅" or "❌"
    
    local rotateTween = TweenService:Create(button, 
        TweenInfo.new(0.3, Enum.EasingStyle.Back), 
        {Rotation = rotation}
    )
    
    local bounceOut = TweenService:Create(button,
        TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
        {Size = UDim2.new(0.08, 0, 0.08, 0)}
    )
    
    local bounceIn = TweenService:Create(button,
        TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.In),
        {Size = UDim2.new(0.09, 0, 0.09, 0)}
    )
    
    bounceIn:Play()
    bounceIn.Completed:Wait()
    rotateTween:Play()
    wait(0.15)
    button.Text = finalText
    bounceOut:Play()
end

local function toggleCheckorx()
    local isChecked = Checkorx.Text == "✅"
    animateToggle(Checkorx, not isChecked)
end

updateMiscScrollingFrame()

local function toggleMainView()
    local isVisible = FBool.Visible
    FBool.Visible = not isVisible
    Checkorx.Visible = not isVisible
    ForceSlider.Visible = not isVisible
    ForceLabel.Visible = not isVisible
    TrajectoryToggle.Visible = not isVisible
    TrajectoryButton.Visible = not isVisible
    FlingKeyLabel.Visible = not isVisible
    FlingKeyInput.Visible = not isVisible
    log.Visible = false
    MiscScrollingFrame.Visible = false
    AutoClickerLabel.Visible = false
    KeyInputsFrame.Visible = false
    StealthKeyLabel.Visible = isVisible
    StealthKeyInput.Visible = isVisible
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
    FlingKeyLabel.Visible = false
    FlingKeyInput.Visible = false
    StealthKeyLabel.Visible = false
    StealthKeyInput.Visible = false
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
    FlingKeyLabel.Visible = false
    FlingKeyInput.Visible = false
    StealthKeyLabel.Visible = false
    StealthKeyInput.Visible = false
end

local function toggleStealthMode()
    stealthMode = not stealthMode
    
    if stealthMode then
        guiVisibleBeforeStealth = Main.Visible
        
        local fadeOut = TweenService:Create(
            Main, 
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        )
        
        fadeOut:Play()
        fadeOut.Completed:Wait()
        Main.Visible = false
        
        local indicator = Instance.new("Frame")
        indicator.Name = "StealthIndicator"
        indicator.Size = UDim2.new(0, 10, 0, 10)
        indicator.Position = UDim2.new(1, -15, 0, 5)
        indicator.BackgroundColor3 = Color3.fromRGB(250, 227, 54)
        indicator.BorderSizePixel = 0
        indicator.Parent = SG
        
        local indicatorCorner = Instance.new("UICorner")
        indicatorCorner.CornerRadius = UDim.new(1, 0)
        indicatorCorner.Parent = indicator
        
        task.spawn(function()
            while stealthMode and indicator and indicator.Parent do
                local pulseTween = TweenService:Create(
                    indicator,
                    TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {Transparency = 0.7}
                )
                pulseTween:Play()
                wait(1)
                
                if not stealthMode then break end
                
                local pulseTweenBack = TweenService:Create(
                    indicator,
                    TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {Transparency = 0}
                )
                pulseTweenBack:Play()
                wait(1)
            end
        end)
        
        StealthButton.Text = "⚪"
    else
        local indicator = SG:FindFirstChild("StealthIndicator")
        if indicator then
            indicator:Destroy()
        end
        
        Main.BackgroundTransparency = 1
        Main.Visible = guiVisibleBeforeStealth
        
        local fadeIn = TweenService:Create(
            Main, 
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
        )
        
        fadeIn:Play()
        StealthButton.Text = "👁️"
    end
end

showChangelog()

Checkorx.MouseButton1Click:Connect(toggleCheckorx)
mainB.MouseButton1Click:Connect(toggleMainView)
homeB.MouseButton1Click:Connect(showChangelog)
miscB.MouseButton1Click:Connect(thingie)
StealthButton.MouseButton1Click:Connect(toggleStealthMode)

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (input.Position - dragStart).X, startPos.Y.Scale, startPos.Y.Offset + (input.Position - dragStart).Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
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

local currentFlingKey = Enum.KeyCode.F

FlingKeyInput.Focused:Connect(function()
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentFlingKey = input.KeyCode
            FlingKeyInput.Text = input.KeyCode.Name
            FlingKeyInput:ReleaseFocus()
            connection:Disconnect()
        end
    end)
end)

UserInputService.InputBegan:Connect(function(key, processed)
    if key.KeyCode == currentFlingKey and not processed then
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

local currentStealthKey = Enum.KeyCode.X

StealthKeyInput.Focused:Connect(function()
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentStealthKey = input.KeyCode
            StealthKeyInput.Text = input.KeyCode.Name
            StealthKeyInput:ReleaseFocus()
            connection:Disconnect()
        end
    end)
end)

UserInputService.InputBegan:Connect(function(key, processed)
    if key.KeyCode == currentStealthKey and not processed then
        toggleStealthMode()
    end
end)


local function autoVote()
    local currentTime = tick()
    local timeRemaining = lastVoteTime + cooldownDuration - currentTime
    
    if timeRemaining > 0 then
        notify("Auto Vote", string.format("You can't auto-vote until %.1f seconds.", timeRemaining), "error", 3)
        return
    end
    
    local connection
    connection = game:GetService("LogService").MessageOut:Connect(function(message)
        for _, map in ipairs(mapTable) do
            local pattern = "(" .. map .. ")__"
            if message:find(pattern) then
                local nextMapIndex
                for i, currentMap in ipairs(mapTable) do
                    if currentMap == map then
                        nextMapIndex = i % #mapTable + 1
                        break
                    end
                end
                
                ReplicatedStorage.ClientVoteToChangeMap:FireServer()
                notify("Auto Vote", 'Automatically voted or already voted.', "info", 3)
                
                connection:Disconnect()
                break
            end
        end
    end)
end

while true do
    task.wait(5)
    autoVote()
end
