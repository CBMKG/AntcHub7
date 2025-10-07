-- ANTC HUB ULTIMATE PROFESSIONAL FINAL
-- Complete Roblox Script with All Features

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local WEBHOOK_URL = "https://workspace.bano99039.repl.co/webhook/verify"
local KEY_TRACKING_WEBHOOK = "https://discord.com/api/webhooks/1424756327686733825/hcc5Gbvb9cmOnneM_le1fpY8084L1l2jugBFuKa0OsOQ4UzE9HpdrGCRzcKJteg1zwMd" -- TARUH LINK DISCORD WEBHOOK DI SINI UNTUK TRACKING KEY GENERATION

local Settings = {
    Fly = false,
    AntiAFK = false,
    KillAura = false,
    Speed = false,
    HighJump = false,
    Invisible = false,
    GodMode = false,
    Aimbot = false,
    Noclip = false,
    AntiKick = false,
    SpeedValue = 50,
    JumpPower = 100,
    FlySpeed = 100,
    KillAuraRange = 20,
    SavedPosition = nil,
    RespawnAtSaved = false,
    GUIScale = 0.85,
    CustomNameTag = "",
    ShowNameTag = false,
    SafeZoneActive = false,
    SafeZoneOriginalPos = nil,
    BannerImageID = "5554236805",
    AutoClick = false,
    AutoClickInterval = 1000,
    AirWalk = false,
    AutoSafe = false
}

local UserStatus = "GUEST"
local UserTier = 1
local KeyVerified = false
local Checkpoints = {}
local BannedPlayers = {}
local GeneratedKeys = {}
local SpectateExitButton = nil
local SavedAvatar = nil
local KeyExpiryTime = nil
local IsLifetimeKey = false
local FlyEnabled = false
local FlyConnection = nil
local DeveloperActivityWebhook = "https://discord.com/api/webhooks/1424756327686733825/hcc5Gbvb9cmOnneM_le1fpY8084L1l2jugBFuKa0OsOQ4UzE9HpdrGCRzcKJteg1zwMd"
local CurrentSpectateTarget = nil
local MinimizedFrame = nil
local MainLoop = nil
local AutoClickConnection = nil
local AutoClickInterval = 1000
local AirWalkPart = nil

local function LoadSettings()
    if isfile and readfile then
        local success, fileExists = pcall(function()
            return isfile("ANTC_HUB_Settings.json")
        end)
        
        if success and fileExists then
            local readSuccess, data = pcall(function()
                return HttpService:JSONDecode(readfile("ANTC_HUB_Settings.json"))
            end)
            if readSuccess and data then
                for k, v in pairs(data) do
                    if k ~= "SafeZoneOriginalPos" then
                        Settings[k] = v
                    end
                end
            else
                warn("Failed to load settings:", data)
            end
        end
    end
end

local function SaveSettings()
    if writefile then
        local success, err = pcall(function()
            local saveData = {}
            for k, v in pairs(Settings) do
                if k ~= "SafeZoneOriginalPos" then
                    saveData[k] = v
                end
            end
            writefile("ANTC_HUB_Settings.json", HttpService:JSONEncode(saveData))
        end)
        if not success then
            warn("Failed to save settings:", err)
        end
    end
end

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "ANTC_Notifications"
NotificationGui.ResetOnSpawn = false
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.DisplayOrder = 999

if syn then
    syn.protect_gui(NotificationGui)
    NotificationGui.Parent = CoreGui
else
    NotificationGui.Parent = CoreGui
end

local NotificationContainer = Instance.new("Frame")
NotificationContainer.Size = UDim2.new(0, 380, 1, -20)
NotificationContainer.Position = UDim2.new(1, -10, 1, -10)
NotificationContainer.AnchorPoint = Vector2.new(1, 1)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.Parent = NotificationGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Parent = NotificationContainer

local notifCount = 0

local function CreateNotification(title, text, duration, iconColor)
    notifCount = notifCount + 1
    local thisNotif = notifCount
    
    for _, child in pairs(NotificationContainer:GetChildren()) do
        if child:IsA("Frame") then
            child.LayoutOrder = child.LayoutOrder - 1
        end
    end
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(1, 0, 0, 75)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
    NotifFrame.BackgroundTransparency = 0.05
    NotifFrame.BorderSizePixel = 0
    NotifFrame.LayoutOrder = 1000
    NotifFrame.Parent = NotificationContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = NotifFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = iconColor or Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.3
    Stroke.Parent = NotifFrame
    
    local IconBg = Instance.new("Frame")
    IconBg.Size = UDim2.new(0, 55, 1, 0)
    IconBg.BackgroundColor3 = iconColor or Color3.fromRGB(138, 43, 226)
    IconBg.BackgroundTransparency = 0.15
    IconBg.BorderSizePixel = 0
    IconBg.Parent = NotifFrame
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 12)
    IconCorner.Parent = IconBg
    
    local IconCover = Instance.new("Frame")
    IconCover.Size = UDim2.new(0, 12, 1, 0)
    IconCover.Position = UDim2.new(1, -12, 0, 0)
    IconCover.BackgroundColor3 = iconColor or Color3.fromRGB(138, 43, 226)
    IconCover.BackgroundTransparency = 0.15
    IconCover.BorderSizePixel = 0
    IconCover.Parent = IconBg
    
    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.new(1, 0, 1, 0)
    IconText.BackgroundTransparency = 1
    IconText.Text = "A"
    IconText.Font = Enum.Font.GothamBold
    IconText.TextSize = 30
    IconText.TextColor3 = Color3.fromRGB(255, 255, 255)
    IconText.Parent = IconBg
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -70, 0, 28)
    TitleLabel.Position = UDim2.new(0, 65, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = NotifFrame
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -70, 0, 32)
    TextLabel.Position = UDim2.new(0, 65, 0, 36)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.TextSize = 12
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true
    TextLabel.Parent = NotifFrame
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(1, 0, 0, 2.5)
    ProgressBar.Position = UDim2.new(0, 0, 1, -2.5)
    ProgressBar.BackgroundColor3 = iconColor or Color3.fromRGB(138, 43, 226)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = NotifFrame
    
    NotifFrame.Size = UDim2.new(0, 0, 0, 75)
    TweenService:Create(NotifFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 0, 75)
    }):Play()
    
    task.spawn(function()
        task.wait(0.25)
        TweenService:Create(ProgressBar, TweenInfo.new(duration or 3, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 0, 2.5)
        }):Play()
        
        task.wait(duration or 3)
        TweenService:Create(NotifFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 75)
        }):Play()
        
        task.wait(0.25)
        NotifFrame:Destroy()
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ANTC_HUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 100

if syn then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

local function CreateKeySystem()
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 420, 0, 360)
    KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    KeyFrame.BackgroundTransparency = 0.03
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = ScreenGui
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 16)
    KeyCorner.Parent = KeyFrame
    
    local KeyStroke = Instance.new("UIStroke")
    KeyStroke.Color = Color3.fromRGB(138, 43, 226)
    KeyStroke.Thickness = 2
    KeyStroke.Transparency = 0.2
    KeyStroke.Parent = KeyFrame
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(138, 43, 226)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.ZIndex = -1
    Shadow.Parent = KeyFrame
    
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 90)
    TopBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TopBar.BackgroundTransparency = 0.7
    TopBar.BorderSizePixel = 0
    TopBar.Parent = KeyFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 16)
    TopCorner.Parent = TopBar
    
    local TopCover = Instance.new("Frame")
    TopCover.Size = UDim2.new(1, 0, 0, 16)
    TopCover.Position = UDim2.new(0, 0, 1, -16)
    TopCover.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TopCover.BackgroundTransparency = 0.7
    TopCover.BorderSizePixel = 0
    TopCover.Parent = TopBar
    
    local Logo = Instance.new("TextLabel")
    Logo.Size = UDim2.new(1, 0, 0, 50)
    Logo.Position = UDim2.new(0, 0, 0, 20)
    Logo.BackgroundTransparency = 1
    Logo.Text = "ANTC HUB"
    Logo.Font = Enum.Font.GothamBold
    Logo.TextSize = 38
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.Parent = KeyFrame
    
    local Version = Instance.new("TextLabel")
    Version.Size = UDim2.new(1, 0, 0, 20)
    Version.Position = UDim2.new(0, 0, 0, 70)
    Version.BackgroundTransparency = 1
    Version.Text = "ULTIMATE EDITION"
    Version.Font = Enum.Font.Gotham
    Version.TextSize = 12
    Version.TextColor3 = Color3.fromRGB(220, 220, 220)
    Version.Parent = KeyFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0, 360, 0, 48)
    KeyBox.Position = UDim2.new(0.5, -180, 0, 130)
    KeyBox.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
    KeyBox.BackgroundTransparency = 0.2
    KeyBox.BorderSizePixel = 0
    KeyBox.PlaceholderText = "Enter License Key..."
    KeyBox.Text = ""
    KeyBox.Font = Enum.Font.GothamBold
    KeyBox.TextSize = 15
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    KeyBox.Parent = KeyFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 10)
    BoxCorner.Parent = KeyBox
    
    local BoxStroke = Instance.new("UIStroke")
    BoxStroke.Color = Color3.fromRGB(138, 43, 226)
    BoxStroke.Thickness = 1.5
    BoxStroke.Transparency = 0.5
    BoxStroke.Parent = KeyBox
    
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 180, 0, 48)
    SubmitBtn.Position = UDim2.new(0.5, -90, 0, 210)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    SubmitBtn.BackgroundTransparency = 0.1
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.Text = "VERIFY"
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 16
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Parent = KeyFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = SubmitBtn
    
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 180, 0, 38)
    GetKeyBtn.Position = UDim2.new(0.5, -90, 0, 268)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    GetKeyBtn.BackgroundTransparency = 0.15
    GetKeyBtn.BorderSizePixel = 0
    GetKeyBtn.Text = "GET BASIC KEY (11H)"
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextSize = 13
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyBtn.Parent = KeyFrame
    
    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 10)
    GetKeyCorner.Parent = GetKeyBtn
    
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Size = UDim2.new(0, 0, 0, 4)
    LoadingBar.Position = UDim2.new(0, 0, 1, -4)
    LoadingBar.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Visible = false
    LoadingBar.Parent = GetKeyBtn
    
    local LoadingBarCorner = Instance.new("UICorner")
    LoadingBarCorner.CornerRadius = UDim.new(0, 10)
    LoadingBarCorner.Parent = LoadingBar
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        GetKeyBtn.Text = "GENERATING KEY..."
        LoadingBar.Visible = true
        LoadingBar.Size = UDim2.new(0, 0, 0, 4)
        
        local colorTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        })
        colorTween:Play()
        
        CreateNotification("ANTC HUB", "🔑 Generating secure key, please wait...", 3, Color3.fromRGB(100, 150, 255))
        
        local loadingTween = TweenService:Create(LoadingBar, TweenInfo.new(5, Enum.EasingStyle.Linear), {
            Size = UDim2.new(1, 0, 0, 4)
        })
        loadingTween:Play()
        
        local loadingDots = 0
        local loadingConnection
        loadingConnection = RunService.Heartbeat:Connect(function()
            loadingDots = (loadingDots + 1) % 4
            local dots = string.rep(".", loadingDots)
            GetKeyBtn.Text = "GENERATING KEY" .. dots
        end)
        
        task.wait(5)
        
        if loadingConnection then
            loadingConnection:Disconnect()
        end
        
        local randomKey = GenerateRandomKey()
        KeyBox.Text = randomKey
        
        local successTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        })
        successTween:Play()
        GetKeyBtn.Text = "✓ KEY GENERATED!"
        
        task.wait(1)
        
        LoadingBar.Visible = false
        GetKeyBtn.Text = "GET BASIC KEY (11H)"
        local resetTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        })
        resetTween:Play()
        
        CreateNotification("ANTC HUB", "✅ Basic Script Key Generated!\n" .. randomKey .. " (Valid for 11 hours)", 8, Color3.fromRGB(0, 255, 150))
        
        SendKeyTrackingWebhook(randomKey)
    end)
    
    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -30, 0, 30)
    InfoText.Position = UDim2.new(0, 15, 1, -35)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = "ANTC & APIS Developer Keys Available\nDev: ANTC-DEVELOPER-2025 | APIS-DEVELOPER-2025"
    InfoText.Font = Enum.Font.Gotham
    InfoText.TextSize = 8
    InfoText.TextColor3 = Color3.fromRGB(140, 140, 160)
    InfoText.TextWrapped = true
    InfoText.Parent = KeyFrame
    
    SubmitBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text
        
        if key == "" then
            CreateNotification("ANTC HUB", "Please enter a license key!", 3, Color3.fromRGB(255, 50, 50))
            return
        end
        
        CreateNotification("ANTC HUB", "Validating license key...", 3, Color3.fromRGB(100, 150, 255))
        
        local isValid, keyType, webhookData = IsKeyValid(key)
        
        if isValid then
            KeyVerified = true
            
            if keyType == "DEVELOPMENT" then
                UserStatus = "DEVELOPER"
                UserTier = 3
                local devMessage = "DEVELOPER ACCESS GRANTED!"
                if webhookData and webhookData.isLifetime then
                    devMessage = devMessage .. " (Lifetime)"
                    IsLifetimeKey = true
                end
                if webhookData and webhookData.dev then
                    devMessage = devMessage .. " - " .. webhookData.dev
                end
                
                Settings.CustomNameTag = "Owners ANTC Hub"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Owners ANTC Hub")
                    CreateNotification("ANTC HUB", "✅ Developer name tag applied: Owners ANTC Hub", 3, Color3.fromRGB(0, 255, 150))
                end)
                
                CreateNotification("ANTC HUB", devMessage .. " Full access to all features.", 6, Color3.fromRGB(0, 255, 150))
                task.spawn(function()
                    task.wait(1)
                    SendDeveloperJoinNotification()
                end)
            elseif keyType == "PREMIUM" then
                UserStatus = "PREMIUM"
                UserTier = 2
                if webhookData and webhookData.isLifetime then
                    IsLifetimeKey = true
                end
                local lifetimeText = webhookData and webhookData.isLifetime and " (Lifetime)" or ""
                CreateNotification("ANTC HUB", "Premium access granted!" .. lifetimeText, 5, Color3.fromRGB(255, 215, 0))
            elseif keyType == "FRIEND" then
                UserStatus = "FRIEND"
                UserTier = 2
                IsLifetimeKey = true
                CreateNotification("ANTC HUB", "Welcome Friend! Premium access granted.", 5, Color3.fromRGB(255, 100, 200))
            elseif keyType == "BASIC" then
                UserStatus = "BASIC SCRIPT"
                UserTier = 1
                IsLifetimeKey = false
                if GeneratedKeys[key] then
                    local expiryTime = GeneratedKeys[key].expiresAt
                    local remainingHours = math.floor((expiryTime - os.time()) / 3600)
                    CreateNotification("ANTC HUB", "Basic Script access! Valid for " .. remainingHours .. " hours.", 5, Color3.fromRGB(100, 200, 255))
                else
                    CreateNotification("ANTC HUB", "Basic access granted!", 5, Color3.fromRGB(100, 200, 255))
                end
            else
                UserStatus = "GUEST"
                UserTier = 1
                IsLifetimeKey = false
                CreateNotification("ANTC HUB", "Guest access granted! Limited features.", 5, Color3.fromRGB(100, 150, 255))
            end
            
            TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            task.wait(0.5)
            KeyFrame:Destroy()
            
            local LoadingFrame = Instance.new("Frame")
            LoadingFrame.Name = "LoadingFrame"
            LoadingFrame.Size = UDim2.new(0, 0, 0, 0)
            LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
            LoadingFrame.BackgroundTransparency = 0.02
            LoadingFrame.BorderSizePixel = 0
            LoadingFrame.Parent = ScreenGui
            
            local LoadCorner = Instance.new("UICorner")
            LoadCorner.CornerRadius = UDim.new(0, 18)
            LoadCorner.Parent = LoadingFrame
            
            local LoadStroke = Instance.new("UIStroke")
            LoadStroke.Color = Color3.fromRGB(138, 43, 226)
            LoadStroke.Thickness = 2.5
            LoadStroke.Transparency = 0.15
            LoadStroke.Parent = LoadingFrame
            
            local LoadGlow = Instance.new("ImageLabel")
            LoadGlow.Size = UDim2.new(1, 40, 1, 40)
            LoadGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
            LoadGlow.AnchorPoint = Vector2.new(0.5, 0.5)
            LoadGlow.BackgroundTransparency = 1
            LoadGlow.Image = "rbxassetid://5554236805"
            LoadGlow.ImageColor3 = Color3.fromRGB(138, 43, 226)
            LoadGlow.ImageTransparency = 0.85
            LoadGlow.Parent = LoadingFrame
            
            local LoadingIcon = Instance.new("TextLabel")
            LoadingIcon.Size = UDim2.new(0, 50, 0, 50)
            LoadingIcon.Position = UDim2.new(0.5, 0, 0, 25)
            LoadingIcon.AnchorPoint = Vector2.new(0.5, 0)
            LoadingIcon.BackgroundTransparency = 1
            LoadingIcon.Text = "[!]"
            LoadingIcon.Font = Enum.Font.GothamBold
            LoadingIcon.TextSize = 38
            LoadingIcon.TextColor3 = Color3.fromRGB(138, 43, 226)
            LoadingIcon.Parent = LoadingFrame
            
            local LoadingText = Instance.new("TextLabel")
            LoadingText.Size = UDim2.new(1, -40, 0, 35)
            LoadingText.Position = UDim2.new(0, 20, 0, 80)
            LoadingText.BackgroundTransparency = 1
            LoadingText.Text = "LOADING ANTC HUB"
            LoadingText.Font = Enum.Font.GothamBold
            LoadingText.TextSize = 20
            LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
            LoadingText.Parent = LoadingFrame
            
            local LoadingSubText = Instance.new("TextLabel")
            LoadingSubText.Size = UDim2.new(1, -40, 0, 20)
            LoadingSubText.Position = UDim2.new(0, 20, 0, 115)
            LoadingSubText.BackgroundTransparency = 1
            LoadingSubText.Text = "Professional Executor Hub"
            LoadingSubText.Font = Enum.Font.Gotham
            LoadingSubText.TextSize = 13
            LoadingSubText.TextColor3 = Color3.fromRGB(180, 180, 200)
            LoadingSubText.Parent = LoadingFrame
            
            local LoadingBarBG = Instance.new("Frame")
            LoadingBarBG.Size = UDim2.new(0, 280, 0, 8)
            LoadingBarBG.Position = UDim2.new(0.5, 0, 0, 150)
            LoadingBarBG.AnchorPoint = Vector2.new(0.5, 0)
            LoadingBarBG.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            LoadingBarBG.BorderSizePixel = 0
            LoadingBarBG.Parent = LoadingFrame
            
            local BarBGCorner = Instance.new("UICorner")
            BarBGCorner.CornerRadius = UDim.new(1, 0)
            BarBGCorner.Parent = LoadingBarBG
            
            local LoadingBar = Instance.new("Frame")
            LoadingBar.Size = UDim2.new(0, 0, 1, 0)
            LoadingBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            LoadingBar.BorderSizePixel = 0
            LoadingBar.Parent = LoadingBarBG
            
            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = LoadingBar
            
            local BarGradient = Instance.new("UIGradient")
            BarGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 80, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
            }
            BarGradient.Parent = LoadingBar
            
            local PercentText = Instance.new("TextLabel")
            PercentText.Size = UDim2.new(1, 0, 0, 20)
            PercentText.Position = UDim2.new(0, 0, 0, 168)
            PercentText.BackgroundTransparency = 1
            PercentText.Text = "0%"
            PercentText.Font = Enum.Font.GothamBold
            PercentText.TextSize = 14
            PercentText.TextColor3 = Color3.fromRGB(138, 43, 226)
            PercentText.Parent = LoadingFrame
            
            TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 340, 0, 210)
            }):Play()
            
            task.spawn(function()
                for i = 0, 360, 6 do
                    LoadingIcon.Rotation = i
                    task.wait(0.01)
                end
            end)
            
            for i = 0, 100, 2 do
                TweenService:Create(LoadingBar, TweenInfo.new(0.03, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(i/100, 0, 1, 0)
                }):Play()
                PercentText.Text = i .. "%"
                task.wait(0.015)
            end
            
            task.wait(0.2)
            
            TweenService:Create(LoadingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.4)
            LoadingFrame:Destroy()
            
            CreateMainGUI()
        else
            CreateNotification("ANTC HUB", keyType or "Invalid key! Please try again.", 4, Color3.fromRGB(255, 50, 50))
            KeyBox.Text = ""
        end
    end)
    
    KeyFrame.Size = UDim2.new(0, 0, 0, 0)
    KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(KeyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 420, 0, 360),
        Position = UDim2.new(0.5, -210, 0.5, -180)
    }):Play()
end

function GenerateRandomKey()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomPart1 = ""
    local randomPart2 = ""
    local randomPart3 = ""
    
    for i = 1, 4 do
        local rand = math.random(1, #chars)
        randomPart1 = randomPart1 .. chars:sub(rand, rand)
    end
    
    for i = 1, 4 do
        local rand = math.random(1, #chars)
        randomPart2 = randomPart2 .. chars:sub(rand, rand)
    end
    
    for i = 1, 4 do
        local rand = math.random(1, #chars)
        randomPart3 = randomPart3 .. chars:sub(rand, rand)
    end
    
    local key = "ANTC-APIS-" .. randomPart1 .. "-" .. randomPart2 .. "-" .. randomPart3
    local currentTime = os.time()
    local expiryTime = currentTime + (11 * 3600)
    
    GeneratedKeys[key] = {
        createdAt = currentTime,
        expiresAt = expiryTime,
        keyType = "BASIC"
    }
    
    KeyExpiryTime = expiryTime
    
    return key
end

function IsKeyValid(key)
    local DeveloperKeys = {
        ["ANTC-DEVELOPER-MASTER-KEY"] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Development APIS"},
        ["APIS-DEVELOPER-MASTER-KEY"] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Development APIS"},
        ["ANTC-PREMIUM-LIFETIME-KEY"] = {tier = "PREMIUM", isLifetime = true, dev = "Development APIS"},
        ["APIS-PREMIUM-LIFETIME-KEY"] = {tier = "PREMIUM", isLifetime = true, dev = "Development APIS"},
        ["ANTC-DEVELOPER-2025"] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Development APIS"},
        ["APIS-DEVELOPER-2025"] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Development APIS"}
    }
    
    if DeveloperKeys[key] then
        local keyData = DeveloperKeys[key]
        return true, keyData.tier, {
            valid = true,
            tier = keyData.tier,
            isLifetime = keyData.isLifetime,
            message = "Developer access granted"
        }
    end
    
    if GeneratedKeys[key] then
        local currentTime = os.time()
        if currentTime <= GeneratedKeys[key].expiresAt then
            KeyExpiryTime = GeneratedKeys[key].expiresAt
            return true, "BASIC", nil
        else
            return false, "Key expired - Get new key (11 hours limit)", nil
        end
    end
    
    local success, result = pcall(function()
        local requestData = {
            key = key,
            userId = tostring(Player.UserId),
            hwid = game:GetService("RbxAnalyticsService"):GetClientId()
        }
        
        local response = HttpService:PostAsync(
            WEBHOOK_URL,
            HttpService:JSONEncode(requestData),
            Enum.HttpContentType.ApplicationJson,
            false
        )
        
        return HttpService:JSONDecode(response)
    end)
    
    if success and result then
        if result.valid then
            local tier = result.tier or "GUEST"
            local isLifetime = result.isLifetime or false
            
            if not isLifetime and result.expiresAt then
                KeyExpiryTime = result.expiresAt
            elseif not isLifetime and result.validFor then
                KeyExpiryTime = os.time() + result.validFor
            end
            
            return true, tier, result
        else
            return false, result.message or "Invalid key", nil
        end
    else
        warn("Webhook validation error:", result)
        return false, "Connection error - Check webhook server", nil
    end
end

function GetMaxCheckpointSlots()
    if UserStatus == "DEVELOPER" then
        return 99999999
    elseif UserStatus == "PREMIUM" then
        return 50
    elseif UserStatus == "FRIEND" then
        return 147
    else
        return 5
    end
end

function SaveCheckpoint(checkpointName, position)
    local maxSlots = GetMaxCheckpointSlots()
    if #Checkpoints >= maxSlots then
        CreateNotification("ANTC HUB", "Checkpoint limit reached! (" .. maxSlots .. " slots)", 3, Color3.fromRGB(255, 100, 100))
        return false
    end
    
    table.insert(Checkpoints, {
        name = checkpointName,
        position = position,
        timestamp = os.time()
    })
    
    if writefile then
        pcall(function()
            writefile("ANTC_Checkpoints.json", HttpService:JSONEncode(Checkpoints))
        end)
    end
    
    return true
end

function DeleteCheckpoint(index)
    table.remove(Checkpoints, index)
    if writefile then
        pcall(function()
            writefile("ANTC_Checkpoints.json", HttpService:JSONEncode(Checkpoints))
        end)
    end
end

function TeleportToCheckpoint(index)
    local checkpoint = Checkpoints[index]
    if checkpoint and checkpoint.position then
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = checkpoint.position
            CreateNotification("ANTC HUB", "Teleported to: " .. checkpoint.name, 3, Color3.fromRGB(0, 255, 150))
        end
    end
end

function LoadCheckpoints()
    if isfile and readfile then
        local success, fileExists = pcall(function()
            return isfile("ANTC_Checkpoints.json")
        end)
        
        if success and fileExists then
            local readSuccess, data = pcall(function()
                return HttpService:JSONDecode(readfile("ANTC_Checkpoints.json"))
            end)
            if readSuccess and data then
                Checkpoints = data
            end
        end
    end
end

function SendKeyTrackingWebhook(key)
    if KEY_TRACKING_WEBHOOK == "" then return end
    
    local hwid = "Unknown"
    pcall(function()
        hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    
    local embed = {
        title = "🔑 Basic Key Generated",
        description = "A new basic script key has been generated",
        color = 5814783,
        fields = {
            {name = "Key", value = "`" .. key .. "`", inline = false},
            {name = "Player", value = Player.Name, inline = true},
            {name = "User ID", value = tostring(Player.UserId), inline = true},
            {name = "HWID", value = "`" .. hwid .. "`", inline = false},
            {name = "Valid Duration", value = "11 hours", inline = true},
            {name = "Time Generated", value = os.date("%H:%M:%S - %d/%m/%Y", os.time()), inline = false},
            {name = "Game", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown", inline = false}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local success = pcall(function()
        HttpService:PostAsync(
            KEY_TRACKING_WEBHOOK,
            HttpService:JSONEncode({
                username = "ANTC Hub Key Tracker",
                embeds = {embed}
            }),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
    
    if success then
        print("[ANTC HUB] Key tracking webhook sent successfully")
    else
        warn("[ANTC HUB] Failed to send key tracking webhook")
    end
end

function SendDeveloperWebhook(message)
    if DeveloperActivityWebhook == "" then return end
    
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
    local tierEmoji = "👤"
    if UserStatus == "DEVELOPER" then
        tierEmoji = "👨‍💻"
    elseif UserStatus == "PREMIUM" then
        tierEmoji = "⭐"
    elseif UserStatus == "FRIEND" then
        tierEmoji = "👥"
    elseif UserStatus == "BASIC" then
        tierEmoji = "🔰"
    end
    
    local embed = {
        title = "⚡ User Activity - " .. UserStatus,
        description = message,
        color = 5814783,
        fields = {
            {name = tierEmoji .. " Player", value = Player.Name, inline = true},
            {name = "🆔 User ID", value = tostring(Player.UserId), inline = true},
            {name = "🎯 Tier", value = UserStatus, inline = true},
            {name = "🎮 Game", value = gameName, inline = false},
            {name = "⏰ Time", value = os.date("%H:%M:%S - %d/%m/%Y", os.time()), inline = true}
        },
        footer = {
            text = "ANTC Hub Activity Monitor"
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local success = pcall(function()
        HttpService:PostAsync(
            DeveloperActivityWebhook,
            HttpService:JSONEncode({
                username = "ANTC Hub Activity Monitor",
                avatar_url = "https://cdn.discordapp.com/emojis/123456789.png",
                embeds = {embed}
            }),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
    
    if success then
        print("[ANTC HUB] Activity logged:", UserStatus, "-", message)
    end
end

function SendDeveloperJoinNotification()
    if DeveloperActivityWebhook == "" or UserStatus ~= "DEVELOPER" then return end
    
    local activeFeatures = {}
    if Settings.Fly then table.insert(activeFeatures, "Fly") end
    if Settings.Speed then table.insert(activeFeatures, "Speed") end
    if Settings.Noclip then table.insert(activeFeatures, "Noclip") end
    if Settings.GodMode then table.insert(activeFeatures, "God Mode") end
    
    local featuresText = #activeFeatures > 0 and table.concat(activeFeatures, ", ") or "None"
    
    local embed = {
        title = " Developer Online!",
        description = "**Developer has joined the game**",
        color = 3066993,
        fields = {
            {name = " Player", value = Player.Name, inline = true},
            {name = " User ID", value = tostring(Player.UserId), inline = true},
            {name = " Map/Place", value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown", inline = false},
            {name = " Join Time", value = os.date("%H:%M:%S", os.time()), inline = true},
            {name = " Active Features", value = featuresText, inline = false}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    pcall(function()
        HttpService:PostAsync(
            DeveloperActivityWebhook,
            HttpService:JSONEncode({
                username = "ANTC Hub Developer Monitor",
                embeds = {embed}
            }),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
end

function ApplyNameTag(customText)
    local char = Player.Character
    if not char then return end
    
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    for _, obj in pairs(head:GetChildren()) do
        if obj:IsA("BillboardGui") and obj.Name == "CustomNameTag" then
            obj:Destroy()
        end
    end
    
    if not customText or customText == "" then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CustomNameTag"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 1000
    billboard.Parent = head
    
    local tagFrame = Instance.new("Frame")
    tagFrame.Size = UDim2.new(1, 0, 1, 0)
    tagFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    tagFrame.BackgroundTransparency = 0.1
    tagFrame.BorderSizePixel = 0
    tagFrame.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = tagFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(138, 43, 226)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = tagFrame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 1, 0)
    textLabel.Position = UDim2.new(0, 5, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = customText
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 16
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Parent = tagFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    gradient.Parent = textLabel
end

function ClearNameTag()
    local char = Player.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head then
            for _, obj in pairs(head:GetChildren()) do
                if obj:IsA("BillboardGui") and obj.Name == "CustomNameTag" then
                    obj:Destroy()
                end
            end
            Settings.ShowNameTag = false
            Settings.CustomNameTag = ""
            SaveSettings()
            CreateNotification("ANTC HUB", "Name tag cleared!", 3, Color3.fromRGB(0, 255, 150))
        end
    end
end

function StartFly()
    if FlyEnabled then return end
    
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        CreateNotification("ANTC HUB", "Fly mode only available on PC! Mobile not supported yet.", 4, Color3.fromRGB(255, 100, 100))
        return
    end
    
    FlyEnabled = true
    
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        FlyEnabled = false
        return
    end
    
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChild("Humanoid")
    
    local bg = Instance.new("BodyGyro")
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp
    
    local bv = Instance.new("BodyVelocity")
    bv.velocity = Vector3.new(0, 0, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Parent = hrp
    
    FlyConnection = RunService.Heartbeat:Connect(function()
        if not FlyEnabled or not char or not char.Parent or not hrp or not hrp.Parent then
            StopFly()
            return
        end
        
        local camera = Workspace.CurrentCamera
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + (camera.CFrame.LookVector * Settings.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - (camera.CFrame.LookVector * Settings.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - (camera.CFrame.RightVector * Settings.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + (camera.CFrame.RightVector * Settings.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, Settings.FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, Settings.FlySpeed, 0)
        end
        
        bv.velocity = moveDirection
        bg.CFrame = camera.CFrame
        
        if humanoid then
            humanoid.PlatformStand = true
        end
    end)
    
    CreateNotification("ANTC HUB", "Fly mode enabled! Use WASD + Space/Shift (PC Only)", 4, Color3.fromRGB(0, 255, 150))
    SendDeveloperWebhook("[FLY] Activated Fly Mode")
end

function StopFly()
    FlyEnabled = false
    
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    local char = Player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        
        if hrp then
            for _, obj in pairs(hrp:GetChildren()) do
                if obj:IsA("BodyGyro") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
        end
        
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
    
    CreateNotification("ANTC HUB", "Fly mode disabled", 3, Color3.fromRGB(255, 150, 50))
    SendDeveloperWebhook("[FLY] Deactivated Fly Mode")
end

function StartAutoClick()
    if AutoClickConnection then
        AutoClickConnection:Disconnect()
    end
    
    AutoClickConnection = task.spawn(function()
        while Settings.AutoClick do
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.001)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            task.wait(Settings.AutoClickInterval / 1000)
        end
    end)
end

function StopAutoClick()
    if AutoClickConnection then
        task.cancel(AutoClickConnection)
        AutoClickConnection = nil
    end
end

function StartAirWalk()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if AirWalkPart then
        AirWalkPart:Destroy()
    end
    
    AirWalkPart = Instance.new("Part")
    AirWalkPart.Size = Vector3.new(6, 0.5, 6)
    AirWalkPart.Transparency = 0.7
    AirWalkPart.Anchored = true
    AirWalkPart.CanCollide = true
    AirWalkPart.Material = Enum.Material.Neon
    AirWalkPart.BrickColor = BrickColor.new("Bright blue")
    AirWalkPart.Parent = Workspace
    
    RunService.Heartbeat:Connect(function()
        if Settings.AirWalk and char and char:FindFirstChild("HumanoidRootPart") then
            AirWalkPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
        elseif AirWalkPart then
            AirWalkPart:Destroy()
            AirWalkPart = nil
        end
    end)
end

function StopAirWalk()
    if AirWalkPart then
        AirWalkPart:Destroy()
        AirWalkPart = nil
    end
end

function CreateAvatarCopyUI()
    local SelectorFrame = Instance.new("Frame")
    SelectorFrame.Size = UDim2.new(0, 450, 0, 550)
    SelectorFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    SelectorFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    SelectorFrame.BackgroundTransparency = 0.05
    SelectorFrame.BorderSizePixel = 0
    SelectorFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = SelectorFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = SelectorFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Copy Player Avatar"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = SelectorFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = SelectorFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        SelectorFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = SelectorFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollFrame
    
    ScrollFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        local PlayerBtn = Instance.new("TextButton")
        PlayerBtn.Size = UDim2.new(1, 0, 0, 60)
        PlayerBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        PlayerBtn.BackgroundTransparency = 0.15
        PlayerBtn.BorderSizePixel = 0
        PlayerBtn.Text = ""
        PlayerBtn.Parent = ScrollFrame
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 10)
        BtnCorner.Parent = PlayerBtn
        
        local BtnStroke = Instance.new("UIStroke")
        BtnStroke.Color = Color3.fromRGB(138, 43, 226)
        BtnStroke.Thickness = 1.5
        BtnStroke.Transparency = 0.6
        BtnStroke.Parent = PlayerBtn
        
        local PlayerName = Instance.new("TextLabel")
        PlayerName.Size = UDim2.new(1, -20, 1, 0)
        PlayerName.Position = UDim2.new(0, 10, 0, 0)
        PlayerName.BackgroundTransparency = 1
        PlayerName.Text = targetPlayer.Name .. (targetPlayer == Player and " (You)" or "")
        PlayerName.Font = Enum.Font.GothamBold
        PlayerName.TextSize = 16
        PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerName.TextXAlignment = Enum.TextXAlignment.Left
        PlayerName.Parent = PlayerBtn
        
        PlayerBtn.MouseButton1Click:Connect(function()
            if not targetPlayer.Character then
                CreateNotification("ANTC HUB", targetPlayer.Name .. " has no character!", 3, Color3.fromRGB(255, 100, 100))
                return
            end
            
            local targetChar = targetPlayer.Character
            local myChar = Player.Character
            if not myChar then return end
            
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            local myHumanoid = myChar:FindFirstChild("Humanoid")
            
            if targetHumanoid and myHumanoid then
                for _, accessory in pairs(myChar:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        accessory:Destroy()
                    end
                end
                
                for _, accessory in pairs(targetChar:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        local newAccessory = accessory:Clone()
                        newAccessory.Parent = myChar
                    end
                end
                
                local targetDesc = targetHumanoid:GetAppliedDescription()
                myHumanoid:ApplyDescription(targetDesc)
                
                CreateNotification("ANTC HUB", "Copied avatar from " .. targetPlayer.Name .. " with accessories!", 4, Color3.fromRGB(0, 255, 150))
                SendDeveloperWebhook("📋 Copied avatar from: " .. targetPlayer.Name)
                SelectorFrame:Destroy()
            end
        end)
    end
end

function CreatePlayerSelector(mode)
    local SelectorFrame = Instance.new("Frame")
    SelectorFrame.Size = UDim2.new(0, 450, 0, 550)
    SelectorFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    SelectorFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    SelectorFrame.BackgroundTransparency = 0.05
    SelectorFrame.BorderSizePixel = 0
    SelectorFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = SelectorFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = SelectorFrame
    
    local modeText = mode == "teleport" and "Teleport to Player" or 
                     mode == "bring" and "Bring Player to You" or
                     mode == "kick" and "Kick Player" or
                     mode == "fling" and "Fling Player" or
                     mode == "spectate" and "Spectate Player" or
                     mode == "ban" and "Ban Player" or "Select Player"
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = modeText
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = SelectorFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = SelectorFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        SelectorFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = SelectorFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollFrame
    
    ScrollFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= Player or mode == "spectate" then
            local PlayerBtn = Instance.new("TextButton")
            PlayerBtn.Size = UDim2.new(1, 0, 0, 60)
            PlayerBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
            PlayerBtn.BackgroundTransparency = 0.15
            PlayerBtn.BorderSizePixel = 0
            PlayerBtn.Text = ""
            PlayerBtn.Parent = ScrollFrame
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 10)
            BtnCorner.Parent = PlayerBtn
            
            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Color = Color3.fromRGB(138, 43, 226)
            BtnStroke.Thickness = 1.5
            BtnStroke.Transparency = 0.6
            BtnStroke.Parent = PlayerBtn
            
            local PlayerName = Instance.new("TextLabel")
            PlayerName.Size = UDim2.new(1, -20, 1, 0)
            PlayerName.Position = UDim2.new(0, 10, 0, 0)
            PlayerName.BackgroundTransparency = 1
            PlayerName.Text = targetPlayer.Name .. (targetPlayer == Player and " (You)" or "")
            PlayerName.Font = Enum.Font.GothamBold
            PlayerName.TextSize = 16
            PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerName.TextXAlignment = Enum.TextXAlignment.Left
            PlayerName.Parent = PlayerBtn
            
            PlayerBtn.MouseButton1Click:Connect(function()
                if mode == "teleport" then
                    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local myChar = Player.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            myChar.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                            CreateNotification("ANTC HUB", "Teleported to " .. targetPlayer.Name, 3, Color3.fromRGB(0, 255, 150))
                            SendDeveloperWebhook("📍 Teleported to: " .. targetPlayer.Name)
                        end
                    end
                elseif mode == "bring" then
                    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local myChar = Player.Character
                        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                            targetPlayer.Character.HumanoidRootPart.CFrame = myChar.HumanoidRootPart.CFrame
                            CreateNotification("ANTC HUB", "Brought " .. targetPlayer.Name .. " to you", 3, Color3.fromRGB(0, 255, 150))
                            SendDeveloperWebhook("🔗 Brought player: " .. targetPlayer.Name)
                        end
                    end
                elseif mode == "kick" or mode == "ban" then
                    if BannedPlayers then
                        table.insert(BannedPlayers, targetPlayer.UserId)
                    end
                    targetPlayer:Kick("You have been " .. mode .. "ed by " .. Player.Name)
                    CreateNotification("ANTC HUB", targetPlayer.Name .. " has been " .. mode .. "ed", 3, Color3.fromRGB(255, 100, 100))
                    SendDeveloperWebhook("🚫 " .. mode:upper() .. " player: " .. targetPlayer.Name)
                elseif mode == "fling" then
                    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local bv = Instance.new("BodyVelocity")
                        bv.MaxForce = Vector3.new(99999, 99999, 99999)
                        bv.Velocity = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100))
                        bv.Parent = targetPlayer.Character.HumanoidRootPart
                        task.wait(0.5)
                        bv:Destroy()
                        CreateNotification("ANTC HUB", "Flung " .. targetPlayer.Name, 3, Color3.fromRGB(255, 150, 50))
                        SendDeveloperWebhook("💨 Flung player: " .. targetPlayer.Name)
                    end
                elseif mode == "spectate" then
                    Workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
                    CurrentSpectateTarget = targetPlayer
                    CreateNotification("ANTC HUB", "Spectating " .. targetPlayer.Name .. " - Press ESC to stop", 4, Color3.fromRGB(100, 150, 255))
                    SendDeveloperWebhook("👁️ Spectating: " .. targetPlayer.Name)
                end
                SelectorFrame:Destroy()
            end)
        end
    end
end

function CreateMusicPlayer()
    local MusicFrame = Instance.new("Frame")
    MusicFrame.Size = UDim2.new(0, 450, 0, 300)
    MusicFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MusicFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    MusicFrame.BackgroundTransparency = 0.05
    MusicFrame.BorderSizePixel = 0
    MusicFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = MusicFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = MusicFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🎵 Music Player"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MusicFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = MusicFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        MusicFrame:Destroy()
    end)
    
    local MusicIDBox = Instance.new("TextBox")
    MusicIDBox.Size = UDim2.new(1, -40, 0, 50)
    MusicIDBox.Position = UDim2.new(0, 20, 0, 85)
    MusicIDBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    MusicIDBox.BackgroundTransparency = 0.1
    MusicIDBox.BorderSizePixel = 0
    MusicIDBox.PlaceholderText = "Enter Audio/Music ID..."
    MusicIDBox.Text = ""
    MusicIDBox.Font = Enum.Font.Gotham
    MusicIDBox.TextSize = 15
    MusicIDBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    MusicIDBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    MusicIDBox.Parent = MusicFrame
    
    local MusicIDCorner = Instance.new("UICorner")
    MusicIDCorner.CornerRadius = UDim.new(0, 10)
    MusicIDCorner.Parent = MusicIDBox
    
    local VolumeSlider = Instance.new("TextLabel")
    VolumeSlider.Size = UDim2.new(1, -40, 0, 30)
    VolumeSlider.Position = UDim2.new(0, 20, 0, 155)
    VolumeSlider.BackgroundTransparency = 1
    VolumeSlider.Text = "Volume: 50%"
    VolumeSlider.Font = Enum.Font.GothamBold
    VolumeSlider.TextSize = 14
    VolumeSlider.TextColor3 = Color3.fromRGB(200, 200, 220)
    VolumeSlider.TextXAlignment = Enum.TextXAlignment.Left
    VolumeSlider.Parent = MusicFrame
    
    local VolumeValue = 0.5
    
    local PlayBtn = Instance.new("TextButton")
    PlayBtn.Size = UDim2.new(0.48, -5, 0, 50)
    PlayBtn.Position = UDim2.new(0, 20, 0, 215)
    PlayBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    PlayBtn.BackgroundTransparency = 0.15
    PlayBtn.BorderSizePixel = 0
    PlayBtn.Text = "▶ PLAY"
    PlayBtn.Font = Enum.Font.GothamBold
    PlayBtn.TextSize = 16
    PlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayBtn.Parent = MusicFrame
    
    local PlayCorner = Instance.new("UICorner")
    PlayCorner.CornerRadius = UDim.new(0, 10)
    PlayCorner.Parent = PlayBtn
    
    local StopBtn = Instance.new("TextButton")
    StopBtn.Size = UDim2.new(0.48, -5, 0, 50)
    StopBtn.Position = UDim2.new(0.52, 0, 0, 215)
    StopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    StopBtn.BackgroundTransparency = 0.15
    StopBtn.BorderSizePixel = 0
    StopBtn.Text = "⏹ STOP"
    StopBtn.Font = Enum.Font.GothamBold
    StopBtn.TextSize = 16
    StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    StopBtn.Parent = MusicFrame
    
    local StopCorner = Instance.new("UICorner")
    StopCorner.CornerRadius = UDim.new(0, 10)
    StopCorner.Parent = StopBtn
    
    PlayBtn.MouseButton1Click:Connect(function()
        local musicId = tonumber(MusicIDBox.Text)
        if musicId then
            if Workspace:FindFirstChild("ANTC_Music") then
                Workspace.ANTC_Music:Destroy()
            end
            
            local sound = Instance.new("Sound")
            sound.Name = "ANTC_Music"
            sound.SoundId = "rbxassetid://" .. musicId
            sound.Volume = VolumeValue
            sound.Looped = true
            sound.Parent = Workspace
            sound:Play()
            
            CreateNotification("ANTC HUB", "🎵 Music playing! ID: " .. musicId, 3, Color3.fromRGB(0, 255, 150))
            SendDeveloperWebhook("🎵 Playing music ID: " .. musicId)
            MusicFrame:Destroy()
        else
            CreateNotification("ANTC HUB", "Please enter a valid Audio ID!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
    
    StopBtn.MouseButton1Click:Connect(function()
        if Workspace:FindFirstChild("ANTC_Music") then
            Workspace.ANTC_Music:Destroy()
            CreateNotification("ANTC HUB", "🎵 Music stopped!", 3, Color3.fromRGB(255, 100, 100))
            SendDeveloperWebhook("🔇 Stopped music")
        else
            CreateNotification("ANTC HUB", "No music is playing", 3, Color3.fromRGB(255, 150, 50))
        end
        MusicFrame:Destroy()
    end)
end

function CreateCheckpointDialog()
    local DialogFrame = Instance.new("Frame")
    DialogFrame.Size = UDim2.new(0, 400, 0, 200)
    DialogFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    DialogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    DialogFrame.BackgroundTransparency = 0.05
    DialogFrame.BorderSizePixel = 0
    DialogFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = DialogFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = DialogFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -30, 0, 40)
    Title.Position = UDim2.new(0, 15, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Create New Checkpoint"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = DialogFrame
    
    local NameBox = Instance.new("TextBox")
    NameBox.Size = UDim2.new(1, -30, 0, 45)
    NameBox.Position = UDim2.new(0, 15, 0, 65)
    NameBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    NameBox.BackgroundTransparency = 0.1
    NameBox.BorderSizePixel = 0
    NameBox.PlaceholderText = "Enter checkpoint name..."
    NameBox.Text = ""
    NameBox.Font = Enum.Font.Gotham
    NameBox.TextSize = 15
    NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    NameBox.Parent = DialogFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 10)
    BoxCorner.Parent = NameBox
    
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(0.48, 0, 0, 45)
    SaveBtn.Position = UDim2.new(0, 15, 0, 130)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    SaveBtn.BackgroundTransparency = 0.1
    SaveBtn.BorderSizePixel = 0
    SaveBtn.Text = "✓ SAVE"
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.TextSize = 16
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.Parent = DialogFrame
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveBtn
    
    local CancelBtn = Instance.new("TextButton")
    CancelBtn.Size = UDim2.new(0.48, 0, 0, 45)
    CancelBtn.Position = UDim2.new(0.52, 0, 0, 130)
    CancelBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CancelBtn.BackgroundTransparency = 0.1
    CancelBtn.BorderSizePixel = 0
    CancelBtn.Text = "✕ CANCEL"
    CancelBtn.Font = Enum.Font.GothamBold
    CancelBtn.TextSize = 16
    CancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CancelBtn.Parent = DialogFrame
    
    local CancelCorner = Instance.new("UICorner")
    CancelCorner.CornerRadius = UDim.new(0, 10)
    CancelCorner.Parent = CancelBtn
    
    SaveBtn.MouseButton1Click:Connect(function()
        local cpName = NameBox.Text
        if cpName == "" then
            CreateNotification("ANTC HUB", "Please enter a checkpoint name!", 3, Color3.fromRGB(255, 100, 100))
            return
        end
        
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local success = SaveCheckpoint(cpName, char.HumanoidRootPart.CFrame)
            if success then
                CreateNotification("ANTC HUB", "Checkpoint saved: " .. cpName, 3, Color3.fromRGB(0, 255, 150))
                DialogFrame:Destroy()
            end
        else
            CreateNotification("ANTC HUB", "Character not found!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
    
    CancelBtn.MouseButton1Click:Connect(function()
        DialogFrame:Destroy()
    end)
    
    DialogFrame.Size = UDim2.new(0, 0, 0, 0)
    DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(DialogFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 200),
        Position = UDim2.new(0.5, -200, 0.5, -100)
    }):Play()
end

function RefreshCheckpointList(parentTab)
    for _, child in pairs(parentTab:GetChildren()) do
        if child.Name == "CheckpointItem" then
            child:Destroy()
        end
    end
    
    if #Checkpoints == 0 then
        return
    end
    
    task.wait(0.1)
    
    for i, checkpoint in pairs(Checkpoints) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Name = "CheckpointItem"
        ItemFrame.Size = UDim2.new(1, 0, 0, 55)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        ItemFrame.BackgroundTransparency = 0.18
        ItemFrame.BorderSizePixel = 0
        ItemFrame.Parent = parentTab
        
        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 11)
        ItemCorner.Parent = ItemFrame
        
        local ItemStroke = Instance.new("UIStroke")
        ItemStroke.Color = Color3.fromRGB(138, 43, 226)
        ItemStroke.Thickness = 1.3
        ItemStroke.Transparency = 0.7
        ItemStroke.Parent = ItemFrame
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -130, 0, 28)
        NameLabel.Position = UDim2.new(0, 12, 0, 8)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = checkpoint.name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 14
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = ItemFrame
        
        local TimeLabel = Instance.new("TextLabel")
        TimeLabel.Size = UDim2.new(1, -130, 0, 18)
        TimeLabel.Position = UDim2.new(0, 12, 0, 32)
        TimeLabel.BackgroundTransparency = 1
        TimeLabel.Text = os.date("%H:%M - %d/%m/%Y", checkpoint.timestamp or os.time())
        TimeLabel.Font = Enum.Font.Gotham
        TimeLabel.TextSize = 10
        TimeLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
        TimeLabel.Parent = ItemFrame
        
        local TpBtn = Instance.new("TextButton")
        TpBtn.Size = UDim2.new(0, 50, 0, 38)
        TpBtn.Position = UDim2.new(1, -115, 0.5, -19)
        TpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        TpBtn.BackgroundTransparency = 0.1
        TpBtn.BorderSizePixel = 0
        TpBtn.Text = "TP"
        TpBtn.Font = Enum.Font.GothamBold
        TpBtn.TextSize = 14
        TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TpBtn.Parent = ItemFrame
        
        local TpCorner = Instance.new("UICorner")
        TpCorner.CornerRadius = UDim.new(0, 9)
        TpCorner.Parent = TpBtn
        
        local DelBtn = Instance.new("TextButton")
        DelBtn.Size = UDim2.new(0, 50, 0, 38)
        DelBtn.Position = UDim2.new(1, -57, 0.5, -19)
        DelBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        DelBtn.BackgroundTransparency = 0.1
        DelBtn.BorderSizePixel = 0
        DelBtn.Text = "✕"
        DelBtn.Font = Enum.Font.GothamBold
        DelBtn.TextSize = 18
        DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.Parent = ItemFrame
        
        local DelCorner = Instance.new("UICorner")
        DelCorner.CornerRadius = UDim.new(0, 9)
        DelCorner.Parent = DelBtn
        
        TpBtn.MouseButton1Click:Connect(function()
            TeleportToCheckpoint(i)
        end)
        
        DelBtn.MouseButton1Click:Connect(function()
            DeleteCheckpoint(i)
            RefreshCheckpointList(parentTab)
            CreateNotification("ANTC HUB", "Checkpoint deleted: " .. checkpoint.name, 3, Color3.fromRGB(255, 150, 50))
        end)
    end
end

function ViewAllCheckpoints()
    local ListFrame = Instance.new("Frame")
    ListFrame.Size = UDim2.new(0, 500, 0, 550)
    ListFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
    ListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ListFrame.BackgroundTransparency = 0.05
    ListFrame.BorderSizePixel = 0
    ListFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ListFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.2
    Stroke.Parent = ListFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 0, 50)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "ALL CHECKPOINTS"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ListFrame
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -30, 0, 25)
    InfoLabel.Position = UDim2.new(0, 15, 0, 55)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "Total: " .. #Checkpoints .. " / " .. GetMaxCheckpointSlots() .. " slots"
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 13
    InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.Parent = ListFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -50, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = ListFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -105)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 85)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.Parent = ListFrame
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = ScrollFrame
    
    if #Checkpoints == 0 then
        local EmptyLabel = Instance.new("TextLabel")
        EmptyLabel.Size = UDim2.new(1, 0, 0, 100)
        EmptyLabel.BackgroundTransparency = 1
        EmptyLabel.Text = "No checkpoints saved yet\nCreate one to get started!"
        EmptyLabel.Font = Enum.Font.Gotham
        EmptyLabel.TextSize = 14
        EmptyLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        EmptyLabel.Parent = ScrollFrame
    else
        for i, checkpoint in pairs(Checkpoints) do
            local ItemFrame = Instance.new("Frame")
            ItemFrame.Size = UDim2.new(1, 0, 0, 70)
            ItemFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
            ItemFrame.BackgroundTransparency = 0.18
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Parent = ScrollFrame
            
            local ItemCorner = Instance.new("UICorner")
            ItemCorner.CornerRadius = UDim.new(0, 11)
            ItemCorner.Parent = ItemFrame
            
            local ItemStroke = Instance.new("UIStroke")
            ItemStroke.Color = Color3.fromRGB(138, 43, 226)
            ItemStroke.Thickness = 1.5
            ItemStroke.Transparency = 0.6
            ItemStroke.Parent = ItemFrame
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -135, 0, 32)
            NameLabel.Position = UDim2.new(0, 12, 0, 10)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = checkpoint.name
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.TextSize = 15
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = ItemFrame
            
            local TimeLabel = Instance.new("TextLabel")
            TimeLabel.Size = UDim2.new(1, -135, 0, 22)
            TimeLabel.Position = UDim2.new(0, 12, 0, 42)
            TimeLabel.BackgroundTransparency = 1
            TimeLabel.Text = "Saved: " .. os.date("%H:%M - %d/%m/%Y", checkpoint.timestamp or os.time())
            TimeLabel.Font = Enum.Font.Gotham
            TimeLabel.TextSize = 11
            TimeLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
            TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
            TimeLabel.Parent = ItemFrame
            
            local TpBtn = Instance.new("TextButton")
            TpBtn.Size = UDim2.new(0, 55, 0, 50)
            TpBtn.Position = UDim2.new(1, -125, 0.5, -25)
            TpBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            TpBtn.BackgroundTransparency = 0.1
            TpBtn.BorderSizePixel = 0
            TpBtn.Text = "📍 TP"
            TpBtn.Font = Enum.Font.GothamBold
            TpBtn.TextSize = 13
            TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TpBtn.Parent = ItemFrame
            
            local TpCorner = Instance.new("UICorner")
            TpCorner.CornerRadius = UDim.new(0, 9)
            TpCorner.Parent = TpBtn
            
            local DelBtn = Instance.new("TextButton")
            DelBtn.Size = UDim2.new(0, 55, 0, 50)
            DelBtn.Position = UDim2.new(1, -62, 0.5, -25)
            DelBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            DelBtn.BackgroundTransparency = 0.1
            DelBtn.BorderSizePixel = 0
            DelBtn.Text = "🗑 DEL"
            DelBtn.Font = Enum.Font.GothamBold
            DelBtn.TextSize = 12
            DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            DelBtn.Parent = ItemFrame
            
            local DelCorner = Instance.new("UICorner")
            DelCorner.CornerRadius = UDim.new(0, 9)
            DelCorner.Parent = DelBtn
            
            TpBtn.MouseButton1Click:Connect(function()
                TeleportToCheckpoint(i)
            end)
            
            DelBtn.MouseButton1Click:Connect(function()
                DeleteCheckpoint(i)
                ListFrame:Destroy()
                CreateNotification("ANTC HUB", "Checkpoint deleted: " .. checkpoint.name, 3, Color3.fromRGB(255, 150, 50))
                ViewAllCheckpoints()
            end)
        end
    end
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(ListFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.4)
        ListFrame:Destroy()
    end)
    
    ListFrame.Size = UDim2.new(0, 0, 0, 0)
    ListFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(ListFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 550),
        Position = UDim2.new(0.5, -250, 0.5, -275)
    }):Play()
end

function CreateSpectateExitButton()
    if SpectateExitButton then
        SpectateExitButton:Destroy()
    end
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(0, 380, 0, 60)
    ButtonContainer.Position = UDim2.new(0.5, -190, 0, 20)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = ScreenGui
    
    local TeleportBtn = Instance.new("TextButton")
    TeleportBtn.Size = UDim2.new(0, 180, 0, 50)
    TeleportBtn.Position = UDim2.new(0, 0, 0, 0)
    TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    TeleportBtn.BackgroundTransparency = 0.15
    TeleportBtn.BorderSizePixel = 0
    TeleportBtn.Text = "TELEPORT TO TARGET"
    TeleportBtn.Font = Enum.Font.GothamBold
    TeleportBtn.TextSize = 14
    TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportBtn.Parent = ButtonContainer
    
    local TeleportCorner = Instance.new("UICorner")
    TeleportCorner.CornerRadius = UDim.new(0, 12)
    TeleportCorner.Parent = TeleportBtn
    
    local TeleportStroke = Instance.new("UIStroke")
    TeleportStroke.Color = Color3.fromRGB(100, 200, 255)
    TeleportStroke.Thickness = 2
    TeleportStroke.Transparency = 0.3
    TeleportStroke.Parent = TeleportBtn
    
    local ExitBtn = Instance.new("TextButton")
    ExitBtn.Size = UDim2.new(0, 180, 0, 50)
    ExitBtn.Position = UDim2.new(0, 200, 0, 0)
    ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ExitBtn.BackgroundTransparency = 0.15
    ExitBtn.BorderSizePixel = 0
    ExitBtn.Text = "EXIT SPECTATE"
    ExitBtn.Font = Enum.Font.GothamBold
    ExitBtn.TextSize = 16
    ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExitBtn.Parent = ButtonContainer
    
    local ExitCorner = Instance.new("UICorner")
    ExitCorner.CornerRadius = UDim.new(0, 12)
    ExitCorner.Parent = ExitBtn
    
    local ExitStroke = Instance.new("UIStroke")
    ExitStroke.Color = Color3.fromRGB(255, 100, 100)
    ExitStroke.Thickness = 2
    ExitStroke.Transparency = 0.3
    ExitStroke.Parent = ExitBtn
    
    SpectateExitButton = ButtonContainer
    
    TeleportBtn.MouseButton1Click:Connect(function()
        if CurrentSpectateTarget and CurrentSpectateTarget.Character and CurrentSpectateTarget.Character:FindFirstChild("HumanoidRootPart") then
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CurrentSpectateTarget.Character.HumanoidRootPart.CFrame
                CreateNotification("ANTC HUB", "Teleported to spectate target!", 3, Color3.fromRGB(0, 255, 150))
                SendDeveloperWebhook("Teleported to spectate target: " .. CurrentSpectateTarget.Name)
            end
        end
    end)
    
    ExitBtn.MouseButton1Click:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            Workspace.CurrentCamera.CameraSubject = char.Humanoid
            CreateNotification("ANTC HUB", "Stopped spectating", 3, Color3.fromRGB(138, 43, 226))
            ButtonContainer:Destroy()
            SpectateExitButton = nil
            CurrentSpectateTarget = nil
        end
    end)
    
    ButtonContainer.Size = UDim2.new(0, 0, 0, 60)
    TweenService:Create(ButtonContainer, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 380, 0, 60)
    }):Play()
end

function CreateAdvancedTeleport()
    local TeleportFrame = Instance.new("Frame")
    TeleportFrame.Size = UDim2.new(0, 420, 0, 300)
    TeleportFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
    TeleportFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    TeleportFrame.BackgroundTransparency = 0.05
    TeleportFrame.BorderSizePixel = 0
    TeleportFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = TeleportFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = TeleportFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Advanced Teleport"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TeleportFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = TeleportFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        TeleportFrame:Destroy()
    end)
    
    local XBox = Instance.new("TextBox")
    XBox.Size = UDim2.new(0.3, -10, 0, 45)
    XBox.Position = UDim2.new(0, 20, 0, 80)
    XBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    XBox.BackgroundTransparency = 0.1
    XBox.BorderSizePixel = 0
    XBox.PlaceholderText = "X Position"
    XBox.Text = "0"
    XBox.Font = Enum.Font.Gotham
    XBox.TextSize = 14
    XBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    XBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    XBox.Parent = TeleportFrame
    
    local XCorner = Instance.new("UICorner")
    XCorner.CornerRadius = UDim.new(0, 10)
    XCorner.Parent = XBox
    
    local YBox = Instance.new("TextBox")
    YBox.Size = UDim2.new(0.3, -10, 0, 45)
    YBox.Position = UDim2.new(0.35, 0, 0, 80)
    YBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    YBox.BackgroundTransparency = 0.1
    YBox.BorderSizePixel = 0
    YBox.PlaceholderText = "Y Position"
    YBox.Text = "0"
    YBox.Font = Enum.Font.Gotham
    YBox.TextSize = 14
    YBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    YBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    YBox.Parent = TeleportFrame
    
    local YCorner = Instance.new("UICorner")
    YCorner.CornerRadius = UDim.new(0, 10)
    YCorner.Parent = YBox
    
    local ZBox = Instance.new("TextBox")
    ZBox.Size = UDim2.new(0.3, -10, 0, 45)
    ZBox.Position = UDim2.new(0.7, -10, 0, 80)
    ZBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    ZBox.BackgroundTransparency = 0.1
    ZBox.BorderSizePixel = 0
    ZBox.PlaceholderText = "Z Position"
    ZBox.Text = "0"
    ZBox.Font = Enum.Font.Gotham
    ZBox.TextSize = 14
    ZBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ZBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    ZBox.Parent = TeleportFrame
    
    local ZCorner = Instance.new("UICorner")
    ZCorner.CornerRadius = UDim.new(0, 10)
    ZCorner.Parent = ZBox
    
    local GetPosBtn = Instance.new("TextButton")
    GetPosBtn.Size = UDim2.new(1, -40, 0, 48)
    GetPosBtn.Position = UDim2.new(0, 20, 0, 145)
    GetPosBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    GetPosBtn.BackgroundTransparency = 0.15
    GetPosBtn.BorderSizePixel = 0
    GetPosBtn.Text = "GET CURRENT POSITION"
    GetPosBtn.Font = Enum.Font.GothamBold
    GetPosBtn.TextSize = 15
    GetPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetPosBtn.Parent = TeleportFrame
    
    local GetPosCorner = Instance.new("UICorner")
    GetPosCorner.CornerRadius = UDim.new(0, 10)
    GetPosCorner.Parent = GetPosBtn
    
    GetPosBtn.MouseButton1Click:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            XBox.Text = tostring(math.floor(pos.X))
            YBox.Text = tostring(math.floor(pos.Y))
            ZBox.Text = tostring(math.floor(pos.Z))
            CreateNotification("ANTC HUB", "Current position loaded!", 2, Color3.fromRGB(0, 255, 150))
        end
    end)
    
    local TeleportBtn = Instance.new("TextButton")
    TeleportBtn.Size = UDim2.new(1, -40, 0, 52)
    TeleportBtn.Position = UDim2.new(0, 20, 0, 210)
    TeleportBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TeleportBtn.BackgroundTransparency = 0.1
    TeleportBtn.BorderSizePixel = 0
    TeleportBtn.Text = "TELEPORT TO COORDINATES"
    TeleportBtn.Font = Enum.Font.GothamBold
    TeleportBtn.TextSize = 16
    TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportBtn.Parent = TeleportFrame
    
    local TeleportCorner = Instance.new("UICorner")
    TeleportCorner.CornerRadius = UDim.new(0, 10)
    TeleportCorner.Parent = TeleportBtn
    
    TeleportBtn.MouseButton1Click:Connect(function()
        local x = tonumber(XBox.Text)
        local y = tonumber(YBox.Text)
        local z = tonumber(ZBox.Text)
        
        if x and y and z then
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
                CreateNotification("ANTC HUB", "Teleported to coordinates!", 3, Color3.fromRGB(0, 255, 150))
                SendDeveloperWebhook("Advanced Teleport to: " .. x .. ", " .. y .. ", " .. z)
                TeleportFrame:Destroy()
            end
        else
            CreateNotification("ANTC HUB", "Please enter valid coordinates!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
end

function CreateGiveItemUI()
    local ItemFrame = Instance.new("Frame")
    ItemFrame.Size = UDim2.new(0, 420, 0, 250)
    ItemFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
    ItemFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ItemFrame.BackgroundTransparency = 0.05
    ItemFrame.BorderSizePixel = 0
    ItemFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ItemFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = ItemFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Give Item (Model ID)"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ItemFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = ItemFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ItemFrame:Destroy()
    end)
    
    local IDBox = Instance.new("TextBox")
    IDBox.Size = UDim2.new(1, -40, 0, 50)
    IDBox.Position = UDim2.new(0, 20, 0, 80)
    IDBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    IDBox.BackgroundTransparency = 0.1
    IDBox.BorderSizePixel = 0
    IDBox.PlaceholderText = "Enter Model/Item ID..."
    IDBox.Text = ""
    IDBox.Font = Enum.Font.Gotham
    IDBox.TextSize = 15
    IDBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    IDBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    IDBox.Parent = ItemFrame
    
    local IDCorner = Instance.new("UICorner")
    IDCorner.CornerRadius = UDim.new(0, 10)
    IDCorner.Parent = IDBox
    
    local GiveBtn = Instance.new("TextButton")
    GiveBtn.Size = UDim2.new(1, -40, 0, 55)
    GiveBtn.Position = UDim2.new(0, 20, 0, 150)
    GiveBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    GiveBtn.BackgroundTransparency = 0.1
    GiveBtn.BorderSizePixel = 0
    GiveBtn.Text = "GIVE ITEM TO ME"
    GiveBtn.Font = Enum.Font.GothamBold
    GiveBtn.TextSize = 16
    GiveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GiveBtn.Parent = ItemFrame
    
    local GiveCorner = Instance.new("UICorner")
    GiveCorner.CornerRadius = UDim.new(0, 10)
    GiveCorner.Parent = GiveBtn
    
    GiveBtn.MouseButton1Click:Connect(function()
        local modelId = tonumber(IDBox.Text)
        if modelId then
            local success, model = pcall(function()
                return game:GetObjects("rbxassetid://" .. modelId)[1]
            end)
            
            if success and model then
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    model.Parent = char
                    if model:IsA("Tool") then
                        CreateNotification("ANTC HUB", "Tool added to character!", 3, Color3.fromRGB(0, 255, 150))
                    else
                        CreateNotification("ANTC HUB", "Item spawned successfully!", 3, Color3.fromRGB(0, 255, 150))
                    end
                    SendDeveloperWebhook("Gave item: " .. modelId)
                    ItemFrame:Destroy()
                end
            else
                CreateNotification("ANTC HUB", "Invalid model ID or item not found!", 3, Color3.fromRGB(255, 100, 100))
            end
        else
            CreateNotification("ANTC HUB", "Please enter a valid number!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
end

function CreateWebhookConfigUI()
    local WebhookFrame = Instance.new("Frame")
    WebhookFrame.Size = UDim2.new(0, 480, 0, 300)
    WebhookFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
    WebhookFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    WebhookFrame.BackgroundTransparency = 0.05
    WebhookFrame.BorderSizePixel = 0
    WebhookFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = WebhookFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = WebhookFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Configure Webhook"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = WebhookFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = WebhookFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        WebhookFrame:Destroy()
    end)
    
    local WebhookBox = Instance.new("TextBox")
    WebhookBox.Size = UDim2.new(1, -40, 0, 50)
    WebhookBox.Position = UDim2.new(0, 20, 0, 80)
    WebhookBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    WebhookBox.BackgroundTransparency = 0.1
    WebhookBox.BorderSizePixel = 0
    WebhookBox.PlaceholderText = "Enter Discord Webhook URL..."
    WebhookBox.Text = DeveloperActivityWebhook
    WebhookBox.Font = Enum.Font.Gotham
    WebhookBox.TextSize = 13
    WebhookBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    WebhookBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    WebhookBox.ClearTextOnFocus = false
    WebhookBox.Parent = WebhookFrame
    
    local WebhookCorner = Instance.new("UICorner")
    WebhookCorner.CornerRadius = UDim.new(0, 10)
    WebhookCorner.Parent = WebhookBox
    
    local TestBtn = Instance.new("TextButton")
    TestBtn.Size = UDim2.new(0.48, -5, 0, 50)
    TestBtn.Position = UDim2.new(0, 20, 0, 150)
    TestBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    TestBtn.BackgroundTransparency = 0.15
    TestBtn.BorderSizePixel = 0
    TestBtn.Text = "TEST WEBHOOK"
    TestBtn.Font = Enum.Font.GothamBold
    TestBtn.TextSize = 14
    TestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TestBtn.Parent = WebhookFrame
    
    local TestCorner = Instance.new("UICorner")
    TestCorner.CornerRadius = UDim.new(0, 10)
    TestCorner.Parent = TestBtn
    
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(0.48, -5, 0, 50)
    SaveBtn.Position = UDim2.new(0.52, 0, 0, 150)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    SaveBtn.BackgroundTransparency = 0.15
    SaveBtn.BorderSizePixel = 0
    SaveBtn.Text = "SAVE WEBHOOK"
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.TextSize = 14
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.Parent = WebhookFrame
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveBtn
    
    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -40, 0, 60)
    InfoText.Position = UDim2.new(0, 20, 0, 220)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = "Set your Discord webhook URL to receive notifications about developer activities and key generations."
    InfoText.Font = Enum.Font.Gotham
    InfoText.TextSize = 12
    InfoText.TextColor3 = Color3.fromRGB(180, 180, 200)
    InfoText.TextWrapped = true
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.Parent = WebhookFrame
    
    TestBtn.MouseButton1Click:Connect(function()
        local testWebhook = WebhookBox.Text
        if testWebhook ~= "" then
            pcall(function()
                HttpService:PostAsync(testWebhook, HttpService:JSONEncode({
                    content = "🔔 **Test Webhook** - ANTC HUB Developer Panel\n✅ Webhook connection successful!"
                }), Enum.HttpContentType.ApplicationJson, false)
            end)
            CreateNotification("ANTC HUB", "Test message sent to webhook!", 3, Color3.fromRGB(0, 255, 150))
        else
            CreateNotification("ANTC HUB", "Please enter a webhook URL!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
    
    SaveBtn.MouseButton1Click:Connect(function()
        local newWebhook = WebhookBox.Text
        if newWebhook ~= "" then
            DeveloperActivityWebhook = newWebhook
            CreateNotification("ANTC HUB", "Webhook URL saved successfully!", 3, Color3.fromRGB(0, 255, 150))
            WebhookFrame:Destroy()
        else
            CreateNotification("ANTC HUB", "Please enter a webhook URL!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
end

function CreateNameTagEditor()
    local TagFrame = Instance.new("Frame")
    TagFrame.Size = UDim2.new(0, 420, 0, 250)
    TagFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
    TagFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    TagFrame.BackgroundTransparency = 0.05
    TagFrame.BorderSizePixel = 0
    TagFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = TagFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = TagFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Customize Name Tag"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TagFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = TagFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        TagFrame:Destroy()
    end)
    
    local TagBox = Instance.new("TextBox")
    TagBox.Size = UDim2.new(1, -40, 0, 50)
    TagBox.Position = UDim2.new(0, 20, 0, 80)
    TagBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    TagBox.BackgroundTransparency = 0.1
    TagBox.BorderSizePixel = 0
    TagBox.PlaceholderText = "Enter custom name tag..."
    TagBox.Text = Settings.CustomNameTag or ""
    TagBox.Font = Enum.Font.Gotham
    TagBox.TextSize = 15
    TagBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TagBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    TagBox.Parent = TagFrame
    
    local TagCorner = Instance.new("UICorner")
    TagCorner.CornerRadius = UDim.new(0, 10)
    TagCorner.Parent = TagBox
    
    local ApplyBtn = Instance.new("TextButton")
    ApplyBtn.Size = UDim2.new(1, -40, 0, 55)
    ApplyBtn.Position = UDim2.new(0, 20, 0, 150)
    ApplyBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ApplyBtn.BackgroundTransparency = 0.1
    ApplyBtn.BorderSizePixel = 0
    ApplyBtn.Text = "APPLY NAME TAG"
    ApplyBtn.Font = Enum.Font.GothamBold
    ApplyBtn.TextSize = 16
    ApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ApplyBtn.Parent = TagFrame
    
    local ApplyCorner = Instance.new("UICorner")
    ApplyCorner.CornerRadius = UDim.new(0, 10)
    ApplyCorner.Parent = ApplyBtn
    
    ApplyBtn.MouseButton1Click:Connect(function()
        local customTag = TagBox.Text
        if customTag ~= "" then
            Settings.CustomNameTag = customTag
            Settings.ShowNameTag = true
            SaveSettings()
            ApplyNameTag(customTag)
            CreateNotification("ANTC HUB", "Name tag set to: " .. customTag, 3, Color3.fromRGB(0, 255, 150))
            SendDeveloperWebhook("📛 Set name tag: " .. customTag)
            TagFrame:Destroy()
        else
            CreateNotification("ANTC HUB", "Please enter a name tag!", 3, Color3.fromRGB(255, 100, 100))
        end
    end)
end

function CreatePlayerListViewer()
    local ListFrame = Instance.new("Frame")
    ListFrame.Size = UDim2.new(0, 500, 0, 550)
    ListFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
    ListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ListFrame.BackgroundTransparency = 0.05
    ListFrame.BorderSizePixel = 0
    ListFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ListFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = ListFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Player List - " .. #Players:GetPlayers() .. " Players"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ListFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = ListFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ListFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = ListFrame
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = ScrollFrame
    
    ScrollFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    
    for _, player in pairs(Players:GetPlayers()) do
        local PlayerFrame = Instance.new("Frame")
        PlayerFrame.Size = UDim2.new(1, 0, 0, 70)
        PlayerFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        PlayerFrame.BackgroundTransparency = 0.15
        PlayerFrame.BorderSizePixel = 0
        PlayerFrame.Parent = ScrollFrame
        
        local PCorner = Instance.new("UICorner")
        PCorner.CornerRadius = UDim.new(0, 10)
        PCorner.Parent = PlayerFrame
        
        local PStroke = Instance.new("UIStroke")
        PStroke.Color = player == Player and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(138, 43, 226)
        PStroke.Thickness = 1.5
        PStroke.Transparency = 0.6
        PStroke.Parent = PlayerFrame
        
        local PlayerName = Instance.new("TextLabel")
        PlayerName.Size = UDim2.new(1, -20, 0, 25)
        PlayerName.Position = UDim2.new(0, 10, 0, 8)
        PlayerName.BackgroundTransparency = 1
        PlayerName.Text = player.Name .. (player == Player and " (You)" or "")
        PlayerName.Font = Enum.Font.GothamBold
        PlayerName.TextSize = 15
        PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerName.TextXAlignment = Enum.TextXAlignment.Left
        PlayerName.Parent = PlayerFrame
        
        local PlayerInfo = Instance.new("TextLabel")
        PlayerInfo.Size = UDim2.new(1, -20, 0, 20)
        PlayerInfo.Position = UDim2.new(0, 10, 0, 35)
        PlayerInfo.BackgroundTransparency = 1
        PlayerInfo.Text = "ID: " .. player.UserId .. " | Account Age: " .. player.AccountAge .. " days"
        PlayerInfo.Font = Enum.Font.Gotham
        PlayerInfo.TextSize = 12
        PlayerInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
        PlayerInfo.TextXAlignment = Enum.TextXAlignment.Left
        PlayerInfo.Parent = PlayerFrame
    end
end

function CreateScriptInfo()
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Size = UDim2.new(0, 500, 0, 450)
    InfoFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    InfoFrame.BackgroundTransparency = 0.05
    InfoFrame.BorderSizePixel = 0
    InfoFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = InfoFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = InfoFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "ANTC HUB - Script Info"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = InfoFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 45, 0, 45)
    CloseBtn.Position = UDim2.new(1, -60, 0, 12)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = InfoFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        InfoFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    ScrollFrame.Parent = InfoFrame
    
    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -20, 0, 580)
    InfoText.Position = UDim2.new(0, 10, 0, 10)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = [[🎮 ANTC HUB - ULTIMATE EDITION

📋 Version: 4.0 Professional
👤 User Status: ]] .. UserStatus .. [[

✨ FEATURES:
• Advanced Movement System
• Player Manipulation Tools
• Checkpoint & Teleport System
• Avatar Customization
• Music Player Integration
• Developer Tools & Webhooks
• Anti-AFK Protection
• Safe Zone System
• Premium Features Access

🔑 KEY TIERS:
• Guest - Basic Features
• Basic Script - 11 Hours Access
• Premium - Extended Features
• Developer - Full Access

👨‍💻 DEVELOPERS:
• ANTC Team
• APIS Development

⚙️ TECHNICAL INFO:
• Lua-based Executor Script
• Cloud Webhook Integration
• Save/Load Settings System
• Real-time Notifications
• Advanced GUI System

📞 SUPPORT:
• Discord Webhook Notifications
• Developer Activity Tracking
• Key Generation System

© 2025 ANTC HUB - All Rights Reserved]]
    InfoText.Font = Enum.Font.Gotham
    InfoText.TextSize = 14
    InfoText.TextColor3 = Color3.fromRGB(220, 220, 240)
    InfoText.TextWrapped = true
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top
    InfoText.Parent = ScrollFrame
end

function CreateMainGUI()
    local scale = Settings.GUIScale
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 750 * scale, 0, 520 * scale)
    MainFrame.Position = UDim2.new(0.5, -375 * scale, 0.5, -260 * scale)
    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
    MainFrame.BackgroundTransparency = 0.08
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = false
    MainFrame.Parent = ScreenGui
    
    if not IsLifetimeKey and KeyExpiryTime then
        task.spawn(function()
            while MainFrame and MainFrame.Parent do
                local currentTime = os.time()
                if currentTime >= KeyExpiryTime then
                    CreateNotification("ANTC HUB", "Key expired! Returning to Keys Menu...", 4, Color3.fromRGB(255, 100, 100))
                    task.wait(1)
                    
                    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = UDim2.new(0, 0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }):Play()
                    
                    task.wait(0.4)
                    if MainFrame and MainFrame.Parent then
                        MainFrame:Destroy()
                    end
                    
                    if MinimizedFrame then
                        MinimizedFrame:Destroy()
                        MinimizedFrame = nil
                    end
                    
                    KeyVerified = false
                    task.wait(0.3)
                    CreateKeySystem()
                    break
                end
                task.wait(10)
            end
        end)
    end
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 18)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(138, 43, 226)
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.3
    MainStroke.Parent = MainFrame
    
    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1, 50, 1, 50)
    Glow.Position = UDim2.new(0, -25, 0, -25)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://5554236805"
    Glow.ImageColor3 = Color3.fromRGB(138, 43, 226)
    Glow.ImageTransparency = 0.65
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(23, 23, 277, 277)
    Glow.ZIndex = -1
    Glow.Parent = MainFrame
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.BackgroundColor3 = Color3.fromRGB(12, 12, 24)
    TopBar.BackgroundTransparency = 0.12
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 18)
    TopCorner.Parent = TopBar
    
    local TopCover = Instance.new("Frame")
    TopCover.Size = UDim2.new(1, 0, 0, 18)
    TopCover.Position = UDim2.new(0, 0, 1, -18)
    TopCover.BackgroundColor3 = Color3.fromRGB(12, 12, 24)
    TopCover.BackgroundTransparency = 0.12
    TopCover.BorderSizePixel = 0
    TopCover.Parent = TopBar
    
    local TopGrad = Instance.new("UIGradient")
    TopGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    TopGrad.Rotation = 45
    TopGrad.Parent = TopBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 250, 1, 0)
    Title.Position = UDim2.new(0, 18, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ANTC HUB"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 1
    Title.Parent = TopBar
    
    local LogoutBtn = Instance.new("TextButton")
    LogoutBtn.Size = UDim2.new(0, 40, 0, 40)
    LogoutBtn.Position = UDim2.new(1, -150, 0.5, -20)
    LogoutBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    LogoutBtn.BackgroundTransparency = 0.15
    LogoutBtn.Text = "⎋"
    LogoutBtn.Font = Enum.Font.GothamBold
    LogoutBtn.TextSize = 20
    LogoutBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoutBtn.BorderSizePixel = 0
    LogoutBtn.ZIndex = 10
    LogoutBtn.Parent = TopBar
    
    local LogoutCorner = Instance.new("UICorner")
    LogoutCorner.CornerRadius = UDim.new(0, 10)
    LogoutCorner.Parent = LogoutBtn
    
    LogoutBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        task.wait(0.4)
        MainFrame:Destroy()
        
        if MinimizedFrame then
            MinimizedFrame:Destroy()
            MinimizedFrame = nil
        end
        
        KeyVerified = false
        CreateNotification("ANTC HUB", "Logged out successfully", 3, Color3.fromRGB(255, 165, 0))
        task.wait(0.3)
        CreateKeySystem()
    end)
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.BackgroundTransparency = 0.15
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 10
    CloseBtn.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        task.wait(0.3)
        MainFrame:Destroy()
        
        if MinimizedFrame then
            MinimizedFrame:Destroy()
            MinimizedFrame = nil
        end
        
        ScreenGui:Destroy()
        NotificationGui:Destroy()
        CreateNotification("ANTC HUB", "GUI Closed", 2, Color3.fromRGB(255, 100, 100))
    end)
    
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
    MinimizeBtn.Position = UDim2.new(1, -100, 0.5, -20)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    MinimizeBtn.BackgroundTransparency = 0.15
    MinimizeBtn.Text = "-"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 20
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.ZIndex = 10
    MinimizeBtn.Parent = TopBar
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 10)
    MinCorner.Parent = MinimizeBtn
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        if MinimizedFrame then
            MinimizedFrame:Destroy()
        end
        
        local minimizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 150, 0, 60),
            Position = UDim2.new(0, 85, 1, -130)
        })
        minimizeTween:Play()
        
        task.wait(0.35)
        MainFrame.Visible = false
        
        MinimizedFrame = Instance.new("Frame")
        MinimizedFrame.Name = "MinimizedFrame"
        MinimizedFrame.Size = UDim2.new(0, 0, 0, 0)
        MinimizedFrame.Position = UDim2.new(0, 10, 1, -70)
        MinimizedFrame.AnchorPoint = Vector2.new(0, 0)
        MinimizedFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
        MinimizedFrame.BackgroundTransparency = 0.03
        MinimizedFrame.BorderSizePixel = 0
        MinimizedFrame.Parent = ScreenGui
        
        local MinFrame_Corner = Instance.new("UICorner")
        MinFrame_Corner.CornerRadius = UDim.new(0, 14)
        MinFrame_Corner.Parent = MinimizedFrame
        
        local MinFrame_Stroke = Instance.new("UIStroke")
        MinFrame_Stroke.Color = Color3.fromRGB(138, 43, 226)
        MinFrame_Stroke.Thickness = 2
        MinFrame_Stroke.Transparency = 0.3
        MinFrame_Stroke.Parent = MinimizedFrame
        
        local MinFrame_Label = Instance.new("TextLabel")
        MinFrame_Label.Size = UDim2.new(1, -60, 1, 0)
        MinFrame_Label.Position = UDim2.new(0, 10, 0, 0)
        MinFrame_Label.BackgroundTransparency = 1
        MinFrame_Label.Text = "ANTC HUB"
        MinFrame_Label.Font = Enum.Font.GothamBold
        MinFrame_Label.TextSize = 14
        MinFrame_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinFrame_Label.TextXAlignment = Enum.TextXAlignment.Left
        MinFrame_Label.Parent = MinimizedFrame
        
        local RestoreBtn = Instance.new("TextButton")
        RestoreBtn.Size = UDim2.new(0, 45, 0, 45)
        RestoreBtn.Position = UDim2.new(1, -50, 0.5, -22.5)
        RestoreBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        RestoreBtn.BackgroundTransparency = 0.15
        RestoreBtn.Text = "+"
        RestoreBtn.Font = Enum.Font.GothamBold
        RestoreBtn.TextSize = 24
        RestoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        RestoreBtn.BorderSizePixel = 0
        RestoreBtn.Parent = MinimizedFrame
        
        local RestoreCorner = Instance.new("UICorner")
        RestoreCorner.CornerRadius = UDim.new(0, 10)
        RestoreCorner.Parent = RestoreBtn
        
        local expandTween = TweenService:Create(MinimizedFrame, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 220, 0, 70)
        })
        expandTween:Play()
        
        RestoreBtn.MouseButton1Click:Connect(function()
            local shrinkTween = TweenService:Create(MinimizedFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            shrinkTween:Play()
            
            task.wait(0.3)
            MinimizedFrame:Destroy()
            MinimizedFrame = nil
            
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 150, 0, 60)
            MainFrame.Position = UDim2.new(0, 85, 1, -130)
            
            local restoreTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 750 * scale, 0, 520 * scale),
                Position = UDim2.new(0.5, -375 * scale, 0.5, -260 * scale)
            })
            restoreTween:Play()
            
            CreateNotification("ANTC HUB", "GUI Restored Successfully", 2, Color3.fromRGB(0, 255, 150))
        end)
        
        CreateNotification("ANTC HUB", "GUI Minimized - Click + to restore", 3, Color3.fromRGB(138, 43, 226))
    end)
    
    local BottomBar = Instance.new("Frame")
    BottomBar.Size = UDim2.new(1, 0, 0, 45)
    BottomBar.Position = UDim2.new(0, 0, 1, -45)
    BottomBar.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    BottomBar.BackgroundTransparency = 0.15
    BottomBar.BorderSizePixel = 0
    BottomBar.Parent = MainFrame
    
    local BottomCorner = Instance.new("UICorner")
    BottomCorner.CornerRadius = UDim.new(0, 18)
    BottomCorner.Parent = BottomBar
    
    local BottomCover = Instance.new("Frame")
    BottomCover.Size = UDim2.new(1, 0, 0, 18)
    BottomCover.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    BottomCover.BackgroundTransparency = 0.15
    BottomCover.BorderSizePixel = 0
    BottomCover.Parent = BottomBar
    
    local StatusBadge = Instance.new("Frame")
    StatusBadge.Size = UDim2.new(0, 105, 0, 26)
    StatusBadge.Position = UDim2.new(0, 15, 0.5, -13)
    StatusBadge.BackgroundColor3 = UserTier == 3 and Color3.fromRGB(0, 255, 150) or (UserTier == 2 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 150, 255))
    StatusBadge.BackgroundTransparency = 0.15
    StatusBadge.BorderSizePixel = 0
    StatusBadge.Parent = BottomBar
    
    local BadgeCorner = Instance.new("UICorner")
    BadgeCorner.CornerRadius = UDim.new(0, 8)
    BadgeCorner.Parent = StatusBadge
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 1, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = UserStatus
    StatusText.Font = Enum.Font.GothamBold
    StatusText.TextSize = 12
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.Parent = StatusBadge
    
    local ResizeHandle = Instance.new("TextButton")
    ResizeHandle.Size = UDim2.new(0, 35, 0, 35)
    ResizeHandle.Position = UDim2.new(1, -40, 1, -40)
    ResizeHandle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ResizeHandle.BackgroundTransparency = 0.3
    ResizeHandle.Text = "⇲"
    ResizeHandle.Font = Enum.Font.GothamBold
    ResizeHandle.TextSize = 16
    ResizeHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ResizeHandle.BorderSizePixel = 0
    ResizeHandle.Parent = MainFrame
    
    local HandleCorner = Instance.new("UICorner")
    HandleCorner.CornerRadius = UDim.new(0, 10)
    HandleCorner.Parent = ResizeHandle
    
    local resizing = false
    local startSize = nil
    local startMouse = nil
    
    ResizeHandle.MouseButton1Down:Connect(function()
        resizing = true
        startSize = MainFrame.Size
        startMouse = Vector2.new(Mouse.X, Mouse.Y)
        
        local moveConnection
        local upConnection
        
        moveConnection = Mouse.Move:Connect(function()
            if resizing then
                local currentMouse = Vector2.new(Mouse.X, Mouse.Y)
                local delta = currentMouse - startMouse
                
                local newWidth = math.clamp(startSize.X.Offset + delta.X, 600, 1200)
                local newHeight = math.clamp(startSize.Y.Offset + delta.Y, 450, 800)
                
                MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
                MainFrame.Position = UDim2.new(0.5, -newWidth/2, 0.5, -newHeight/2)
            end
        end)
        
        upConnection = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
                if moveConnection then moveConnection:Disconnect() end
                if upConnection then upConnection:Disconnect() end
            end
        end)
    end)
    
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(0, 140, 1, -115)
    TabContainer.Position = UDim2.new(0, 10, 0, 68)
    TabContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 24)
    TabContainer.BackgroundTransparency = 0.25
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 4
    TabContainer.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContainer.Parent = MainFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 14)
    TabCorner.Parent = TabContainer
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 6)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Parent = TabContainer
    
    TabContainer:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
    end)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.Parent = TabContainer
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -165, 1, -120)
    ContentContainer.Position = UDim2.new(0, 155, 0, 68)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    local CurrentTab = "Combat"
    local Tabs = {}
    
    local function CreateTab(name, icon, tier)
        if UserTier < tier then return nil end
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 40)
        TabBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
        TabBtn.BackgroundTransparency = name == CurrentTab and 0.1 or 0.4
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = ""
        TabBtn.Parent = TabContainer
        
        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 9)
        TabBtnCorner.Parent = TabBtn
        
        if name == CurrentTab then
            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(138, 43, 226)
            Stroke.Thickness = 1.8
            Stroke.Transparency = 0.3
            Stroke.Parent = TabBtn
        end
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(0, 32, 1, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = icon
        IconLabel.Font = Enum.Font.GothamBold
        IconLabel.TextSize = 18
        IconLabel.TextColor3 = name == CurrentTab and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(140, 140, 160)
        IconLabel.Parent = TabBtn
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -35, 1, 0)
        NameLabel.Position = UDim2.new(0, 32, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 13
        NameLabel.TextColor3 = name == CurrentTab and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(170, 170, 190)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = TabBtn
        
        Tabs[name] = Instance.new("ScrollingFrame")
        Tabs[name].Size = UDim2.new(1, 0, 1, 0)
        Tabs[name].BackgroundTransparency = 1
        Tabs[name].BorderSizePixel = 0
        Tabs[name].ScrollBarThickness = 5
        Tabs[name].ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
        Tabs[name].CanvasSize = UDim2.new(0, 0, 0, 0)
        Tabs[name].Visible = name == CurrentTab
        Tabs[name].Parent = ContentContainer
        
        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.Padding = UDim.new(0, 8)
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Parent = Tabs[name]
        
        Tabs[name]:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
            Tabs[name].CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            for tabName, tabFrame in pairs(Tabs) do
                tabFrame.Visible = false
            end
            Tabs[name].Visible = true
            CurrentTab = name
            
            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundTransparency = 0.4
                    local stroke = child:FindFirstChild("UIStroke")
                    if stroke then stroke:Destroy() end
                    for _, label in pairs(child:GetChildren()) do
                        if label:IsA("TextLabel") and label.Text:len() == 1 then
                            label.TextColor3 = Color3.fromRGB(140, 140, 160)
                        elseif label:IsA("TextLabel") then
                            label.TextColor3 = Color3.fromRGB(170, 170, 190)
                        end
                    end
                end
            end
            
            TabBtn.BackgroundTransparency = 0.1
            local newStroke = Instance.new("UIStroke")
            newStroke.Color = Color3.fromRGB(138, 43, 226)
            newStroke.Thickness = 1.8
            newStroke.Transparency = 0.3
            newStroke.Parent = TabBtn
            IconLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
            NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        return Tabs[name]
    end
    
    local CombatTab = CreateTab("Combat", "C", 1)
    local MovementTab = CreateTab("Movement", "M", 1)
    local PlayerTab = CreateTab("Player", "P", 1)
    local WorldTab = CreateTab("World", "W", 1)
    local CheckpointTab = CreateTab("Checkpoints", "CP", 1)
    local PremiumTab = CreateTab("Premium", "PR", 2)
    local DeveloperTab = CreateTab("Developer", "D", 3)
    local SettingsTab = CreateTab("Settings", "S", 1)
    
    local function CreateToggle(parent, name, icon, callback, tier)
        if not parent or UserTier < tier then return end
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 65)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        Frame.BackgroundTransparency = 0.18
        Frame.BorderSizePixel = 0
        Frame.Parent = parent
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 11)
        Corner.Parent = Frame
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(138, 43, 226)
        Stroke.Thickness = 1.3
        Stroke.Transparency = 0.7
        Stroke.Parent = Frame
        
        local IconFrame = Instance.new("Frame")
        IconFrame.Size = UDim2.new(0, 46, 0, 46)
        IconFrame.Position = UDim2.new(0, 9, 0.5, -23)
        IconFrame.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        IconFrame.BackgroundTransparency = 0.28
        IconFrame.BorderSizePixel = 0
        IconFrame.Parent = Frame
        
        local IconCorner = Instance.new("UICorner")
        IconCorner.CornerRadius = UDim.new(0, 9)
        IconCorner.Parent = IconFrame
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(1, 0, 1, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = icon
        IconLabel.Font = Enum.Font.GothamBold
        IconLabel.TextSize = 20
        IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        IconLabel.Parent = IconFrame
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -170, 1, 0)
        NameLabel.Position = UDim2.new(0, 63, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 14
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Frame
        
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(0, 56, 0, 30)
        Toggle.Position = UDim2.new(1, -68, 0.5, -15)
        Toggle.BackgroundColor3 = Color3.fromRGB(32, 32, 46)
        Toggle.Text = ""
        Toggle.BorderSizePixel = 0
        Toggle.Parent = Frame
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(1, 0)
        ToggleCorner.Parent = Toggle
        
        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 24, 0, 24)
        Indicator.Position = UDim2.new(0, 3, 0.5, -12)
        Indicator.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
        Indicator.BorderSizePixel = 0
        Indicator.Parent = Toggle
        
        local IndCorner = Instance.new("UICorner")
        IndCorner.CornerRadius = UDim.new(1, 0)
        IndCorner.Parent = Indicator
        
        local enabled = false
        
        Toggle.MouseButton1Click:Connect(function()
            enabled = not enabled
            callback(enabled)
            
            if enabled then
                TweenService:Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
                TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Position = UDim2.new(1, -27, 0.5, -12),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                CreateNotification("ANTC HUB", name .. " enabled", 2, Color3.fromRGB(0, 255, 150))
            else
                TweenService:Create(Toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(32, 32, 46)}):Play()
                TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Position = UDim2.new(0, 3, 0.5, -12),
                    BackgroundColor3 = Color3.fromRGB(170, 170, 170)
                }):Play()
                CreateNotification("ANTC HUB", name .. " disabled", 2, Color3.fromRGB(255, 100, 100))
            end
        end)
    end
    
    local function CreateSlider(parent, name, icon, min, max, default, callback, tier)
        if not parent or UserTier < tier then return end
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 85)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        Frame.BackgroundTransparency = 0.18
        Frame.BorderSizePixel = 0
        Frame.Parent = parent
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 11)
        Corner.Parent = Frame
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(138, 43, 226)
        Stroke.Thickness = 1.3
        Stroke.Transparency = 0.7
        Stroke.Parent = Frame
        
        local IconFrame = Instance.new("Frame")
        IconFrame.Size = UDim2.new(0, 46, 0, 46)
        IconFrame.Position = UDim2.new(0, 9, 0, 9)
        IconFrame.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        IconFrame.BackgroundTransparency = 0.28
        IconFrame.BorderSizePixel = 0
        IconFrame.Parent = Frame
        
        local IconCorner = Instance.new("UICorner")
        IconCorner.CornerRadius = UDim.new(0, 9)
        IconCorner.Parent = IconFrame
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(1, 0, 1, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = icon
        IconLabel.Font = Enum.Font.GothamBold
        IconLabel.TextSize = 19
        IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        IconLabel.Parent = IconFrame
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -135, 0, 28)
        NameLabel.Position = UDim2.new(0, 63, 0, 14)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 14
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Frame
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Size = UDim2.new(0, 55, 0, 28)
        ValueLabel.Position = UDim2.new(1, -65, 0, 14)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(default)
        ValueLabel.Font = Enum.Font.GothamBold
        ValueLabel.TextSize = 15
        ValueLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
        ValueLabel.Parent = Frame
        
        local SliderBack = Instance.new("Frame")
        SliderBack.Size = UDim2.new(1, -18, 0, 7)
        SliderBack.Position = UDim2.new(0, 9, 1, -22)
        SliderBack.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
        SliderBack.BorderSizePixel = 0
        SliderBack.Parent = Frame
        
        local SliderBackCorner = Instance.new("UICorner")
        SliderBackCorner.CornerRadius = UDim.new(1, 0)
        SliderBackCorner.Parent = SliderBack
        
        local SliderFill = Instance.new("Frame")
        SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        SliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderBack
        
        local SliderFillCorner = Instance.new("UICorner")
        SliderFillCorner.CornerRadius = UDim.new(1, 0)
        SliderFillCorner.Parent = SliderFill
        
        local SliderButton = Instance.new("TextButton")
        SliderButton.Size = UDim2.new(1, 0, 1, 0)
        SliderButton.BackgroundTransparency = 1
        SliderButton.Text = ""
        SliderButton.Parent = SliderBack
        
        local dragging = false
        
        SliderButton.MouseButton1Down:Connect(function()
            dragging = true
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        SliderButton.MouseMoved:Connect(function(x)
            if dragging then
                local relativeX = math.clamp((x - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * relativeX)
                ValueLabel.Text = tostring(value)
                SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                callback(value)
            end
        end)
    end
    
    local function CreateButton(parent, name, icon, callback, tier)
        if not parent or UserTier < tier then return end
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 65)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        Frame.BackgroundTransparency = 0.18
        Frame.BorderSizePixel = 0
        Frame.Parent = parent
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 11)
        Corner.Parent = Frame
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(138, 43, 226)
        Stroke.Thickness = 1.3
        Stroke.Transparency = 0.7
        Stroke.Parent = Frame
        
        local IconFrame = Instance.new("Frame")
        IconFrame.Size = UDim2.new(0, 46, 0, 46)
        IconFrame.Position = UDim2.new(0, 9, 0.5, -23)
        IconFrame.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        IconFrame.BackgroundTransparency = 0.28
        IconFrame.BorderSizePixel = 0
        IconFrame.Parent = Frame
        
        local IconCorner = Instance.new("UICorner")
        IconCorner.CornerRadius = UDim.new(0, 9)
        IconCorner.Parent = IconFrame
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(1, 0, 1, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = icon
        IconLabel.Font = Enum.Font.GothamBold
        IconLabel.TextSize = 20
        IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        IconLabel.Parent = IconFrame
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -170, 1, 0)
        NameLabel.Position = UDim2.new(0, 63, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 14
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = Frame
        
        local ActionBtn = Instance.new("TextButton")
        ActionBtn.Size = UDim2.new(0, 92, 0, 37)
        ActionBtn.Position = UDim2.new(1, -105, 0.5, -18.5)
        ActionBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        ActionBtn.BackgroundTransparency = 0.18
        ActionBtn.Text = "USE"
        ActionBtn.Font = Enum.Font.GothamBold
        ActionBtn.TextSize = 14
        ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ActionBtn.BorderSizePixel = 0
        ActionBtn.Parent = Frame
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 9)
        BtnCorner.Parent = ActionBtn
        
        ActionBtn.MouseButton1Click:Connect(function()
            callback()
        end)
    end
    
    if CombatTab then
        CreateToggle(CombatTab, "Kill Aura", "K", function(enabled)
            Settings.KillAura = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Kill Aura" or "❌ Deactivated Kill Aura")
        end, 1)
        
        CreateToggle(CombatTab, "Anti AFK", "A", function(enabled)
            Settings.AntiAFK = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Anti AFK" or "❌ Deactivated Anti AFK")
        end, 1)
        
        CreateToggle(CombatTab, "God Mode", "G", function(enabled)
            Settings.GodMode = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated God Mode" or "❌ Deactivated God Mode")
        end, 1)
        
        CreateToggle(CombatTab, "Aimbot", "AB", function(enabled)
            Settings.Aimbot = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Aimbot" or "❌ Deactivated Aimbot")
        end, 1)
        
        CreateToggle(CombatTab, "Auto Click", "AC", function(enabled)
            Settings.AutoClick = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Auto Click" or "❌ Deactivated Auto Click")
            if enabled then
                StartAutoClick()
            else
                StopAutoClick()
            end
        end, 2)
        
        CreateSlider(CombatTab, "Kill Aura Range", "R", 10, 50, Settings.KillAuraRange, function(value)
            Settings.KillAuraRange = value
            SaveSettings()
        end, 1)
        
        local maxInterval = 10000
        local minInterval = 1000
        local tierLevel = 1
        
        if UserStatus == "DEVELOPER" then
            minInterval = 1
            maxInterval = 1000
            tierLevel = 1
        elseif UserStatus == "PREMIUM" or UserStatus == "FRIEND" then
            minInterval = 800
            maxInterval = 10000
            tierLevel = 1
        else
            minInterval = 1000
            maxInterval = 1000
            tierLevel = 1
        end
        
        CreateSlider(CombatTab, "Auto Click Interval (ms)", "CI", minInterval, maxInterval, Settings.AutoClickInterval, function(value)
            Settings.AutoClickInterval = value
            SaveSettings()
        end, tierLevel)
    end
    
    if MovementTab then
        CreateToggle(MovementTab, "Fly Mode", "F", function(enabled)
            Settings.Fly = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Fly Mode" or "❌ Deactivated Fly Mode")
            if enabled then
                StartFly()
            else
                StopFly()
            end
        end, 1)
        
        CreateToggle(MovementTab, "Speed Boost", "S", function(enabled)
            Settings.Speed = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Speed Boost" or "❌ Deactivated Speed Boost")
        end, 1)
        
        CreateToggle(MovementTab, "High Jump", "J", function(enabled)
            Settings.HighJump = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated High Jump" or "❌ Deactivated High Jump")
        end, 1)
        
        CreateToggle(MovementTab, "Noclip (Walk Through)", "NC", function(enabled)
            Settings.Noclip = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Noclip" or "❌ Deactivated Noclip")
        end, 1)
        
        CreateToggle(MovementTab, "Air Walk", "AW", function(enabled)
            Settings.AirWalk = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Air Walk" or "❌ Deactivated Air Walk")
            if enabled then
                StartAirWalk()
            else
                StopAirWalk()
            end
        end, 1)
        
        CreateToggle(MovementTab, "Auto Safe", "AS", function(enabled)
            Settings.AutoSafe = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Auto Safe" or "❌ Deactivated Auto Safe")
        end, 1)
        
        CreateSlider(MovementTab, "Fly Speed", "FS", 50, 300, Settings.FlySpeed, function(value)
            Settings.FlySpeed = value
            SaveSettings()
        end, 1)
        
        CreateSlider(MovementTab, "Walk Speed", "WS", 16, 200, Settings.SpeedValue, function(value)
            Settings.SpeedValue = value
            SaveSettings()
        end, 1)
        
        CreateSlider(MovementTab, "Jump Power", "JP", 50, 300, Settings.JumpPower, function(value)
            Settings.JumpPower = value
            SaveSettings()
        end, 1)
    end
    
    if PlayerTab then
        CreateToggle(PlayerTab, "Invisible", "I", function(enabled)
            Settings.Invisible = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Invisible" or "❌ Deactivated Invisible")
        end, 1)
        
        CreateButton(PlayerTab, "Teleport to Player", "TP", function()
            CreatePlayerSelector("teleport")
        end, 1)
        
        CreateButton(PlayerTab, "Bring Player", "B", function()
            CreatePlayerSelector("bring")
        end, 2)
        
        CreateButton(PlayerTab, "Kick Player", "X", function()
            CreatePlayerSelector("kick")
        end, 2)
        
        CreateButton(PlayerTab, "Copy Avatar", "AV", function()
            CreateAvatarCopyUI()
        end, 1)
        
        CreateToggle(PlayerTab, "Show Name Tag", "NT", function(enabled)
            Settings.ShowNameTag = enabled
            SaveSettings()
            if enabled and Settings.CustomNameTag ~= "" then
                ApplyNameTag(Settings.CustomNameTag)
            else
                ClearNameTag()
            end
            SendDeveloperWebhook(enabled and "✅ Activated Name Tag" or "❌ Deactivated Name Tag")
        end, 1)
        
        CreateButton(PlayerTab, "Customize Name Tag", "CN", function()
            CreateNameTagEditor()
        end, 1)
        
        CreateButton(PlayerTab, "Clear Name Tag", "CLR", function()
            ClearNameTag()
        end, 1)
    end
    
    if WorldTab then
        CreateButton(WorldTab, "Music Player", "MP", function()
            CreateMusicPlayer()
        end, 1)
        
        CreateButton(WorldTab, "Save Location", "L", function()
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                Settings.SavedPosition = char.HumanoidRootPart.CFrame
                SaveSettings()
                CreateNotification("ANTC HUB", "Location saved successfully", 3, Color3.fromRGB(0, 255, 150))
            end
        end, 1)
        
        CreateButton(WorldTab, "Teleport to Saved", "T", function()
            if Settings.SavedPosition then
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = Settings.SavedPosition
                    CreateNotification("ANTC HUB", "Teleported to saved location", 3, Color3.fromRGB(0, 255, 150))
                end
            else
                CreateNotification("ANTC HUB", "No saved location", 3, Color3.fromRGB(255, 100, 100))
            end
        end, 1)
        
        CreateToggle(WorldTab, "Respawn at Saved", "RS", function(enabled)
            Settings.RespawnAtSaved = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Respawn at Saved" or "❌ Deactivated Respawn at Saved")
        end, 1)
        
        CreateToggle(WorldTab, "Safe Zone", "SZ", function(enabled)
            Settings.SafeZoneActive = enabled
            if enabled then
                ActivateSafeZone()
            else
                DeactivateSafeZone()
            end
            SaveSettings()
        end, 2)
    end
    
    if CheckpointTab then
        CreateButton(CheckpointTab, "Create Checkpoint", "CP", function()
            CreateCheckpointDialog()
        end, 1)
        
        CreateButton(CheckpointTab, "View All Locations", "📍", function()
            ViewAllCheckpoints()
        end, 1)
        
        RefreshCheckpointList(CheckpointTab)
    end
    
    if PremiumTab then
        CreateButton(PremiumTab, "Fling/Kick Player", "FK", function()
            CreatePlayerSelector("fling")
        end, 2)
        
        CreateButton(PremiumTab, "Advanced Teleport", "AT", function()
            CreateAdvancedTeleport()
        end, 2)
        
        CreateButton(PremiumTab, "Premium Music Player", "PM", function()
            CreateMusicPlayer()
        end, 2)
        
        CreateToggle(PremiumTab, "Auto Farm (Coming Soon)", "AF", function(enabled)
            CreateNotification("ANTC HUB", "Auto Farm feature coming in next update!", 3, Color3.fromRGB(255, 215, 0))
        end, 2)
        
        CreateToggle(PremiumTab, "ESP Players", "ESP", function(enabled)
            Settings.ESP = enabled
            SaveSettings()
        end, 2)
    end
    
    if DeveloperTab then
        CreateButton(DeveloperTab, "Player List", "PL", function()
            CreatePlayerListViewer()
        end, 3)
        
        CreateButton(DeveloperTab, "Spectate Player", "SP", function()
            CreatePlayerSelector("spectate")
        end, 3)
        
        CreateButton(DeveloperTab, "Ban Player", "BP", function()
            CreatePlayerSelector("ban")
        end, 3)
        
        CreateButton(DeveloperTab, "Give Item (Model ID)", "GI", function()
            CreateGiveItemUI()
        end, 3)
        
        CreateButton(DeveloperTab, "Copy Any Avatar", "CA", function()
            CreateAvatarCopyUI()
        end, 3)
        
        CreateButton(DeveloperTab, "Play Music", "MU", function()
            CreateMusicPlayer()
        end, 3)
        
        CreateButton(DeveloperTab, "Stop Music", "SM", function()
            if Workspace:FindFirstChild("ANTC_Music") then
                Workspace.ANTC_Music:Destroy()
                CreateNotification("ANTC HUB", "Music stopped!", 3, Color3.fromRGB(255, 100, 100))
            else
                CreateNotification("ANTC HUB", "No music is playing", 3, Color3.fromRGB(255, 150, 50))
            end
        end, 3)
        
        CreateButton(DeveloperTab, "Configure Webhook", "WH", function()
            CreateWebhookConfigUI()
        end, 3)
    end
    
    if SettingsTab then
        -- Key Verification Status Frame
        local VerifyFrame = Instance.new("Frame")
        VerifyFrame.Size = UDim2.new(1, 0, 0, 85)
        VerifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        VerifyFrame.BackgroundTransparency = 0.18
        VerifyFrame.BorderSizePixel = 0
        VerifyFrame.Parent = SettingsTab
        
        local VerifyCorner = Instance.new("UICorner")
        VerifyCorner.CornerRadius = UDim.new(0, 11)
        VerifyCorner.Parent = VerifyFrame
        
        local VerifyStroke = Instance.new("UIStroke")
        VerifyStroke.Color = IsLifetimeKey and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 100, 100)
        VerifyStroke.Thickness = 1.3
        VerifyStroke.Transparency = 0.7
        VerifyStroke.Parent = VerifyFrame
        
        local VerifyIconFrame = Instance.new("Frame")
        VerifyIconFrame.Size = UDim2.new(0, 46, 0, 46)
        VerifyIconFrame.Position = UDim2.new(0, 9, 0, 9)
        VerifyIconFrame.BackgroundColor3 = IsLifetimeKey and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 100, 100)
        VerifyIconFrame.BackgroundTransparency = 0.28
        VerifyIconFrame.BorderSizePixel = 0
        VerifyIconFrame.Parent = VerifyFrame
        
        local VerifyIconCorner = Instance.new("UICorner")
        VerifyIconCorner.CornerRadius = UDim.new(0, 9)
        VerifyIconCorner.Parent = VerifyIconFrame
        
        local VerifyIconLabel = Instance.new("TextLabel")
        VerifyIconLabel.Size = UDim2.new(1, 0, 1, 0)
        VerifyIconLabel.BackgroundTransparency = 1
        VerifyIconLabel.Text = IsLifetimeKey and "✓" or "✗"
        VerifyIconLabel.Font = Enum.Font.GothamBold
        VerifyIconLabel.TextSize = 24
        VerifyIconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        VerifyIconLabel.Parent = VerifyIconFrame
        
        local VerifyTitleLabel = Instance.new("TextLabel")
        VerifyTitleLabel.Size = UDim2.new(1, -135, 0, 28)
        VerifyTitleLabel.Position = UDim2.new(0, 63, 0, 12)
        VerifyTitleLabel.BackgroundTransparency = 1
        VerifyTitleLabel.Text = "Key Status"
        VerifyTitleLabel.Font = Enum.Font.GothamBold
        VerifyTitleLabel.TextSize = 14
        VerifyTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        VerifyTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        VerifyTitleLabel.Parent = VerifyFrame
        
        local VerifyStatusLabel = Instance.new("TextLabel")
        VerifyStatusLabel.Size = UDim2.new(1, -70, 0, 30)
        VerifyStatusLabel.Position = UDim2.new(0, 63, 0, 45)
        VerifyStatusLabel.BackgroundTransparency = 1
        VerifyStatusLabel.Text = IsLifetimeKey and "✓ VERIFIED (Lifetime)" or "✗ NO VERIFIED"
        VerifyStatusLabel.Font = Enum.Font.GothamBold
        VerifyStatusLabel.TextSize = 13
        VerifyStatusLabel.TextColor3 = IsLifetimeKey and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 100, 100)
        VerifyStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        VerifyStatusLabel.Parent = VerifyFrame
        
        CreateButton(SettingsTab, "Return to Keys Menu", "K", function()
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            task.wait(0.4)
            MainFrame:Destroy()
            
            if MinimizedFrame then
                MinimizedFrame:Destroy()
                MinimizedFrame = nil
            end
            
            KeyVerified = false
            CreateNotification("ANTC HUB", "Returned to Keys Menu", 3, Color3.fromRGB(100, 150, 255))
            task.wait(0.3)
            CreateKeySystem()
        end, 1)
        
        CreateButton(SettingsTab, "Script Info", "I", function()
            CreateScriptInfo()
        end, 1)
        
        CreateToggle(SettingsTab, "Anti-Kick Bypass", "AK", function(enabled)
            Settings.AntiKick = enabled
            SaveSettings()
            SendDeveloperWebhook(enabled and "✅ Activated Anti-Kick Bypass" or "❌ Deactivated Anti-Kick Bypass")
        end, 1)
        
        CreateSlider(SettingsTab, "GUI Scale", "SC", 50, 150, Settings.GUIScale * 100, function(value)
            Settings.GUIScale = value / 100
            SaveSettings()
            CreateNotification("ANTC HUB", "GUI Scale updated! Reload to apply.", 3, Color3.fromRGB(100, 200, 255))
        end, 1)
    end
    
    if MainLoop then
        MainLoop:Disconnect()
    end
    
    task.spawn(function()
        task.wait(0.3)
        if Settings.ShowNameTag and Settings.CustomNameTag ~= "" then
            ApplyNameTag(Settings.CustomNameTag)
        end
    end)
    
    MainLoop = RunService.Heartbeat:Connect(function()
        local char = Player.Character
        if not char then return end
        
        local humanoid = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not hrp then return end
        
        if Settings.Speed then
            if humanoid.WalkSpeed ~= Settings.SpeedValue then
                humanoid.WalkSpeed = Settings.SpeedValue
            end
        else
            if humanoid.WalkSpeed ~= 16 then
                humanoid.WalkSpeed = 16
            end
        end
        
        if Settings.HighJump then
            if humanoid.JumpPower ~= Settings.JumpPower then
                humanoid.JumpPower = Settings.JumpPower
            end
        else
            if humanoid.JumpPower ~= 50 then
                humanoid.JumpPower = 50
            end
        end
        
        if Settings.Noclip then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        if Settings.Invisible then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") then
                    part.Handle.Transparency = 1
                end
            end
            if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then
                char.Head.face.Transparency = 1
            end
        else
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                elseif part:IsA("Accessory") then
                    part.Handle.Transparency = 0
                end
            end
            if char:FindFirstChild("Head") and char.Head:FindFirstChild("face") then
                char.Head.face.Transparency = 0
            end
        end
        
        if Settings.GodMode then
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end
        
        if Settings.KillAura then
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= Player and targetPlayer.Character then
                    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetHum = targetPlayer.Character:FindFirstChild("Humanoid")
                    if targetHRP and targetHum and targetHum.Health > 0 then
                        local distance = (hrp.Position - targetHRP.Position).Magnitude
                        if distance <= Settings.KillAuraRange then
                            local tool = char:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                    end
                end
            end
        end
        
        if Settings.AntiAFK then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)
        end
        
        if Settings.AutoSafe and hrp then
            if hrp.Position.Y < -50 then
                if Settings.SavedPosition then
                    hrp.CFrame = Settings.SavedPosition
                else
                    hrp.CFrame = CFrame.new(0, 50, 0)
                end
            end
        end
    end)
end

Player.CharacterAdded:Connect(function(char)
    if Settings.RespawnAtSaved and Settings.SavedPosition then
        char:WaitForChild("HumanoidRootPart").CFrame = Settings.SavedPosition
    end
    
    if Settings.ShowNameTag and Settings.CustomNameTag ~= "" then
        task.wait(0.5)
        ApplyNameTag(Settings.CustomNameTag)
    end
end)

LoadSettings()
CreateKeySystem()
