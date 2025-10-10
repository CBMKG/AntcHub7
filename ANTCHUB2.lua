x1a2b3c = game.GetService
local _0xDEADBEEF = math.random(100000, 999999)
local _0xCAFEBABE = tick()
local _0x5f4e3d = {os.time(), os.clock(), tick()}
local function _0xA1B2C3() return math.random(1, 100) end
local function _0xD4E5F6() return string.char(65 + math.random(0, 25)) end
_G.ANTC_PROTECTED = true

local Players = _0x1a2b3c(game, "Players")
local UserInputService = _0x1a2b3c(game, "UserInputService")
local RunService = _0x1a2b3c(game, "RunService")
local TweenService = _0x1a2b3c(game, "TweenService")
local CoreGui = _0x1a2b3c(game, "CoreGui")
local VirtualInputManager = _0x1a2b3c(game, "VirtualInputManager")
local Workspace = _0x1a2b3c(game, "Workspace")
local HttpService = _0x1a2b3c(game, "HttpService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local _0xF1A2B3 = string.char
local _0xC4D5E6 = string.byte
local function _0x7G8H9I(s) return s end
local WEBHOOK_URL = _0x7G8H9I("https://workspace.bano99039.repl.co/webhook/verify")
local KEY_TRACKING_WEBHOOK = _0x7G8H9I("https://discord.com/api/webhooks/1426164365479907348/4eRQsOY2rp996FZb70FDAwiEmM1VQgwE3vhMscRgF_Hq4FA2c4KiTIUR-RyyH79ORDti")
local DISCORD_INVITE = "https://" .. "discord" .. ".gg/" .. "antchub"

-- Anti-Tamper Protection
local function _0xANTITAMPER() 
    local _check = tick() * os.clock()
    if _check < 0 then return false end
    return true 
end
local _0xVERIFY = _0xANTITAMPER()

-- Multi-Language Support System
local CurrentLanguage = "en"
local Languages = {
    en = {
        join_discord = "Join our Discord Server!",
        discord_text = "Join for updates, support, and premium features!",
        key_expire_soon = "Key expires in:",
        key_expired = "Key has expired!",
        fly_enabled = "Fly mode enabled! Use WASD + Space/Shift (PC Only)",
        fly_air_walk = "Air Walk enabled at current position!",
        player_joined = "Player joined",
        player_left = "Player left",
        player_died = "died",
        tracking_afk = "AFK detected",
        map_name = "Map",
        time_label = "Time"
    },
    id = {
        join_discord = "Gabung Discord Server Kami!",
        discord_text = "Gabung untuk update, bantuan, dan fitur premium!",
        key_expire_soon = "Key kadaluarsa dalam:",
        key_expired = "Key sudah kadaluarsa!",
        fly_enabled = "Mode terbang aktif! Gunakan WASD + Space/Shift (PC Saja)",
        fly_air_walk = "Jalan di udara aktif di posisi saat ini!",
        player_joined = "Player masuk",
        player_left = "Player keluar",
        player_died = "mati",
        tracking_afk = "AFK terdeteksi",
        map_name = "Map",
        time_label = "Waktu"
    },
    ru = {
        join_discord = "Присоединяйтесь к нашему Discord серверу!",
        discord_text = "Присоединяйтесь для обновлений, поддержки и премиум функций!",
        key_expire_soon = "Ключ истекает через:",
        key_expired = "Ключ истек!",
        fly_enabled = "Режим полета включен! Используйте WASD + Пробел/Shift (только ПК)",
        fly_air_walk = "Ходьба по воздуху включена на текущей позиции!",
        player_joined = "Игрок присоединился",
        player_left = "Игрок вышел",
        player_died = "умер",
        tracking_afk = "Обнаружен AFK",
        map_name = "Карта",
        time_label = "Время"
    },
    es = {
        join_discord = "¡Únete a nuestro servidor de Discord!",
        discord_text = "¡Únete para actualizaciones, soporte y funciones premium!",
        key_expire_soon = "La clave expira en:",
        key_expired = "¡La clave ha expirado!",
        fly_enabled = "¡Modo vuelo activado! Usa WASD + Espacio/Shift (solo PC)",
        fly_air_walk = "¡Caminar en el aire activado en la posición actual!",
        player_joined = "Jugador unido",
        player_left = "Jugador salió",
        player_died = "murió",
        tracking_afk = "AFK detectado",
        map_name = "Mapa",
        time_label = "Hora"
    }
}

local function GetText(key)
    return Languages[CurrentLanguage][key] or Languages.en[key] or key
end

local Settings = {
    Language = "en",
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
    CustomStatusText = "https://discord.gg/antchub",
    ShowStatusText = true,
    SafeZoneActive = false,
    SafeZoneOriginalPos = nil,
    SafeZonePlatformColor = Color3.fromRGB(138, 43, 226),
    SafeZoneCustomLocation = nil,
    BannerImageID = "5554236805",
    AutoClick = false,
    AutoClickInterval = 1000,
    AirWalk = false,
    AutoSafe = false,
    ThemeColor = "dark",
    GUITheme = {
        Background = Color3.fromRGB(10, 10, 20),
        Primary = Color3.fromRGB(138, 43, 226),
        Secondary = Color3.fromRGB(20, 20, 35),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

local UserStatus = "GUEST"
local UserTier = 1
local KeyVerified = false
local Checkpoints = {}
local BannedPlayers = {}
local GeneratedKeys = {}
local DeveloperCreatedKeys = {}
local SpectateExitButton = nil
local SavedAvatar = nil
local KeyExpiryTime = nil
local IsLifetimeKey = false
local SavedKeyData = nil
local FlyEnabled = false
local FlyConnection = nil
local DeveloperActivityWebhook = "https://discord.com/api/webhooks/1426164604760883301/1JalHle9tudm0OY-HIkqWp4tacqAEhvqbiMid-o1uZO6O_BlIGy58njTSDrT-fLhbQQd"
local BasicUserWebhook = ""
local PerformanceData = {}
local MaxDataPoints = 60
local CurrentSpectateTarget = nil
local MinimizedFrame = nil
local MainLoop = nil
local AutoClickConnection = nil
local AutoClickInterval = 1000
local AirWalkPart = nil
local SafeZonePlatform = nil
local SafeZoneFollowConnection = nil
local FlyStartPosition = nil
local DiscordNotificationShown = false
local PerformanceData = {}
local PerformanceGraphFrame = nil

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

local function LoadKeyData()
    if isfile and readfile then
        local success, fileExists = pcall(function()
            return isfile("ANTC_HUB_KeyData.json")
        end)
        
        if success and fileExists then
            local readSuccess, data = pcall(function()
                return HttpService:JSONDecode(readfile("ANTC_HUB_KeyData.json"))
            end)
            if readSuccess and data then
                SavedKeyData = data
            end
        end
    end
end

local function SaveKeyData(keyData)
    if writefile then
        local success, err = pcall(function()
            writefile("ANTC_HUB_KeyData.json", HttpService:JSONEncode(keyData))
        end)
        if success then
            SavedKeyData = keyData
        end
    end
end

local function ClearKeyData()
    if delfile then
        pcall(function()
            delfile("ANTC_HUB_KeyData.json")
        end)
    end
    SavedKeyData = nil
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

local function LoadDeveloperKeys()
    if isfile and readfile then
        local success, fileExists = pcall(function()
            return isfile("ANTC_Developer_Keys.json")
        end)
        
        if success and fileExists then
            local readSuccess, data = pcall(function()
                return HttpService:JSONDecode(readfile("ANTC_Developer_Keys.json"))
            end)
            if readSuccess and data then
                DeveloperCreatedKeys = data
            end
        end
    end
end

local function SaveDeveloperKeys()
    if writefile then
        pcall(function()
            writefile("ANTC_Developer_Keys.json", HttpService:JSONEncode(DeveloperCreatedKeys))
        end)
    end
end

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "ANTC_Notifications"
NotificationGui.ResetOnSpawn = false
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotificationGui.DisplayOrder = 999

-- Delta/Executor compatibility
local success = pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(NotificationGui)
        NotificationGui.Parent = CoreGui
    elseif gethui then
        NotificationGui.Parent = gethui()
    elseif game:GetService("CoreGui") then
        NotificationGui.Parent = CoreGui
    else
        NotificationGui.Parent = Player:WaitForChild("PlayerGui")
    end
end)

if not success then
    NotificationGui.Parent = Player:WaitForChild("PlayerGui")
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

local function CreateDiscordJoinNotification(parentGui)
    if DiscordNotificationShown then return end
    DiscordNotificationShown = true
    
    local DiscordFrame = Instance.new("Frame")
    DiscordFrame.Size = UDim2.new(0, 500, 0, 160)
    DiscordFrame.Position = UDim2.new(0.5, -250, 0.5, -80)
    DiscordFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    DiscordFrame.BackgroundTransparency = 0.05
    DiscordFrame.BorderSizePixel = 0
    DiscordFrame.ZIndex = 1000
    DiscordFrame.Parent = parentGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 20)
    Corner.Parent = DiscordFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 0, 0)
    Stroke.Thickness = 3
    Stroke.Transparency = 0
    Stroke.Parent = DiscordFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 15, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
    }
    Gradient.Parent = DiscordFrame
    
    task.spawn(function()
        local hue = 0
        while DiscordFrame.Parent do
            hue = (hue + 0.01) % 1
            Stroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.03)
        end
    end)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0, 20, 0.5, -30)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://3570695787"
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = DiscordFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 0, 40)
    Title.Position = UDim2.new(0, 90, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🎮 JOIN OUR DISCORD SERVER"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = DiscordFrame
    
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    TitleGradient.Parent = Title
    
    local SubText = Instance.new("TextLabel")
    SubText.Size = UDim2.new(1, -100, 0, 55)
    SubText.Position = UDim2.new(0, 90, 0, 55)
    SubText.BackgroundTransparency = 1
    SubText.Text = "Get premium updates, exclusive features, support & giveaways!"
    SubText.Font = Enum.Font.GothamBold
    SubText.TextSize = 15
    SubText.TextColor3 = Color3.fromRGB(200, 200, 255)
    SubText.TextXAlignment = Enum.TextXAlignment.Left
    SubText.TextWrapped = true
    SubText.Parent = DiscordFrame
    
    local JoinButton = Instance.new("TextButton")
    JoinButton.Size = UDim2.new(0, 130, 0, 40)
    JoinButton.Position = UDim2.new(0, 90, 1, -55)
    JoinButton.BackgroundColor3 = Color3.fromRGB(67, 181, 129)
    JoinButton.Text = "Join Discord"
    JoinButton.Font = Enum.Font.GothamBold
    JoinButton.TextSize = 16
    JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinButton.BorderSizePixel = 0
    JoinButton.Parent = DiscordFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = JoinButton
    
    JoinButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(DISCORD_INVITE)
            CreateNotification("ANTC HUB", "Discord invite copied to clipboard!", 3, Color3.fromRGB(88, 101, 242))
        end
    end)
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -50, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 82, 82)
    CloseBtn.BackgroundTransparency = 0.1
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = DiscordFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(DiscordFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.3)
        DiscordFrame:Destroy()
    end)
    
    DiscordFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(DiscordFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 160)
    }):Play()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ANTC_HUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 100

-- Delta/Executor compatibility
local guiSuccess = pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    elseif game:GetService("CoreGui") then
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
    end
end)

if not guiSuccess then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

local function CreateInitialLoadingScreen(callback)
    local LoadScreen = Instance.new("Frame")
    LoadScreen.Name = "InitialLoadScreen"
    LoadScreen.Size = UDim2.new(1, 0, 1, 0)
    LoadScreen.Position = UDim2.new(0, 0, 0, 0)
    LoadScreen.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
    LoadScreen.BorderSizePixel = 0
    LoadScreen.ZIndex = 999
    LoadScreen.Parent = ScreenGui
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 5, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 10, 25))
    }
    Gradient.Rotation = 90
    Gradient.Parent = LoadScreen
    
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
    ParticleContainer.BackgroundTransparency = 1
    ParticleContainer.ZIndex = 1000
    ParticleContainer.Parent = LoadScreen
    
    for i = 1, 15 do
        local Particle = Instance.new("Frame")
        Particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
        Particle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        Particle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Particle.BackgroundTransparency = math.random(50, 80) / 100
        Particle.BorderSizePixel = 0
        Particle.ZIndex = 1001
        Particle.Parent = ParticleContainer
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(1, 0)
        Corner.Parent = Particle
        
        task.spawn(function()
            while Particle and Particle.Parent do
                TweenService:Create(Particle, TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0),
                    BackgroundTransparency = math.random(30, 90) / 100
                }):Play()
                task.wait(math.random(3, 6))
            end
        end)
    end
    
    local LogoContainer = Instance.new("Frame")
    LogoContainer.Size = UDim2.new(0, 500, 0, 250)
    LogoContainer.Position = UDim2.new(0.5, -250, 0.45, -125)
    LogoContainer.BackgroundTransparency = 1
    LogoContainer.ZIndex = 1005
    LogoContainer.Parent = LoadScreen
    
    local GlowCircle = Instance.new("ImageLabel")
    GlowCircle.Size = UDim2.new(0, 300, 0, 300)
    GlowCircle.Position = UDim2.new(0.5, -150, 0, -50)
    GlowCircle.BackgroundTransparency = 1
    GlowCircle.Image = "rbxassetid://5554236805"
    GlowCircle.ImageColor3 = Color3.fromRGB(138, 43, 226)
    GlowCircle.ImageTransparency = 0.7
    GlowCircle.ZIndex = 1003
    GlowCircle.Parent = LogoContainer
    
    task.spawn(function()
        while GlowCircle and GlowCircle.Parent do
            TweenService:Create(GlowCircle, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.85,
                Size = UDim2.new(0, 320, 0, 320)
            }):Play()
            task.wait(4)
        end
    end)
    
    local MainLogo = Instance.new("TextLabel")
    MainLogo.Size = UDim2.new(1, 0, 0, 90)
    MainLogo.Position = UDim2.new(0, 0, 0, 0)
    MainLogo.BackgroundTransparency = 1
    MainLogo.Text = "ANTC HUB"
    MainLogo.Font = Enum.Font.GothamBold
    MainLogo.TextSize = 68
    MainLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainLogo.TextTransparency = 1
    MainLogo.TextStrokeTransparency = 1
    MainLogo.TextStrokeColor3 = Color3.fromRGB(138, 43, 226)
    MainLogo.ZIndex = 1006
    MainLogo.Parent = LogoContainer
    
    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    LogoGradient.Parent = MainLogo
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Size = UDim2.new(1, 0, 0, 35)
    SubTitle.Position = UDim2.new(0, 0, 0, 95)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Text = "✦ ULTIMATE PROFESSIONAL EDITION ✦"
    SubTitle.Font = Enum.Font.GothamBold
    SubTitle.TextSize = 18
    SubTitle.TextColor3 = Color3.fromRGB(200, 180, 255)
    SubTitle.TextTransparency = 1
    SubTitle.ZIndex = 1006
    SubTitle.Parent = LogoContainer
    
    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 0, 28)
    StatusText.Position = UDim2.new(0, 0, 0, 145)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "⚡ Initializing System..."
    StatusText.Font = Enum.Font.GothamBold
    StatusText.TextSize = 15
    StatusText.TextColor3 = Color3.fromRGB(138, 43, 226)
    StatusText.TextTransparency = 1
    StatusText.ZIndex = 1006
    StatusText.Parent = LogoContainer
    
    local ProgressBarBG = Instance.new("Frame")
    ProgressBarBG.Size = UDim2.new(0, 400, 0, 8)
    ProgressBarBG.Position = UDim2.new(0.5, -200, 0, 190)
    ProgressBarBG.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    ProgressBarBG.BorderSizePixel = 0
    ProgressBarBG.BackgroundTransparency = 1
    ProgressBarBG.ZIndex = 1005
    ProgressBarBG.Parent = LogoContainer
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBarBG
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.ZIndex = 1006
    ProgressBar.Parent = ProgressBarBG
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = ProgressBar
    
    local BarGlow = Instance.new("UIGradient")
    BarGlow.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 30, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
    }
    BarGlow.Parent = ProgressBar
    
    local BarGlowEffect = Instance.new("ImageLabel")
    BarGlowEffect.Size = UDim2.new(1, 20, 1, 20)
    BarGlowEffect.Position = UDim2.new(0, -10, 0, -10)
    BarGlowEffect.BackgroundTransparency = 1
    BarGlowEffect.Image = "rbxassetid://5554236805"
    BarGlowEffect.ImageColor3 = Color3.fromRGB(138, 43, 226)
    BarGlowEffect.ImageTransparency = 0.5
    BarGlowEffect.ZIndex = 1005
    BarGlowEffect.Parent = ProgressBar
    
    local VersionText = Instance.new("TextLabel")
    VersionText.Size = UDim2.new(0, 300, 0, 25)
    VersionText.Position = UDim2.new(0.5, -150, 1, -50)
    VersionText.BackgroundTransparency = 1
    VersionText.Text = "◆ Version 5.0 Pro Edition ◆"
    VersionText.Font = Enum.Font.GothamBold
    VersionText.TextSize = 12
    VersionText.TextColor3 = Color3.fromRGB(120, 120, 150)
    VersionText.TextTransparency = 1
    VersionText.ZIndex = 1006
    VersionText.Parent = LoadScreen
    
    local CopyrightText = Instance.new("TextLabel")
    CopyrightText.Size = UDim2.new(0, 400, 0, 20)
    CopyrightText.Position = UDim2.new(0.5, -200, 1, -25)
    CopyrightText.BackgroundTransparency = 1
    CopyrightText.Text = "Powered by ANTC Store & Team TRX"
    CopyrightText.Font = Enum.Font.Gotham
    CopyrightText.TextSize = 10
    CopyrightText.TextColor3 = Color3.fromRGB(80, 80, 100)
    CopyrightText.TextTransparency = 1
    CopyrightText.ZIndex = 1006
    CopyrightText.Parent = LoadScreen
    
    TweenService:Create(MainLogo, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        TextStrokeTransparency = 0.8
    }):Play()
    
    task.spawn(function()
        while MainLogo and MainLogo.Parent do
            TweenService:Create(MainLogo, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                TextSize = 72
            }):Play()
            task.wait(3)
        end
    end)
    
    task.wait(0.4)
    
    TweenService:Create(SubTitle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    task.wait(0.4)
    
    TweenService:Create(StatusText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    TweenService:Create(ProgressBarBG, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.2
    }):Play()
    
    TweenService:Create(VersionText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    TweenService:Create(CopyrightText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    task.wait(0.6)
    
    local loadingSteps = {
        {text = "🔐 Loading Security Module...", progress = 0.15},
        {text = "⚙️ Initializing Core Features...", progress = 0.35},
        {text = "🌐 Connecting to Services...", progress = 0.55},
        {text = "✅ Verifying License System...", progress = 0.75},
        {text = "🔥 Loading Complete!", progress = 1}
    }
    
    for i, step in ipairs(loadingSteps) do
        StatusText.Text = step.text
        TweenService:Create(ProgressBar, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Size = UDim2.new(step.progress, 0, 1, 0)
        }):Play()
        
        if i == #loadingSteps then
            TweenService:Create(StatusText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextColor3 = Color3.fromRGB(0, 255, 150)
            }):Play()
        end
        task.wait(0.6)
    end
    
    task.wait(0.4)
    
    TweenService:Create(LoadScreen, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(ParticleContainer, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, -1, 0)
    }):Play()
    
    TweenService:Create(MainLogo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        Position = UDim2.new(0, 0, -0.2, 0)
    }):Play()
    
    TweenService:Create(SubTitle, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(StatusText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(ProgressBarBG, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(GlowCircle, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(VersionText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(CopyrightText, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    task.wait(0.6)
    LoadScreen:Destroy()
    
    if callback then
        callback()
    end
end

local function CreateKeySystem()
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 420, 0, 405)
    KeyFrame.Position = UDim2.new(0.5, -210, 0.5, -202)
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
    
    local FreePremiumBtn = Instance.new("TextButton")
    FreePremiumBtn.Size = UDim2.new(0, 180, 0, 38)
    FreePremiumBtn.Position = UDim2.new(0.5, -90, 0, 313)
    FreePremiumBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
    FreePremiumBtn.BackgroundTransparency = 0.15
    FreePremiumBtn.BorderSizePixel = 0
    FreePremiumBtn.Text = "FREE PREMIUM (24H)"
    FreePremiumBtn.Font = Enum.Font.GothamBold
    FreePremiumBtn.TextSize = 13
    FreePremiumBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FreePremiumBtn.Parent = KeyFrame
    
    local FreePremiumCorner = Instance.new("UICorner")
    FreePremiumCorner.CornerRadius = UDim.new(0, 10)
    FreePremiumCorner.Parent = FreePremiumBtn
    
    FreePremiumBtn.MouseButton1Click:Connect(function()
        KeyBox.Text = "FREE-PREMIUM-1DAY"
        CreateNotification("ANTC HUB", "Free Premium key added! Click VERIFY to activate.", 3, Color3.fromRGB(0, 255, 150))
    end)
    
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
    
    local KeyBtnStroke = Instance.new("UIStroke")
    KeyBtnStroke.Color = Color3.fromRGB(100, 150, 255)
    KeyBtnStroke.Thickness = 1.5
    KeyBtnStroke.Transparency = 0.5
    KeyBtnStroke.Parent = GetKeyBtn
    
    task.spawn(function()
        while GetKeyBtn and GetKeyBtn.Parent do
            TweenService:Create(KeyBtnStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Transparency = 0.2
            }):Play()
            task.wait(2.4)
        end
    end)
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        GetKeyBtn.Text = "GENERATING KEY..."
        LoadingBar.Visible = true
        LoadingBar.Size = UDim2.new(0, 0, 0, 4)
        
        local colorTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        })
        colorTween:Play()
        
        local glowTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.05
        })
        glowTween:Play()
        
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
        
        glowTween:Cancel()
        GetKeyBtn.BackgroundTransparency = 0.15
        
        local randomKey = GenerateRandomKey()
        KeyBox.Text = randomKey
        
        local successTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        })
        successTween:Play()
        
        local bounceTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 190, 0, 42)
        })
        bounceTween:Play()
        GetKeyBtn.Text = "✓ KEY GENERATED!"
        
        task.wait(0.4)
        local resetSizeTween = TweenService:Create(GetKeyBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 180, 0, 38)
        })
        resetSizeTween:Play()
        
        task.wait(0.8)
        
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
    InfoText.Text = "Era baru antc store dan tim trx "
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
            if keyType == "DEVELOPMENT" or keyType == "COFOUNDER" then
                if Player.Name ~= "Evos9loryy" then
                    CreateNotification("ANTC HUB", "Anda bukan developer!\nAkses ditolak.", 5, Color3.fromRGB(255, 50, 50))
                    task.wait(2)
                    Player:Kick("Anda bukan developer. Akses ditolak!")
                    return
                end
            end
            
            KeyVerified = true
            
            local keyData = {
                key = key,
                keyType = keyType,
                userStatus = "",
                userTier = 0,
                isLifetime = false,
                expiryTime = nil,
                savedTime = os.time()
            }
            
            if keyType == "DEVELOPMENT" then
                UserStatus = "DEVELOPER"
                UserTier = 3
                local devMessage = "FOUNDER ACCESS GRANTED!"
                if webhookData and webhookData.isLifetime then
                    devMessage = devMessage .. " (Lifetime)"
                    IsLifetimeKey = true
                end
                if webhookData and webhookData.dev then
                    devMessage = devMessage .. " - " .. webhookData.dev
                end
                
                Settings.CustomNameTag = "Founder ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Founder ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Founder ANTC HUB", 3, Color3.fromRGB(138, 43, 226))
                end)
            
            elseif keyType == "COFOUNDER" then
                UserStatus = "CO FOUNDER"
                UserTier = 3
                IsLifetimeKey = true
                
                Settings.CustomNameTag = "Co Founder ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Co Founder ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Co Founder ANTC HUB", 3, Color3.fromRGB(255, 100, 255))
                end)
                
                CreateNotification("ANTC HUB", "🌟 CO FOUNDER ACCESS GRANTED! Welcome Co Founder!", 5, Color3.fromRGB(255, 100, 255))
            
            elseif keyType == "PARTNER" then
                UserStatus = "PARTNER"
                UserTier = 3
                IsLifetimeKey = true
                
                Settings.CustomNameTag = "PARTNER ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("PARTNER ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Partner name tag applied!", 3, Color3.fromRGB(255, 215, 0))
                end)
                
                CreateNotification("ANTC HUB", "🤝 PARTNER ACCESS GRANTED! Welcome Partner!", 5, Color3.fromRGB(255, 215, 0))
            
            elseif keyType == "STAFF" then
                UserStatus = "STAFF"
                UserTier = 3
                IsLifetimeKey = true
                
                Settings.CustomNameTag = "STAFF ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("STAFF ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Staff name tag applied!", 3, Color3.fromRGB(100, 200, 255))
                end)
                
                CreateNotification("ANTC HUB", "👨‍💼 STAFF ACCESS GRANTED! Welcome Staff Member!", 5, Color3.fromRGB(100, 200, 255))
            
            elseif keyType == "FREE_PREMIUM" then
                UserStatus = "FREE PREMIUM"
                UserTier = 2
                IsLifetimeKey = false
                
                Settings.CustomNameTag = "Trail Premium ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Trail Premium ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Trail Premium ANTC HUB", 3, Color3.fromRGB(100, 200, 255))
                end)
                
                local hoursLeft = 24
                CreateNotification("ANTC HUB", "🎁 Free Premium activated for 24 hours!", 5, Color3.fromRGB(100, 200, 255))
                
                task.spawn(function()
                    task.wait(2)
                    CreateNotification("ANTC HUB", "NANTI BELI YA MAS HARGAIN KAMI YANG BUAT HARGA CUMAN 10K DAN 5K", 8, Color3.fromRGB(255, 215, 0))
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
                
                Settings.CustomNameTag = "Buyers"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Buyers")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Buyers", 3, Color3.fromRGB(255, 215, 0))
                end)
                
                local lifetimeText = webhookData and webhookData.isLifetime and " (Lifetime)" or ""
                CreateNotification("ANTC HUB", "Premium access granted!" .. lifetimeText, 5, Color3.fromRGB(255, 215, 0))
            elseif keyType == "FRIEND" then
                UserStatus = "FRIEND"
                UserTier = 2
                IsLifetimeKey = true
                
                Settings.CustomNameTag = "Friend ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Friend ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Friend ANTC HUB", 3, Color3.fromRGB(255, 100, 200))
                end)
                
                CreateNotification("ANTC HUB", "Welcome Friend! Premium access granted.", 5, Color3.fromRGB(255, 100, 200))
            elseif keyType == "BASIC" then
                UserStatus = "BASIC SCRIPT"
                UserTier = 1
                IsLifetimeKey = false
                
                Settings.CustomNameTag = "Free Scripter"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Free Scripter")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Free Scripter", 3, Color3.fromRGB(100, 200, 255))
                end)
                
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
                
                Settings.CustomNameTag = "Guest ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(0.5)
                    ApplyNameTag("Guest ANTC HUB")
                    CreateNotification("ANTC HUB", "✅ Name tag applied: Guest ANTC HUB", 3, Color3.fromRGB(100, 150, 255))
                end)
                
                CreateNotification("ANTC HUB", "Guest access granted! Limited features.", 5, Color3.fromRGB(100, 150, 255))
            end
            
            keyData.userStatus = UserStatus
            keyData.userTier = UserTier
            keyData.isLifetime = IsLifetimeKey
            if GeneratedKeys[key] and GeneratedKeys[key].expiresAt then
                keyData.expiryTime = GeneratedKeys[key].expiresAt
                KeyExpiryTime = GeneratedKeys[key].expiresAt
            end
            
            SaveKeyData(keyData)
            
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
                local iconPulse = TweenService:Create(LoadingIcon, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    TextTransparency = 0.3
                })
                iconPulse:Play()
                
                local iconScale = TweenService:Create(LoadingIcon, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    TextSize = 42
                })
                iconScale:Play()
                
                task.wait(3.5)
                iconPulse:Cancel()
                iconScale:Cancel()
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
        Size = UDim2.new(0, 420, 0, 405),
        Position = UDim2.new(0.5, -210, 0.5, -202)
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

local FreePremiumUsed = {}

function LoadFreePremiumData()
    if isfile and readfile then
        local success, fileExists = pcall(function()
            return isfile("ANTC_FreePremium.json")
        end)
        
        if success and fileExists then
            local readSuccess, data = pcall(function()
                return HttpService:JSONDecode(readfile("ANTC_FreePremium.json"))
            end)
            if readSuccess and data then
                FreePremiumUsed = data
            end
        end
    end
end

function SaveFreePremiumData()
    if writefile then
        pcall(function()
            writefile("ANTC_FreePremium.json", HttpService:JSONEncode(FreePremiumUsed))
        end)
    end
end

local function _0xDECRYPT_KEY(k) 
    local _x = 0
    for i = 1, #k do _x = _x + string.byte(k, i) end
    return k
end

function IsKeyValid(key)
    local _0xKEY_CHECK = _0xDECRYPT_KEY(key)
    local _0xVALIDATOR = tick() + os.time()
    local DeveloperKeys = {
        [_0xDECRYPT_KEY("ANTC-DEVELOPER-MASTER-KEY")] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Founder ANTC HUB"},
        [_0xDECRYPT_KEY("APIS-DEVELOPER-MASTER-KEY")] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Founder ANTC HUB"},
        [_0xDECRYPT_KEY("ANTC-PREMIUM-LIFETIME-KEY")] = {tier = "PREMIUM", isLifetime = true, dev = "Development APIS"},
        [_0xDECRYPT_KEY("APIS-PREMIUM-LIFETIME-KEY")] = {tier = "PREMIUM", isLifetime = true, dev = "Development APIS"},
        [_0xDECRYPT_KEY("APIS")] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Founder ANTC HUB"},
        [_0xDECRYPT_KEY("APIS-DEVELOPER-2025")] = {tier = "DEVELOPMENT", isLifetime = true, dev = "Founder ANTC HUB"},
        [_0xDECRYPT_KEY("ANTC-COFOUNDER-KEY")] = {tier = "COFOUNDER", isLifetime = true, dev = "Co Founder ANTC HUB"},
        [_0xDECRYPT_KEY("APIS-COFOUNDER-2025")] = {tier = "COFOUNDER", isLifetime = true, dev = "Co Founder ANTC HUB"},
        [_0xDECRYPT_KEY("ANTC-HUB-PTR")] = {tier = "PARTNER", isLifetime = true, dev = "Partner ANTC HUB"},
        [_0xDECRYPT_KEY("ANTC-STAFF-KEY")] = {tier = "STAFF", isLifetime = true, dev = "Staff ANTC HUB"},
        [_0xDECRYPT_KEY("ANTC-HUB-STAFF")] = {tier = "STAFF", isLifetime = true, dev = "Staff ANTC HUB"}
    }
    
    if key == "FREE-PREMIUM-1DAY" then
        LoadFreePremiumData()
        local userId = tostring(Player.UserId)
        local currentTime = os.time()
        
        if FreePremiumUsed[userId] then
            local lastUse = FreePremiumUsed[userId].lastUse
            local timeDiff = currentTime - lastUse
            
            if timeDiff < 86400 then
                local hoursLeft = math.ceil((86400 - timeDiff) / 3600)
                return false, "Minimal beli boss 😹😹 (Cooldown: " .. hoursLeft .. " hours)", nil
            end
        end
        
        FreePremiumUsed[userId] = {
            lastUse = currentTime
        }
        SaveFreePremiumData()
        
        KeyExpiryTime = currentTime + 86400
        return true, "FREE_PREMIUM", {
            valid = true,
            tier = "FREE_PREMIUM",
            isLifetime = false,
            expiresAt = currentTime + 86400,
            message = "Free Premium 1 Day activated!"
        }
    end
    
    if DeveloperKeys[key] then
        local keyData = DeveloperKeys[key]
        return true, keyData.tier, {
            valid = true,
            tier = keyData.tier,
            isLifetime = keyData.isLifetime,
            message = keyData.tier == "PARTNER" and "Partner access granted!" or "Developer access granted"
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
    
    LoadDeveloperKeys()
    if DeveloperCreatedKeys[key] then
        local keyData = DeveloperCreatedKeys[key]
        local currentTime = os.time()
        
        if keyData.isLifetime or currentTime <= keyData.expiresAt then
            if not keyData.isLifetime then
                KeyExpiryTime = keyData.expiresAt
            end
            return true, keyData.tier, {
                valid = true,
                tier = keyData.tier,
                isLifetime = keyData.isLifetime,
                expiresAt = keyData.expiresAt,
                message = keyData.tier .. " access granted! (Custom Key)",
                nameTag = keyData.nameTag
            }
        else
            return false, "Custom key expired", nil
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
    if not KEY_TRACKING_WEBHOOK or KEY_TRACKING_WEBHOOK == "" then 
        warn("[ANTC HUB] Key tracking webhook not configured")
        return 
    end
    
    local hwid = "Unknown"
    pcall(function()
        hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
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
            {name = "Game", value = gameName, inline = false}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local success, errorMsg = pcall(function()
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
        print("[ANTC HUB] ✅ Key tracking webhook sent successfully")
    else
        warn("[ANTC HUB] ❌ Failed to send key tracking webhook:", errorMsg)
        warn("[ANTC HUB] Webhook URL:", KEY_TRACKING_WEBHOOK)
    end
end

function SendDeveloperWebhook(message)
    if not DeveloperActivityWebhook or DeveloperActivityWebhook == "" then 
        warn("[ANTC HUB] Developer webhook not configured")
        return 
    end
    
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
    local tierEmoji = "👤"
    local currentStatus = UserStatus or "GUEST"
    
    if currentStatus == "DEVELOPER" then
        tierEmoji = "👨‍💻"
    elseif currentStatus == "PREMIUM" then
        tierEmoji = "⭐"
    elseif currentStatus == "FRIEND" then
        tierEmoji = "👥"
    elseif currentStatus == "BASIC" or currentStatus == "BASIC SCRIPT" then
        tierEmoji = "🔰"
    end
    
    local embed = {
        title = "⚡ User Activity - " .. currentStatus,
        description = message,
        color = 5814783,
        fields = {
            {name = tierEmoji .. " Player", value = Player.Name, inline = true},
            {name = "🆔 User ID", value = tostring(Player.UserId), inline = true},
            {name = "🎯 Tier", value = currentStatus, inline = true},
            {name = "🎮 Game", value = gameName, inline = false},
            {name = "⏰ Time", value = os.date("%H:%M:%S - %d/%m/%Y", os.time()), inline = true}
        },
        footer = {
            text = "ANTC Hub Activity Monitor"
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local success, errorMsg = pcall(function()
        HttpService:PostAsync(
            DeveloperActivityWebhook,
            HttpService:JSONEncode({
                username = "ANTC Hub Activity Monitor",
                embeds = {embed}
            }),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
    
    if success then
        print("[ANTC HUB] ✅ Activity logged:", currentStatus, "-", message)
    else
        warn("[ANTC HUB] ❌ Failed to send webhook:", errorMsg)
        warn("[ANTC HUB] Webhook URL:", DeveloperActivityWebhook)
    end
end

function SendBasicUserWebhook(eventType, message, extraData)
    if not BasicUserWebhook or BasicUserWebhook == "" then 
        return -- Webhook not configured for basic users
    end
    
    if UserStatus ~= "BASIC" and UserStatus ~= "BASIC SCRIPT" then
        return -- Only for basic users
    end
    
    local gameName = "Unknown"
    local mapId = tostring(game.PlaceId)
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
    local currentTime = os.date("%H:%M:%S", os.time())
    local afkStatus = Settings.AntiAFK and "🟢 Active (Anti-AFK ON)" or "🟢 Active"
    
    local embedColor = 5814783
    local embedTitle = "📊 Basic User Activity"
    
    if eventType == "player_join" then
        embedTitle = "✅ Player Joined"
        embedColor = 3066993
    elseif eventType == "player_leave" then
        embedTitle = "❌ Player Left"
        embedColor = 15158332
    elseif eventType == "player_died" then
        embedTitle = "💀 Player Died"
        embedColor = 10038562
    elseif eventType == "afk_detected" then
        embedTitle = "😴 AFK Detected"
        embedColor = 15844367
        afkStatus = "🔴 AFK"
    end
    
    local fields = {
        {name = "👤 Player", value = Player.Name, inline = true},
        {name = "🆔 User ID", value = tostring(Player.UserId), inline = true},
        {name = "🗺️ " .. GetText("map_name"), value = gameName, inline = false},
        {name = "🔢 Map ID", value = mapId, inline = true},
        {name = "⏰ " .. GetText("time_label"), value = currentTime, inline = true},
        {name = "💤 Status", value = afkStatus, inline = true}
    }
    
    if extraData then
        table.insert(fields, {name = "📝 Details", value = extraData, inline = false})
    end
    
    local embed = {
        title = embedTitle,
        description = message or GetText("player_joined"),
        color = embedColor,
        fields = fields,
        footer = {
            text = "ANTC Hub Basic User Tracker"
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    pcall(function()
        HttpService:PostAsync(
            BasicUserWebhook,
            HttpService:JSONEncode({
                username = "ANTC Hub Tracker",
                embeds = {embed}
            }),
            Enum.HttpContentType.ApplicationJson,
            false
        )
    end)
end

function SendDeveloperJoinNotification()
    if not DeveloperActivityWebhook or DeveloperActivityWebhook == "" then 
        warn("[ANTC HUB] Developer webhook not configured")
        return 
    end
    
    if not UserStatus or UserStatus ~= "DEVELOPER" then 
        return 
    end
    
    local activeFeatures = {}
    if Settings.Fly then table.insert(activeFeatures, "Fly") end
    if Settings.Speed then table.insert(activeFeatures, "Speed") end
    if Settings.Noclip then table.insert(activeFeatures, "Noclip") end
    if Settings.GodMode then table.insert(activeFeatures, "God Mode") end
    
    local featuresText = #activeFeatures > 0 and table.concat(activeFeatures, ", ") or "None"
    
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    
    local embed = {
        title = "👨‍💻 Developer Online!",
        description = "**Developer has joined the game**",
        color = 3066993,
        fields = {
            {name = "👤 Player", value = Player.Name, inline = true},
            {name = "🆔 User ID", value = tostring(Player.UserId), inline = true},
            {name = "🎮 Map/Place", value = gameName, inline = false},
            {name = "⏰ Join Time", value = os.date("%H:%M:%S", os.time()), inline = true},
            {name = "⚙️ Active Features", value = featuresText, inline = false}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local success, errorMsg = pcall(function()
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
    
    if success then
        print("[ANTC HUB] ✅ Developer join notification sent")
    else
        warn("[ANTC HUB] ❌ Failed to send developer join notification:", errorMsg)
        warn("[ANTC HUB] Webhook URL:", DeveloperActivityWebhook)
    end
end

function ApplyNameTag(customText, isAFK)
    local char = Player.Character
    if not char then return end
    
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    for _, obj in pairs(head:GetChildren()) do
        if obj:IsA("BillboardGui") and (obj.Name == "CustomNameTag" or obj.Name == "AFKNameTag") then
            obj:Destroy()
        end
    end
    
    if not customText or customText == "" then return end
    
    local hasStatus = Settings.ShowStatusText and Settings.CustomStatusText and Settings.CustomStatusText ~= ""
    local billboardHeight = isAFK and 70 or (hasStatus and 85 or 50)
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = isAFK and "AFKNameTag" or "CustomNameTag"
    billboard.Size = UDim2.new(0, 220, 0, billboardHeight)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 50
    billboard.Parent = head
    
    local tagFrame = Instance.new("Frame")
    tagFrame.Size = UDim2.new(1, 0, 1, 0)
    tagFrame.BackgroundColor3 = isAFK and Color3.fromRGB(15, 15, 25) or Color3.fromRGB(10, 10, 20)
    tagFrame.BackgroundTransparency = 0.08
    tagFrame.BorderSizePixel = 0
    tagFrame.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = tagFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = isAFK and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(138, 43, 226)
    stroke.Thickness = 2.5
    stroke.Transparency = 0.25
    stroke.Parent = tagFrame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, hasStatus and 0.5 or 1, hasStatus and -2 or -5)
    textLabel.Position = UDim2.new(0, 5, 0, 2)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = customText
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = isAFK and 14 or 16
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = false
    textLabel.TextWrapped = true
    textLabel.Parent = tagFrame
    
    if not isAFK then
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
        }
        gradient.Parent = textLabel
    else
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 165, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 165, 0))
        }
        gradient.Parent = textLabel
    end
    
    if hasStatus and not isAFK then
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, -10, 0.5, -5)
        statusLabel.Position = UDim2.new(0, 5, 0.5, 2)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Text = Settings.CustomStatusText
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.TextSize = 11
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
        statusLabel.TextScaled = false
        statusLabel.TextWrapped = true
        statusLabel.Parent = tagFrame
    end
end

function ClearNameTag()
    local char = Player.Character
    if char then
        local head = char:FindFirstChild("Head")
        if head then
            for _, obj in pairs(head:GetChildren()) do
                if obj:IsA("BillboardGui") and (obj.Name == "CustomNameTag" or obj.Name == "AFKNameTag") then
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

local AntiAFKConnection = nil
local lastAFKAction = 0

function StartAntiAFK()
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
    end
    
    ApplyNameTag("AFK MODE\nPowered By ANTC HUB", true)
    CreateNotification("ANTC HUB", "Anti-AFK Activated - Moving randomly", 3, Color3.fromRGB(255, 165, 0))
    
    AntiAFKConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        if currentTime - lastAFKAction >= 2 then
            lastAFKAction = currentTime
            
            local char = Player.Character
            if char and char:FindFirstChild("Humanoid") then
                local humanoid = char.Humanoid
                local actions = {
                    function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game) task.wait(0.05) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game) end,
                    function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, game) task.wait(0.05) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, game) end,
                    function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game) task.wait(0.05) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game) end,
                    function() VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game) task.wait(0.05) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game) end,
                    function() humanoid.Jump = true end,
                    function() VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1) task.wait(0.05) VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1) end
                }
                
                local randomAction = actions[math.random(1, #actions)]
                pcall(randomAction)
            end
        end
    end)
end

function StopAntiAFK()
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end
    
    local char = Player.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        for _, obj in pairs(head:GetChildren()) do
            if obj:IsA("BillboardGui") and obj.Name == "AFKNameTag" then
                obj:Destroy()
            end
        end
    end
    
    CreateNotification("ANTC HUB", "Anti-AFK Deactivated", 3, Color3.fromRGB(255, 165, 0))
end

function DisableAllFeatures()
    Settings.Fly = false
    Settings.Speed = false
    Settings.HighJump = false
    Settings.Noclip = false
    Settings.GodMode = false
    Settings.Invisible = false
    Settings.KillAura = false
    Settings.Aimbot = false
    Settings.AntiAFK = false
    Settings.AntiKick = false
    Settings.AutoClick = false
    Settings.AirWalk = false
    
    if AntiAFKConnection then
        AntiAFKConnection:Disconnect()
        AntiAFKConnection = nil
    end
    
    local char = Player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        
        if hrp then
            local bodyVelocity = hrp:FindFirstChild("FlyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
            
            local bodyGyro = hrp:FindFirstChild("FlyGyro")
            if bodyGyro then
                bodyGyro:Destroy()
            end
        end
        
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
    
    ClearNameTag()
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
    
    -- Save starting position for air walk
    FlyStartPosition = hrp.Position
    
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
        
        -- Air walk mode: maintain Y position at start height
        if Settings.AirWalk and FlyStartPosition then
            local currentPos = hrp.Position
            hrp.CFrame = CFrame.new(Vector3.new(currentPos.X, FlyStartPosition.Y, currentPos.Z))
        end
        
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
        
        -- Only allow vertical movement if NOT in air walk mode
        if not Settings.AirWalk then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, Settings.FlySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, Settings.FlySpeed, 0)
            end
        end
        
        bv.velocity = moveDirection
        bg.CFrame = camera.CFrame
        
        if humanoid then
            humanoid.PlatformStand = true
        end
    end)
    
    if Settings.AirWalk then
        CreateNotification("ANTC HUB", GetText("fly_air_walk"), 4, Color3.fromRGB(100, 200, 255))
    else
        CreateNotification("ANTC HUB", GetText("fly_enabled"), 4, Color3.fromRGB(0, 255, 150))
    end
    SendDeveloperWebhook("[FLY] Activated Fly Mode " .. (Settings.AirWalk and "(Air Walk)" or ""))
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

function ActivateSafeZone()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        CreateNotification("ANTC HUB", "Character not found!", 3, Color3.fromRGB(255, 100, 100))
        return
    end
    
    local hrp = char.HumanoidRootPart
    
    local spawnPos = Settings.SafeZoneCustomLocation or hrp.CFrame
    hrp.CFrame = spawnPos + Vector3.new(0, 5, 0)
    
    if SafeZonePlatform then
        SafeZonePlatform:Destroy()
    end
    
    SafeZonePlatform = Instance.new("Part")
    SafeZonePlatform.Name = "ANTC_SafeZonePlatform"
    SafeZonePlatform.Size = Vector3.new(25, 1, 25)
    SafeZonePlatform.Position = hrp.Position - Vector3.new(0, 3, 0)
    SafeZonePlatform.Anchored = true
    SafeZonePlatform.CanCollide = true
    SafeZonePlatform.Material = Enum.Material.Neon
    SafeZonePlatform.Color = Settings.SafeZonePlatformColor
    SafeZonePlatform.Transparency = 0.3
    SafeZonePlatform.Parent = Workspace
    
    local Corner1 = Instance.new("Part")
    Corner1.Size = Vector3.new(1, 3, 1)
    Corner1.Position = Vector3.new(-10, 998, -10)
    Corner1.Anchored = true
    Corner1.CanCollide = false
    Corner1.Material = Enum.Material.Neon
    Corner1.Color = Settings.SafeZonePlatformColor
    Corner1.Transparency = 0.5
    Corner1.Parent = SafeZonePlatform
    
    local Corner2 = Instance.new("Part")
    Corner2.Size = Vector3.new(1, 3, 1)
    Corner2.Position = Vector3.new(10, 998, -10)
    Corner2.Anchored = true
    Corner2.CanCollide = false
    Corner2.Material = Enum.Material.Neon
    Corner2.Color = Settings.SafeZonePlatformColor
    Corner2.Transparency = 0.5
    Corner2.Parent = SafeZonePlatform
    
    local Corner3 = Instance.new("Part")
    Corner3.Size = Vector3.new(1, 3, 1)
    Corner3.Position = Vector3.new(-10, 998, 10)
    Corner3.Anchored = true
    Corner3.CanCollide = false
    Corner3.Material = Enum.Material.Neon
    Corner3.Color = Settings.SafeZonePlatformColor
    Corner3.Transparency = 0.5
    Corner3.Parent = SafeZonePlatform
    
    local Corner4 = Instance.new("Part")
    Corner4.Size = Vector3.new(1, 3, 1)
    Corner4.Position = Vector3.new(10, 998, 10)
    Corner4.Anchored = true
    Corner4.CanCollide = false
    Corner4.Material = Enum.Material.Neon
    Corner4.Color = Settings.SafeZonePlatformColor
    Corner4.Transparency = 0.5
    Corner4.Parent = SafeZonePlatform
    
    RunService.Heartbeat:Connect(function()
        if Settings.SafeZoneActive and char and char:FindFirstChild("HumanoidRootPart") then
            if SafeZonePlatform then
                SafeZonePlatform.CFrame = CFrame.new(char.HumanoidRootPart.Position.X, 996, char.HumanoidRootPart.Position.Z)
                SafeZonePlatform.Color = Settings.SafeZonePlatformColor
                for _, child in pairs(SafeZonePlatform:GetChildren()) do
                    if child:IsA("Part") then
                        child.Color = Settings.SafeZonePlatformColor
                    end
                end
            end
        elseif SafeZonePlatform then
            SafeZonePlatform:Destroy()
            SafeZonePlatform = nil
        end
    end)
    
    if SafeZoneFollowConnection then
        SafeZoneFollowConnection:Disconnect()
    end
    
    SafeZoneFollowConnection = RunService.Heartbeat:Connect(function()
        if SafeZonePlatform and char and char:FindFirstChild("HumanoidRootPart") then
            SafeZonePlatform.Position = char.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
        end
    end)
    
    CreateNotification("ANTC HUB", "Safe Zone activated! Platform follows you.", 4, Color3.fromRGB(0, 255, 150))
    SendDeveloperWebhook("Safe Zone Activated")
end

function DeactivateSafeZone()
    if SafeZonePlatform then
        SafeZonePlatform:Destroy()
        SafeZonePlatform = nil
    end
    
    if SafeZoneFollowConnection then
        SafeZoneFollowConnection:Disconnect()
        SafeZoneFollowConnection = nil
    end
    
    CreateNotification("ANTC HUB", "Safe Zone deactivated", 3, Color3.fromRGB(255, 150, 50))
    SendDeveloperWebhook("Safe Zone Deactivated")
end

function SetCustomSafeZoneLocation()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        CreateNotification("ANTC HUB", "Character not found!", 3, Color3.fromRGB(255, 100, 100))
        return
    end
    
    Settings.SafeZoneCustomLocation = char.HumanoidRootPart.CFrame
    SaveSettings()
    CreateNotification("ANTC HUB", "Custom Safe Zone location saved at current position!", 3, Color3.fromRGB(0, 255, 150))
end

function UpdatePerformanceData()
    local currentPlayers = #Players:GetPlayers()
    local currentTime = os.time()
    
    table.insert(PerformanceData, {
        players = currentPlayers,
        timestamp = currentTime,
        serverName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown",
        ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() or 0
    })
    
    if #PerformanceData > MaxDataPoints then
        table.remove(PerformanceData, 1)
    end
end

function CreatePerformanceGraph()
    local GraphFrame = Instance.new("Frame")
    GraphFrame.Name = "PerformanceGraph"
    GraphFrame.Size = UDim2.new(0, 600, 0, 450)
    GraphFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    GraphFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    GraphFrame.BackgroundTransparency = 0.05
    GraphFrame.BorderSizePixel = 0
    GraphFrame.Active = true
    GraphFrame.Draggable = true
    GraphFrame.Parent = ScreenGui
    
    local GraphCorner = Instance.new("UICorner")
    GraphCorner.CornerRadius = UDim.new(0, 15)
    GraphCorner.Parent = GraphFrame
    
    local GraphStroke = Instance.new("UIStroke")
    GraphStroke.Color = Color3.fromRGB(138, 43, 226)
    GraphStroke.Thickness = 2
    GraphStroke.Transparency = 0.5
    GraphStroke.Parent = GraphFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 0, 50)
    TitleLabel.Position = UDim2.new(0, 20, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "PERFORMANCE MONITOR"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = GraphFrame
    
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
    CloseBtn.Parent = GraphFrame
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 10)
    CloseBtnCorner.Parent = CloseBtn
    
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Size = UDim2.new(1, -40, 0, 80)
    InfoFrame.Position = UDim2.new(0, 20, 0, 60)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
    InfoFrame.BackgroundTransparency = 0.3
    InfoFrame.BorderSizePixel = 0
    InfoFrame.Parent = GraphFrame
    
    local InfoCorner = Instance.new("UICorner")
    InfoCorner.CornerRadius = UDim.new(0, 10)
    InfoCorner.Parent = InfoFrame
    
    local ServerLabel = Instance.new("TextLabel")
    ServerLabel.Size = UDim2.new(0.5, -10, 0, 25)
    ServerLabel.Position = UDim2.new(0, 10, 0, 10)
    ServerLabel.BackgroundTransparency = 1
    ServerLabel.Text = "Server: Loading..."
    ServerLabel.Font = Enum.Font.Gotham
    ServerLabel.TextSize = 14
    ServerLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    ServerLabel.TextXAlignment = Enum.TextXAlignment.Left
    ServerLabel.Parent = InfoFrame
    
    local PlayersLabel = Instance.new("TextLabel")
    PlayersLabel.Size = UDim2.new(0.5, -10, 0, 25)
    PlayersLabel.Position = UDim2.new(0.5, 0, 0, 10)
    PlayersLabel.BackgroundTransparency = 1
    PlayersLabel.Text = "Players: 0"
    PlayersLabel.Font = Enum.Font.Gotham
    PlayersLabel.TextSize = 14
    PlayersLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    PlayersLabel.TextXAlignment = Enum.TextXAlignment.Left
    PlayersLabel.Parent = InfoFrame
    
    local PingLabel = Instance.new("TextLabel")
    PingLabel.Size = UDim2.new(0.5, -10, 0, 25)
    PingLabel.Position = UDim2.new(0, 10, 0, 45)
    PingLabel.BackgroundTransparency = 1
    PingLabel.Text = "Ping: 0ms"
    PingLabel.Font = Enum.Font.Gotham
    PingLabel.TextSize = 14
    PingLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    PingLabel.TextXAlignment = Enum.TextXAlignment.Left
    PingLabel.Parent = InfoFrame
    
    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Size = UDim2.new(0.5, -10, 0, 25)
    TimeLabel.Position = UDim2.new(0.5, 0, 0, 45)
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.Text = "Time: " .. os.date("%H:%M:%S")
    TimeLabel.Font = Enum.Font.Gotham
    TimeLabel.TextSize = 14
    TimeLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    TimeLabel.Parent = InfoFrame
    
    local GraphCanvas = Instance.new("Frame")
    GraphCanvas.Size = UDim2.new(1, -40, 0, 250)
    GraphCanvas.Position = UDim2.new(0, 20, 0, 160)
    GraphCanvas.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
    GraphCanvas.BackgroundTransparency = 0.3
    GraphCanvas.BorderSizePixel = 0
    GraphCanvas.ClipsDescendants = true
    GraphCanvas.Parent = GraphFrame
    
    local CanvasCorner = Instance.new("UICorner")
    CanvasCorner.CornerRadius = UDim.new(0, 10)
    CanvasCorner.Parent = GraphCanvas
    
    task.spawn(function()
        while GraphFrame and GraphFrame.Parent do
            UpdatePerformanceData()
            
            for _, child in pairs(GraphCanvas:GetChildren()) do
                if child:IsA("Frame") and child.Name == "GraphBar" then
                    child:Destroy()
                end
            end
            
            if #PerformanceData > 0 then
                local maxPlayers = 0
                for _, data in pairs(PerformanceData) do
                    if data.players > maxPlayers then
                        maxPlayers = data.players
                    end
                end
                maxPlayers = math.max(maxPlayers, 1)
                
                local barWidth = (GraphCanvas.AbsoluteSize.X - 10) / math.min(#PerformanceData, 60)
                
                for i, data in pairs(PerformanceData) do
                    local barHeight = (data.players / maxPlayers) * (GraphCanvas.AbsoluteSize.Y - 20)
                    
                    local bar = Instance.new("Frame")
                    bar.Name = "GraphBar"
                    bar.Size = UDim2.new(0, barWidth - 2, 0, barHeight)
                    bar.Position = UDim2.new(0, (i - 1) * barWidth + 5, 1, -barHeight - 10)
                    bar.BackgroundColor3 = Color3.fromHSV((data.players / maxPlayers) * 0.3, 1, 1)
                    bar.BorderSizePixel = 0
                    bar.Parent = GraphCanvas
                    
                    local barCorner = Instance.new("UICorner")
                    barCorner.CornerRadius = UDim.new(0, 3)
                    barCorner.Parent = bar
                end
                
                local latestData = PerformanceData[#PerformanceData]
                ServerLabel.Text = "Server: " .. (latestData.serverName or "Unknown")
                PlayersLabel.Text = "Players: " .. latestData.players
                PingLabel.Text = "Ping: " .. math.floor(latestData.ping) .. "ms"
                TimeLabel.Text = "Time: " .. os.date("%H:%M:%S", latestData.timestamp)
            end
            
            task.wait(1)
        end
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(GraphFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.3)
        GraphFrame:Destroy()
    end)
    
    GraphFrame.Size = UDim2.new(0, 0, 0, 0)
    GraphFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(GraphFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 450),
        Position = UDim2.new(0.5, -300, 0.5, -225)
    }):Play()
end

function CreateBannerSettings()
    local BannerFrame = Instance.new("Frame")
    BannerFrame.Name = "BannerSettings"
    BannerFrame.Size = UDim2.new(0, 500, 0, 350)
    BannerFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    BannerFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    BannerFrame.BackgroundTransparency = 0.05
    BannerFrame.BorderSizePixel = 0
    BannerFrame.Active = true
    BannerFrame.Draggable = true
    BannerFrame.Parent = ScreenGui
    
    local BannerCorner = Instance.new("UICorner")
    BannerCorner.CornerRadius = UDim.new(0, 15)
    BannerCorner.Parent = BannerFrame
    
    local BannerStroke = Instance.new("UIStroke")
    BannerStroke.Color = Color3.fromRGB(138, 43, 226)
    BannerStroke.Thickness = 2
    BannerStroke.Transparency = 0.5
    BannerStroke.Parent = BannerFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 0, 50)
    TitleLabel.Position = UDim2.new(0, 20, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "BANNER SETTINGS"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = BannerFrame
    
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
    CloseBtn.Parent = BannerFrame
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 10)
    CloseBtnCorner.Parent = CloseBtn
    
    local PreviewLabel = Instance.new("TextLabel")
    PreviewLabel.Size = UDim2.new(1, -40, 0, 25)
    PreviewLabel.Position = UDim2.new(0, 20, 0, 70)
    PreviewLabel.BackgroundTransparency = 1
    PreviewLabel.Text = "Banner Image ID:"
    PreviewLabel.Font = Enum.Font.GothamBold
    PreviewLabel.TextSize = 14
    PreviewLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    PreviewLabel.TextXAlignment = Enum.TextXAlignment.Left
    PreviewLabel.Parent = BannerFrame
    
    local BannerIDBox = Instance.new("TextBox")
    BannerIDBox.Size = UDim2.new(1, -40, 0, 45)
    BannerIDBox.Position = UDim2.new(0, 20, 0, 100)
    BannerIDBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    BannerIDBox.BackgroundTransparency = 0.2
    BannerIDBox.BorderSizePixel = 0
    BannerIDBox.Text = Settings.BannerImageID or ""
    BannerIDBox.PlaceholderText = "Enter Roblox Image ID..."
    BannerIDBox.Font = Enum.Font.Gotham
    BannerIDBox.TextSize = 14
    BannerIDBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    BannerIDBox.Parent = BannerFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 10)
    BoxCorner.Parent = BannerIDBox
    
    local PreviewImage = Instance.new("ImageLabel")
    PreviewImage.Size = UDim2.new(1, -40, 0, 120)
    PreviewImage.Position = UDim2.new(0, 20, 0, 160)
    PreviewImage.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
    PreviewImage.BackgroundTransparency = 0.3
    PreviewImage.BorderSizePixel = 0
    PreviewImage.Image = "rbxassetid://" .. (Settings.BannerImageID or "5554236805")
    PreviewImage.ScaleType = Enum.ScaleType.Fit
    PreviewImage.Parent = BannerFrame
    
    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 10)
    PreviewCorner.Parent = PreviewImage
    
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(1, -40, 0, 45)
    SaveBtn.Position = UDim2.new(0, 20, 0, 290)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    SaveBtn.BackgroundTransparency = 0.2
    SaveBtn.BorderSizePixel = 0
    SaveBtn.Text = "SAVE BANNER"
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.TextSize = 16
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.Parent = BannerFrame
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveBtn
    
    BannerIDBox:GetPropertyChangedSignal("Text"):Connect(function()
        PreviewImage.Image = "rbxassetid://" .. BannerIDBox.Text
    end)
    
    SaveBtn.MouseButton1Click:Connect(function()
        Settings.BannerImageID = BannerIDBox.Text
        SaveSettings()
        CreateNotification("ANTC HUB", "Banner saved successfully!", 3, Color3.fromRGB(0, 255, 150))
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(BannerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.3)
        BannerFrame:Destroy()
    end)
    
    BannerFrame.Size = UDim2.new(0, 0, 0, 0)
    BannerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(BannerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 350),
        Position = UDim2.new(0.5, -250, 0.5, -175)
    }):Play()
end

function CreateFounderDexExplorer()
    local DexFrame = Instance.new("Frame")
    DexFrame.Name = "FounderDexExplorer"
    DexFrame.Size = UDim2.new(0, 700, 0, 500)
    DexFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    DexFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    DexFrame.BackgroundTransparency = 0.05
    DexFrame.BorderSizePixel = 0
    DexFrame.Active = true
    DexFrame.Draggable = true
    DexFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = DexFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2.5
    Stroke.Transparency = 0.3
    Stroke.Parent = DexFrame
    
    -- Rainbow effect for border
    task.spawn(function()
        local hue = 0
        while Stroke and Stroke.Parent do
            hue = (hue + 0.01) % 1
            Stroke.Color = Color3.fromHSV(hue, 1, 1)
            task.wait(0.03)
        end
    end)
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 0, 45)
    Title.Position = UDim2.new(0, 20, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "🔍 FOUNDER DEX EXPLORER - Real-Time Map Viewer"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = DexFrame
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -50, 0, 8)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 0.1
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 20
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = DexFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -40, 1, -100)
    ScrollFrame.Position = UDim2.new(0, 20, 0, 60)
    ScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    ScrollFrame.BackgroundTransparency = 0.2
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 8
    ScrollFrame.Parent = DexFrame
    
    local ScrollCorner = Instance.new("UICorner")
    ScrollCorner.CornerRadius = UDim.new(0, 10)
    ScrollCorner.Parent = ScrollFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.SortOrder = Enum.SortOrder.Name
    ListLayout.Parent = ScrollFrame
    
    local function RefreshDexView()
        for _, child in pairs(ScrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        local yPos = 0
        local function AddInstance(instance, indent)
            if instance == DexFrame or instance:IsDescendantOf(DexFrame) then
                return
            end
            
            local ItemFrame = Instance.new("Frame")
            ItemFrame.Size = UDim2.new(1, -10, 0, 35)
            ItemFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            ItemFrame.BackgroundTransparency = 0.3
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Parent = ScrollFrame
            
            local ItemCorner = Instance.new("UICorner")
            ItemCorner.CornerRadius = UDim.new(0, 8)
            ItemCorner.Parent = ItemFrame
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(0.5, -10, 1, 0)
            NameLabel.Position = UDim2.new(0, indent * 20 + 10, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = string.rep("  ", indent) .. (instance:IsA("Folder") and "📁 " or "📄 ") .. instance.Name
            NameLabel.Font = Enum.Font.Gotham
            NameLabel.TextSize = 13
            NameLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            NameLabel.Parent = ItemFrame
            
            local TypeLabel = Instance.new("TextLabel")
            TypeLabel.Size = UDim2.new(0.25, 0, 1, 0)
            TypeLabel.Position = UDim2.new(0.5, 0, 0, 0)
            TypeLabel.BackgroundTransparency = 1
            TypeLabel.Text = instance.ClassName
            TypeLabel.Font = Enum.Font.Gotham
            TypeLabel.TextSize = 11
            TypeLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
            TypeLabel.TextXAlignment = Enum.TextXAlignment.Center
            TypeLabel.Parent = ItemFrame
            
            local MoveBtn = Instance.new("TextButton")
            MoveBtn.Size = UDim2.new(0, 80, 0, 25)
            MoveBtn.Position = UDim2.new(0.75, 10, 0.5, -12)
            MoveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            MoveBtn.BackgroundTransparency = 0.2
            MoveBtn.BorderSizePixel = 0
            MoveBtn.Text = "Move To Me"
            MoveBtn.Font = Enum.Font.GothamBold
            MoveBtn.TextSize = 10
            MoveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            MoveBtn.Parent = ItemFrame
            
            local MoveCorner = Instance.new("UICorner")
            MoveCorner.CornerRadius = UDim.new(0, 6)
            MoveCorner.Parent = MoveBtn
            
            MoveBtn.MouseButton1Click:Connect(function()
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and instance:IsA("BasePart") then
                    instance.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                    CreateNotification("ANTC HUB", "Moved " .. instance.Name .. " to your position!", 3, Color3.fromRGB(0, 255, 150))
                    SendDeveloperWebhook("📦 Moved object: " .. instance.Name)
                elseif instance:IsA("Model") and char and char:FindFirstChild("HumanoidRootPart") then
                    instance:SetPrimaryPartCFrame(char.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
                    CreateNotification("ANTC HUB", "Moved " .. instance.Name .. " model to your position!", 3, Color3.fromRGB(0, 255, 150))
                    SendDeveloperWebhook("📦 Moved model: " .. instance.Name)
                else
                    CreateNotification("ANTC HUB", "Cannot move this type of object!", 3, Color3.fromRGB(255, 100, 100))
                end
            end)
        end
        
        for _, instance in pairs(Workspace:GetChildren()) do
            AddInstance(instance, 0)
        end
        
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    end
    
    local RefreshBtn = Instance.new("TextButton")
    RefreshBtn.Size = UDim2.new(0, 120, 0, 35)
    RefreshBtn.Position = UDim2.new(0, 20, 1, -45)
    RefreshBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    RefreshBtn.BackgroundTransparency = 0.1
    RefreshBtn.BorderSizePixel = 0
    RefreshBtn.Text = "🔄 Refresh"
    RefreshBtn.Font = Enum.Font.GothamBold
    RefreshBtn.TextSize = 14
    RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RefreshBtn.Parent = DexFrame
    
    local RefreshCorner = Instance.new("UICorner")
    RefreshCorner.CornerRadius = UDim.new(0, 8)
    RefreshCorner.Parent = RefreshBtn
    
    RefreshBtn.MouseButton1Click:Connect(function()
        RefreshDexView()
        CreateNotification("ANTC HUB", "Dex Explorer refreshed!", 2, Color3.fromRGB(138, 43, 226))
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        DexFrame:Destroy()
        CreateNotification("ANTC HUB", "Dex Explorer closed", 2, Color3.fromRGB(255, 150, 50))
    end)
    
    RefreshDexView()
end

function CreateCoordinateViewer()
    local CoordFrame = Instance.new("Frame")
    CoordFrame.Name = "CoordinateViewer"
    CoordFrame.Size = UDim2.new(0, 350, 0, 280)
    CoordFrame.Position = UDim2.new(0.5, -175, 0.5, -140)
    CoordFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    CoordFrame.BackgroundTransparency = 0.05
    CoordFrame.BorderSizePixel = 0
    CoordFrame.Active = true
    CoordFrame.Draggable = true
    CoordFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = CoordFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = CoordFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 45)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "📍 KOORDINAT VIEWER"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = CoordFrame
    
    local XLabel = Instance.new("TextLabel")
    XLabel.Size = UDim2.new(1, -40, 0, 30)
    XLabel.Position = UDim2.new(0, 20, 0, 70)
    XLabel.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    XLabel.BackgroundTransparency = 0.3
    XLabel.BorderSizePixel = 0
    XLabel.Text = "X: 0.000"
    XLabel.Font = Enum.Font.GothamBold
    XLabel.TextSize = 16
    XLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    XLabel.Parent = CoordFrame
    
    local XCorner = Instance.new("UICorner")
    XCorner.CornerRadius = UDim.new(0, 8)
    XCorner.Parent = XLabel
    
    local YLabel = Instance.new("TextLabel")
    YLabel.Size = UDim2.new(1, -40, 0, 30)
    YLabel.Position = UDim2.new(0, 20, 0, 110)
    YLabel.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    YLabel.BackgroundTransparency = 0.3
    YLabel.BorderSizePixel = 0
    YLabel.Text = "Y: 0.000 (Tinggi)"
    YLabel.Font = Enum.Font.GothamBold
    YLabel.TextSize = 16
    YLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    YLabel.Parent = CoordFrame
    
    local YCorner = Instance.new("UICorner")
    YCorner.CornerRadius = UDim.new(0, 8)
    YCorner.Parent = YLabel
    
    local ZLabel = Instance.new("TextLabel")
    ZLabel.Size = UDim2.new(1, -40, 0, 30)
    ZLabel.Position = UDim2.new(0, 20, 0, 150)
    ZLabel.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    ZLabel.BackgroundTransparency = 0.3
    ZLabel.BorderSizePixel = 0
    ZLabel.Text = "Z: 0.000 (Kedalam)"
    ZLabel.Font = Enum.Font.GothamBold
    ZLabel.TextSize = 16
    ZLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ZLabel.Parent = CoordFrame
    
    local ZCorner = Instance.new("UICorner")
    ZCorner.CornerRadius = UDim.new(0, 8)
    ZCorner.Parent = ZLabel
    
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0, 145, 0, 40)
    CopyBtn.Position = UDim2.new(0, 20, 0, 195)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    CopyBtn.BackgroundTransparency = 0.1
    CopyBtn.BorderSizePixel = 0
    CopyBtn.Text = "COPY"
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 14
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.Parent = CoordFrame
    
    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 10)
    CopyCorner.Parent = CopyBtn
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 145, 0, 40)
    CloseBtn.Position = UDim2.new(0, 185, 0, 195)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BackgroundTransparency = 0.1
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "CLOSE"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = CoordFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    local updateConnection
    updateConnection = RunService.Heartbeat:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            XLabel.Text = string.format("X: %.3f", pos.X)
            YLabel.Text = string.format("Y: %.3f (Tinggi)", pos.Y)
            ZLabel.Text = string.format("Z: %.3f (Kedalam)", pos.Z)
        end
    end)
    
    CopyBtn.MouseButton1Click:Connect(function()
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            local coordText = string.format("X: %.3f, Y: %.3f, Z: %.3f", pos.X, pos.Y, pos.Z)
            if setclipboard then
                setclipboard(coordText)
                CreateNotification("ANTC HUB", "Koordinat disalin ke clipboard!", 3, Color3.fromRGB(0, 255, 150))
            else
                CreateNotification("ANTC HUB", coordText, 5, Color3.fromRGB(100, 150, 255))
            end
        end
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        if updateConnection then
            updateConnection:Disconnect()
        end
        CoordFrame:Destroy()
    end)
end

function CreateSafeZoneColorPicker()
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Name = "SafeZoneColorPicker"
    ColorFrame.Size = UDim2.new(0, 400, 0, 450)
    ColorFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
    ColorFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ColorFrame.BackgroundTransparency = 0.05
    ColorFrame.BorderSizePixel = 0
    ColorFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ColorFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = ColorFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Safe Zone Platform Color"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ColorFrame
    
    local PreviewFrame = Instance.new("Frame")
    PreviewFrame.Size = UDim2.new(0, 360, 0, 80)
    PreviewFrame.Position = UDim2.new(0, 20, 0, 75)
    PreviewFrame.BackgroundColor3 = Settings.SafeZonePlatformColor
    PreviewFrame.BorderSizePixel = 0
    PreviewFrame.Parent = ColorFrame
    
    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 10)
    PreviewCorner.Parent = PreviewFrame
    
    local colors = {
        {name = "Purple", color = Color3.fromRGB(138, 43, 226)},
        {name = "Blue", color = Color3.fromRGB(0, 150, 255)},
        {name = "Green", color = Color3.fromRGB(0, 255, 150)},
        {name = "Red", color = Color3.fromRGB(255, 50, 50)},
        {name = "Yellow", color = Color3.fromRGB(255, 255, 0)},
        {name = "Pink", color = Color3.fromRGB(255, 100, 200)},
        {name = "Orange", color = Color3.fromRGB(255, 150, 0)},
        {name = "Cyan", color = Color3.fromRGB(0, 255, 255)}
    }
    
    for i, colorData in ipairs(colors) do
        local row = math.floor((i - 1) / 4)
        local col = (i - 1) % 4
        
        local ColorBtn = Instance.new("TextButton")
        ColorBtn.Size = UDim2.new(0, 80, 0, 80)
        ColorBtn.Position = UDim2.new(0, 20 + (col * 90), 0, 175 + (row * 90))
        ColorBtn.BackgroundColor3 = colorData.color
        ColorBtn.BorderSizePixel = 0
        ColorBtn.Text = ""
        ColorBtn.Parent = ColorFrame
        
        local ColorBtnCorner = Instance.new("UICorner")
        ColorBtnCorner.CornerRadius = UDim.new(0, 10)
        ColorBtnCorner.Parent = ColorBtn
        
        local ColorName = Instance.new("TextLabel")
        ColorName.Size = UDim2.new(1, 0, 0, 20)
        ColorName.Position = UDim2.new(0, 0, 1, -25)
        ColorName.BackgroundTransparency = 1
        ColorName.Text = colorData.name
        ColorName.Font = Enum.Font.GothamBold
        ColorName.TextSize = 11
        ColorName.TextColor3 = Color3.fromRGB(255, 255, 255)
        ColorName.Parent = ColorBtn
        
        ColorBtn.MouseButton1Click:Connect(function()
            Settings.SafeZonePlatformColor = colorData.color
            PreviewFrame.BackgroundColor3 = colorData.color
            SaveSettings()
            CreateNotification("ANTC HUB", "Platform color set to " .. colorData.name, 3, colorData.color)
        end)
    end
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 360, 0, 45)
    CloseBtn.Position = UDim2.new(0, 20, 0, 385)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    CloseBtn.BackgroundTransparency = 0.1
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "CLOSE"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Parent = ColorFrame
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 10)
    CloseBtnCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ColorFrame:Destroy()
    end)
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
                    local camera = Workspace.CurrentCamera
                    camera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
                    camera.CameraType = Enum.CameraType.Custom
                    CurrentSpectateTarget = targetPlayer
                    CreateSpectateExitButton()
                    CreateNotification("ANTC HUB", "Spectating " .. targetPlayer.Name .. " (Unlimited Range)", 4, Color3.fromRGB(100, 150, 255))
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
    
    local isMinimized = false
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(0, 590, 0, 60)
    ButtonContainer.Position = UDim2.new(1, -60, 0, 100)
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
    
    local JailBtn = Instance.new("TextButton")
    JailBtn.Size = UDim2.new(0, 180, 0, 50)
    JailBtn.Position = UDim2.new(0, 195, 0, 0)
    JailBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    JailBtn.BackgroundTransparency = 0.15
    JailBtn.BorderSizePixel = 0
    JailBtn.Text = "JAIL PLAYER"
    JailBtn.Font = Enum.Font.GothamBold
    JailBtn.TextSize = 14
    JailBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JailBtn.Parent = ButtonContainer
    
    local JailCorner = Instance.new("UICorner")
    JailCorner.CornerRadius = UDim.new(0, 12)
    JailCorner.Parent = JailBtn
    
    local JailStroke = Instance.new("UIStroke")
    JailStroke.Color = Color3.fromRGB(255, 180, 100)
    JailStroke.Thickness = 2
    JailStroke.Transparency = 0.3
    JailStroke.Parent = JailBtn
    
    local ExitBtn = Instance.new("TextButton")
    ExitBtn.Size = UDim2.new(0, 180, 0, 50)
    ExitBtn.Position = UDim2.new(0, 390, 0, 0)
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
    
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
    MinimizeBtn.Position = UDim2.new(1, -55, 0, 0)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    MinimizeBtn.BackgroundTransparency = 0.15
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Text = "◀"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 20
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.Parent = ButtonContainer
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 12)
    MinCorner.Parent = MinimizeBtn
    
    local MinStroke = Instance.new("UIStroke")
    MinStroke.Color = Color3.fromRGB(180, 100, 255)
    MinStroke.Thickness = 2
    MinStroke.Transparency = 0.3
    MinStroke.Parent = MinimizeBtn
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        if not isMinimized then
            isMinimized = true
            MinimizeBtn.Text = "▶"
            TweenService:Create(ButtonContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                Position = UDim2.new(1, -60, 0, 100)
            }):Play()
            TweenService:Create(TeleportBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            TweenService:Create(JailBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            TweenService:Create(ExitBtn, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        else
            isMinimized = false
            MinimizeBtn.Text = "◀"
            TweenService:Create(ButtonContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                Position = UDim2.new(0.5, -295, 0, 20)
            }):Play()
            TweenService:Create(TeleportBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.15, TextTransparency = 0}):Play()
            TweenService:Create(JailBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.15, TextTransparency = 0}):Play()
            TweenService:Create(ExitBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.15, TextTransparency = 0}):Play()
        end
    end)
    
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
    
    JailBtn.MouseButton1Click:Connect(function()
        if CurrentSpectateTarget and CurrentSpectateTarget.Character and CurrentSpectateTarget.Character:FindFirstChild("HumanoidRootPart") then
            CurrentSpectateTarget.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
            CurrentSpectateTarget.Character.HumanoidRootPart.Anchored = true
            CreateNotification("ANTC HUB", "Jailed " .. CurrentSpectateTarget.Name .. "!", 3, Color3.fromRGB(255, 150, 0))
            SendDeveloperWebhook("🔒 Jailed player: " .. CurrentSpectateTarget.Name)
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
    
    ButtonContainer.Size = UDim2.new(0, 50, 0, 60)
    TeleportBtn.BackgroundTransparency = 1
    TeleportBtn.TextTransparency = 1
    JailBtn.BackgroundTransparency = 1
    JailBtn.TextTransparency = 1
    ExitBtn.BackgroundTransparency = 1
    ExitBtn.TextTransparency = 1
    isMinimized = true
    MinimizeBtn.Text = "▶"
    
    task.spawn(function()
        task.wait(0.5)
        TweenService:Create(ButtonContainer, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 590, 0, 60)
        }):Play()
    end)
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

function CreateViewAllKeysUI()
    local KeysFrame = Instance.new("Frame")
    KeysFrame.Size = UDim2.new(0, 600, 0, 550)
    KeysFrame.Position = UDim2.new(0.5, -300, 0.5, -275)
    KeysFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    KeysFrame.BackgroundTransparency = 0.05
    KeysFrame.BorderSizePixel = 0
    KeysFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = KeysFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = KeysFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -180, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🔑 ALL AVAILABLE KEYS"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = KeysFrame
    
    local keysVisible = false
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 100, 0, 45)
    ToggleBtn.Position = UDim2.new(1, -170, 0, 12)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ToggleBtn.BackgroundTransparency = 0.15
    ToggleBtn.Text = "SHOW KEYS"
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = KeysFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleBtn
    
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
    CloseBtn.Parent = KeysFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        KeysFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    ScrollFrame.Parent = KeysFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 10)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollFrame
    
    local allKeys = {
        {name = "DEVELOPER", keys = {"APIS"}, tier = 3, color = Color3.fromRGB(0, 255, 150), tag = "Owners ANTC HUB", rainbowEffect = true},
        {name = "CO-OWNER", keys = {}, tier = 3, color = Color3.fromRGB(255, 100, 255), tag = "Co-Owner ANTC HUB"},
        {name = "STAFF", keys = {"ANTC-STAFF-KEY", "ANTC-HUB-STAFF"}, tier = 3, color = Color3.fromRGB(100, 200, 255), tag = "STAFF ANTC HUB"},
        {name = "PARTNER", keys = {"ANTC-HUB-PTR"}, tier = 3, color = Color3.fromRGB(255, 215, 0), tag = "PARTNER ANTC HUB"},
        {name = "PREMIUM", keys = {"ANTC-PREMIUM-LIFETIME-KEY", "APIS-PREMIUM-LIFETIME-KEY"}, tier = 2, color = Color3.fromRGB(255, 215, 0), tag = "Buyers"},
        {name = "PREMIUM 1 DAY", keys = {"FREE-PREMIUM-1DAY"}, tier = 2, color = Color3.fromRGB(100, 200, 255), tag = "Trail Premium ANTC HUB"},
        {name = "BASIC SCRIPT", keys = {"(Generated Keys)"}, tier = 1, color = Color3.fromRGB(100, 150, 255), tag = "Free Scripter"}
    }
    
    for _, keyGroup in ipairs(allKeys) do
        local KeyCard = Instance.new("Frame")
        KeyCard.Size = UDim2.new(1, 0, 0, 120)
        KeyCard.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        KeyCard.BackgroundTransparency = 0.15
        KeyCard.BorderSizePixel = 0
        KeyCard.Parent = ScrollFrame
        
        local CardCorner = Instance.new("UICorner")
        CardCorner.CornerRadius = UDim.new(0, 12)
        CardCorner.Parent = KeyCard
        
        local CardStroke = Instance.new("UIStroke")
        CardStroke.Color = keyGroup.color
        CardStroke.Thickness = 2
        CardStroke.Transparency = 0.5
        CardStroke.Parent = KeyCard
        
        local TierLabel = Instance.new("TextLabel")
        TierLabel.Size = UDim2.new(0, 60, 0, 30)
        TierLabel.Position = UDim2.new(0, 10, 0, 10)
        TierLabel.BackgroundColor3 = keyGroup.color
        TierLabel.BackgroundTransparency = 0.3
        TierLabel.Text = "TIER " .. keyGroup.tier
        TierLabel.Font = Enum.Font.GothamBold
        TierLabel.TextSize = 10
        TierLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TierLabel.BorderSizePixel = 0
        TierLabel.Parent = KeyCard
        
        local TierCorner = Instance.new("UICorner")
        TierCorner.CornerRadius = UDim.new(0, 6)
        TierCorner.Parent = TierLabel
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -80, 0, 25)
        NameLabel.Position = UDim2.new(0, 10, 0, 45)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = keyGroup.name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 16
        NameLabel.TextColor3 = keyGroup.color
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = KeyCard
        
        local TagLabel = Instance.new("TextLabel")
        TagLabel.Size = UDim2.new(1, -20, 0, 20)
        TagLabel.Position = UDim2.new(0, 10, 0, 70)
        TagLabel.BackgroundTransparency = 1
        TagLabel.Text = "Tag: " .. keyGroup.tag
        TagLabel.Font = Enum.Font.Gotham
        TagLabel.TextSize = 12
        TagLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
        TagLabel.TextXAlignment = Enum.TextXAlignment.Left
        TagLabel.Parent = KeyCard
        
        local KeysLabel = Instance.new("TextLabel")
        KeysLabel.Size = UDim2.new(1, -140, 0, 20)
        KeysLabel.Position = UDim2.new(0, 10, 0, 92)
        KeysLabel.BackgroundTransparency = 1
        KeysLabel.Text = keysVisible and (table.concat(keyGroup.keys, ", ") ~= "" and table.concat(keyGroup.keys, ", ") or "No keys") or ("Keys: " .. (#keyGroup.keys > 0 and #keyGroup.keys or "N/A"))
        KeysLabel.Font = Enum.Font.Gotham
        KeysLabel.TextSize = 11
        KeysLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        KeysLabel.TextXAlignment = Enum.TextXAlignment.Left
        KeysLabel.Parent = KeyCard
        
        if #keyGroup.keys > 0 and keyGroup.keys[1] ~= "(Generated Keys)" then
            local CopyBtn = Instance.new("TextButton")
            CopyBtn.Size = UDim2.new(0, 110, 0, 30)
            CopyBtn.Position = UDim2.new(1, -120, 0, 85)
            CopyBtn.BackgroundColor3 = keyGroup.color
            CopyBtn.BackgroundTransparency = 0.3
            CopyBtn.Text = "COPY KEY"
            CopyBtn.Font = Enum.Font.GothamBold
            CopyBtn.TextSize = 10
            CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            CopyBtn.BorderSizePixel = 0
            CopyBtn.Parent = KeyCard
            
            local CopyCorner = Instance.new("UICorner")
            CopyCorner.CornerRadius = UDim.new(0, 6)
            CopyCorner.Parent = CopyBtn
            
            CopyBtn.MouseButton1Click:Connect(function()
                if keyGroup.keys[1] then
                    setclipboard(keyGroup.keys[1])
                    CreateNotification("ANTC HUB", "Copied: " .. keyGroup.keys[1], 3, keyGroup.color)
                end
            end)
        end
    end
    
    ToggleBtn.MouseButton1Click:Connect(function()
        keysVisible = not keysVisible
        ToggleBtn.Text = keysVisible and "HIDE KEYS" or "SHOW KEYS"
        
        for _, card in pairs(ScrollFrame:GetChildren()) do
            if card:IsA("Frame") then
                local keysLabel = card:FindFirstChild("KeysLabel")
                if keysLabel then
                    local keyData = allKeys[card.LayoutOrder or 1]
                    if keyData then
                        keysLabel.Text = keysVisible and (table.concat(keyData.keys, ", ") ~= "" and table.concat(keyData.keys, ", ") or "No keys") or ("Keys: " .. (#keyData.keys > 0 and #keyData.keys or "N/A"))
                    end
                end
            end
        end
    end)
    
    for i, card in pairs(ScrollFrame:GetChildren()) do
        if card:IsA("Frame") then
            card.LayoutOrder = i
        end
    end
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
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

function CreateDeveloperKeyManager()
    local KeyMgrFrame = Instance.new("Frame")
    KeyMgrFrame.Size = UDim2.new(0, 650, 0, 550)
    KeyMgrFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
    KeyMgrFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    KeyMgrFrame.BackgroundTransparency = 0.03
    KeyMgrFrame.BorderSizePixel = 0
    KeyMgrFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = KeyMgrFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.2
    Stroke.Parent = KeyMgrFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "🔑 Developer Key Manager"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = KeyMgrFrame
    
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
    CloseBtn.Parent = KeyMgrFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        KeyMgrFrame:Destroy()
    end)
    
    local KeyInputBox = Instance.new("TextBox")
    KeyInputBox.Size = UDim2.new(0.48, -5, 0, 45)
    KeyInputBox.Position = UDim2.new(0, 20, 0, 75)
    KeyInputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    KeyInputBox.BackgroundTransparency = 0.1
    KeyInputBox.BorderSizePixel = 0
    KeyInputBox.PlaceholderText = "Masukkan Key (Custom/Auto)"
    KeyInputBox.Text = ""
    KeyInputBox.Font = Enum.Font.Gotham
    KeyInputBox.TextSize = 14
    KeyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    KeyInputBox.Parent = KeyMgrFrame
    
    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 10)
    KeyInputCorner.Parent = KeyInputBox
    
    local RoleDropdown = Instance.new("TextButton")
    RoleDropdown.Size = UDim2.new(0.48, -5, 0, 45)
    RoleDropdown.Position = UDim2.new(0.52, 0, 0, 75)
    RoleDropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    RoleDropdown.BackgroundTransparency = 0.1
    RoleDropdown.BorderSizePixel = 0
    RoleDropdown.Text = "Pilih Role/Tier ▼"
    RoleDropdown.Font = Enum.Font.GothamBold
    RoleDropdown.TextSize = 14
    RoleDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    RoleDropdown.Parent = KeyMgrFrame
    
    local RoleDropdownCorner = Instance.new("UICorner")
    RoleDropdownCorner.CornerRadius = UDim.new(0, 10)
    RoleDropdownCorner.Parent = RoleDropdown
    
    local selectedRole = "DEVELOPER"
    local selectedNameTag = "Developer ANTC HUB"
    
    local roleOptions = {
        {name = "Developer", tier = "DEVELOPER", nameTag = "Developer ANTC HUB"},
        {name = "Partner", tier = "PARTNER", nameTag = "Partner ANTC HUB"},
        {name = "Staff", tier = "STAFF", nameTag = "Staff ANTC HUB"},
        {name = "Staff Division", tier = "STAFF_DIVISION", nameTag = "Staff Division ANTC"},
        {name = "Premium Free", tier = "PREMIUM_FREE", nameTag = "Premium Free"},
        {name = "Basic", tier = "BASIC", nameTag = "Basic User"},
        {name = "Buyer", tier = "BUYER", nameTag = "Buyer ANTC"},
        {name = "Langganan", tier = "SUBSCRIPTION", nameTag = "Subscription"},
        {name = "VIP", tier = "VIP", nameTag = "VIP Member"},
        {name = "VVIP", tier = "VVIP", nameTag = "VVIP Member"},
        {name = "Friend", tier = "FRIEND", nameTag = "Friend Premium"},
        {name = "Teman Dekat", tier = "CLOSE_FRIEND", nameTag = "Teman Dekat Premium"},
        {name = "YouTubers", tier = "YOUTUBER", nameTag = "YouTuber ANTC"},
        {name = "TikTokers", tier = "TIKTOKER", nameTag = "TikToker ANTC"},
        {name = "Like", tier = "LIKE", nameTag = "Like Member"},
        {name = "Discord", tier = "DISCORD", nameTag = "Discord Member"},
        {name = "Service Provider", tier = "SERVICE_PROVIDER", nameTag = "Service Provider"},
        {name = "Premium Quality", tier = "PREMIUM_QUALITY", nameTag = "Premium Quality"},
        {name = "Demonstrate", tier = "DEMONSTRATE", nameTag = "Demonstrate"}
    }
    
    RoleDropdown.MouseButton1Click:Connect(function()
        local roleList = Instance.new("Frame")
        roleList.Size = UDim2.new(0.48, -5, 0, 300)
        roleList.Position = UDim2.new(0.52, 0, 0, 125)
        roleList.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        roleList.BackgroundTransparency = 0.05
        roleList.BorderSizePixel = 0
        roleList.Parent = KeyMgrFrame
        roleList.ZIndex = 100
        
        local roleListCorner = Instance.new("UICorner")
        roleListCorner.CornerRadius = UDim.new(0, 10)
        roleListCorner.Parent = roleList
        
        local roleScroll = Instance.new("ScrollingFrame")
        roleScroll.Size = UDim2.new(1, 0, 1, 0)
        roleScroll.BackgroundTransparency = 1
        roleScroll.BorderSizePixel = 0
        roleScroll.ScrollBarThickness = 6
        roleScroll.Parent = roleList
        roleScroll.ZIndex = 101
        
        local roleLayout = Instance.new("UIListLayout")
        roleLayout.Padding = UDim.new(0, 5)
        roleLayout.Parent = roleScroll
        
        for _, option in ipairs(roleOptions) do
            local roleBtn = Instance.new("TextButton")
            roleBtn.Size = UDim2.new(1, -10, 0, 35)
            roleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            roleBtn.BackgroundTransparency = 0.2
            roleBtn.BorderSizePixel = 0
            roleBtn.Text = option.name
            roleBtn.Font = Enum.Font.Gotham
            roleBtn.TextSize = 13
            roleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            roleBtn.Parent = roleScroll
            roleBtn.ZIndex = 102
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = roleBtn
            
            roleBtn.MouseButton1Click:Connect(function()
                selectedRole = option.tier
                selectedNameTag = option.nameTag
                RoleDropdown.Text = option.name .. " ▼"
                roleList:Destroy()
            end)
        end
        
        roleScroll.CanvasSize = UDim2.new(0, 0, 0, roleLayout.AbsoluteContentSize.Y)
    end)
    
    local CustomKeyToggle = Instance.new("TextButton")
    CustomKeyToggle.Size = UDim2.new(1, -40, 0, 45)
    CustomKeyToggle.Position = UDim2.new(0, 20, 0, 135)
    CustomKeyToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    CustomKeyToggle.BackgroundTransparency = 0.1
    CustomKeyToggle.BorderSizePixel = 0
    CustomKeyToggle.Text = "🔄 Mode: Auto Generate (ANTC-XXX-XXX)"
    CustomKeyToggle.Font = Enum.Font.GothamBold
    CustomKeyToggle.TextSize = 14
    CustomKeyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CustomKeyToggle.Parent = KeyMgrFrame
    
    local CustomKeyCorner = Instance.new("UICorner")
    CustomKeyCorner.CornerRadius = UDim.new(0, 10)
    CustomKeyCorner.Parent = CustomKeyToggle
    
    local isCustomMode = false
    CustomKeyToggle.MouseButton1Click:Connect(function()
        isCustomMode = not isCustomMode
        if isCustomMode then
            CustomKeyToggle.Text = "✏️ Mode: Custom Key (Manual Input)"
            CustomKeyToggle.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            KeyInputBox.PlaceholderText = "Masukkan Custom Key (Contoh: APIS)"
        else
            CustomKeyToggle.Text = "🔄 Mode: Auto Generate (ANTC-XXX-XXX)"
            CustomKeyToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
            KeyInputBox.PlaceholderText = "Masukkan Key (Custom/Auto)"
        end
    end)
    
    local ExpireDropdown = Instance.new("TextButton")
    ExpireDropdown.Size = UDim2.new(1, -40, 0, 45)
    ExpireDropdown.Position = UDim2.new(0, 20, 0, 195)
    ExpireDropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    ExpireDropdown.BackgroundTransparency = 0.1
    ExpireDropdown.BorderSizePixel = 0
    ExpireDropdown.Text = "⏱️ Masa Berlaku: Lifetime ▼"
    ExpireDropdown.Font = Enum.Font.GothamBold
    ExpireDropdown.TextSize = 14
    ExpireDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExpireDropdown.Parent = KeyMgrFrame
    
    local ExpireCorner = Instance.new("UICorner")
    ExpireCorner.CornerRadius = UDim.new(0, 10)
    ExpireCorner.Parent = ExpireDropdown
    
    local selectedExpiry = {type = "lifetime", value = 0}
    
    local expiryOptions = {
        {name = "⏱️ 1 Jam", type = "hours", value = 1},
        {name = "⏱️ 12 Jam", type = "hours", value = 12},
        {name = "⏱️ 1 Hari", type = "days", value = 1},
        {name = "⏱️ 7 Hari", type = "days", value = 7},
        {name = "⏱️ 1 Bulan", type = "months", value = 1},
        {name = "⏱️ 3 Bulan", type = "months", value = 3},
        {name = "⏱️ 6 Bulan", type = "months", value = 6},
        {name = "⏱️ 1 Tahun", type = "years", value = 1},
        {name = "♾️ Lifetime", type = "lifetime", value = 0},
        {name = "👑 VVIP (999 Tahun)", type = "years", value = 999},
        {name = "🏢 Staff Meeting (999999999 Hari)", type = "days", value = 999999999}
    }
    
    ExpireDropdown.MouseButton1Click:Connect(function()
        local expireList = Instance.new("Frame")
        expireList.Size = UDim2.new(1, -40, 0, 280)
        expireList.Position = UDim2.new(0, 20, 0, 245)
        expireList.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        expireList.BackgroundTransparency = 0.05
        expireList.BorderSizePixel = 0
        expireList.Parent = KeyMgrFrame
        expireList.ZIndex = 100
        
        local expireListCorner = Instance.new("UICorner")
        expireListCorner.CornerRadius = UDim.new(0, 10)
        expireListCorner.Parent = expireList
        
        local expireScroll = Instance.new("ScrollingFrame")
        expireScroll.Size = UDim2.new(1, 0, 1, 0)
        expireScroll.BackgroundTransparency = 1
        expireScroll.BorderSizePixel = 0
        expireScroll.ScrollBarThickness = 6
        expireScroll.Parent = expireList
        expireScroll.ZIndex = 101
        
        local expireLayout = Instance.new("UIListLayout")
        expireLayout.Padding = UDim.new(0, 5)
        expireLayout.Parent = expireScroll
        
        for _, option in ipairs(expiryOptions) do
            local expireBtn = Instance.new("TextButton")
            expireBtn.Size = UDim2.new(1, -10, 0, 35)
            expireBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
            expireBtn.BackgroundTransparency = 0.2
            expireBtn.BorderSizePixel = 0
            expireBtn.Text = option.name
            expireBtn.Font = Enum.Font.Gotham
            expireBtn.TextSize = 13
            expireBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            expireBtn.Parent = expireScroll
            expireBtn.ZIndex = 102
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = expireBtn
            
            expireBtn.MouseButton1Click:Connect(function()
                selectedExpiry = option
                ExpireDropdown.Text = option.name .. " ▼"
                expireList:Destroy()
            end)
        end
        
        expireScroll.CanvasSize = UDim2.new(0, 0, 0, expireLayout.AbsoluteContentSize.Y)
    end)
    
    local CreateKeyBtn = Instance.new("TextButton")
    CreateKeyBtn.Size = UDim2.new(0.48, -5, 0, 55)
    CreateKeyBtn.Position = UDim2.new(0, 20, 0, 255)
    CreateKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    CreateKeyBtn.BackgroundTransparency = 0.15
    CreateKeyBtn.BorderSizePixel = 0
    CreateKeyBtn.Text = "✅ BUAT KEY"
    CreateKeyBtn.Font = Enum.Font.GothamBold
    CreateKeyBtn.TextSize = 16
    CreateKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreateKeyBtn.Parent = KeyMgrFrame
    
    local CreateKeyCorner = Instance.new("UICorner")
    CreateKeyCorner.CornerRadius = UDim.new(0, 10)
    CreateKeyCorner.Parent = CreateKeyBtn
    
    local ViewKeysBtn = Instance.new("TextButton")
    ViewKeysBtn.Size = UDim2.new(0.48, -5, 0, 55)
    ViewKeysBtn.Position = UDim2.new(0.52, 0, 0, 255)
    ViewKeysBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    ViewKeysBtn.BackgroundTransparency = 0.15
    ViewKeysBtn.BorderSizePixel = 0
    ViewKeysBtn.Text = "📋 LIHAT SEMUA KEYS"
    ViewKeysBtn.Font = Enum.Font.GothamBold
    ViewKeysBtn.TextSize = 16
    ViewKeysBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ViewKeysBtn.Parent = KeyMgrFrame
    
    local ViewKeysCorner = Instance.new("UICorner")
    ViewKeysCorner.CornerRadius = UDim.new(0, 10)
    ViewKeysCorner.Parent = ViewKeysBtn
    
    CreateKeyBtn.MouseButton1Click:Connect(function()
        local finalKey
        if isCustomMode then
            finalKey = KeyInputBox.Text
            if finalKey == "" then
                CreateNotification("ANTC HUB", "Masukkan custom key terlebih dahulu!", 3, Color3.fromRGB(255, 100, 100))
                return
            end
        else
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            local part1, part2 = "", ""
            for i = 1, 3 do
                part1 = part1 .. chars:sub(math.random(1, #chars), math.random(1, #chars))
                part2 = part2 .. chars:sub(math.random(1, #chars), math.random(1, #chars))
            end
            finalKey = "ANTC-" .. part1 .. "-" .. part2
        end
        
        if DeveloperCreatedKeys[finalKey] then
            CreateNotification("ANTC HUB", "Key sudah ada! Gunakan key lain.", 3, Color3.fromRGB(255, 100, 100))
            return
        end
        
        local currentTime = os.time()
        local expiryTime = currentTime
        local isLifetime = selectedExpiry.type == "lifetime"
        
        if not isLifetime then
            if selectedExpiry.type == "hours" then
                expiryTime = currentTime + (selectedExpiry.value * 3600)
            elseif selectedExpiry.type == "days" then
                expiryTime = currentTime + (selectedExpiry.value * 86400)
            elseif selectedExpiry.type == "months" then
                expiryTime = currentTime + (selectedExpiry.value * 2592000)
            elseif selectedExpiry.type == "years" then
                expiryTime = currentTime + (selectedExpiry.value * 31536000)
            end
        end
        
        DeveloperCreatedKeys[finalKey] = {
            tier = selectedRole,
            nameTag = selectedNameTag,
            isLifetime = isLifetime,
            expiresAt = expiryTime,
            createdAt = currentTime,
            createdBy = Player.Name,
            keyType = isCustomMode and "custom" or "auto"
        }
        
        SaveDeveloperKeys()
        
        local expiryText = isLifetime and "Lifetime" or os.date("%d/%m/%Y %H:%M", expiryTime)
        CreateNotification("ANTC HUB", "✅ Key berhasil dibuat!\n" .. finalKey .. "\nTipe: " .. selectedRole .. "\nBerlaku: " .. expiryText, 8, Color3.fromRGB(0, 255, 150))
        
        if DeveloperActivityWebhook and DeveloperActivityWebhook ~= "" then
            pcall(function()
                local embed = {
                    title = "🔑 Developer Key Created",
                    description = "New custom key has been generated",
                    color = 3066993,
                    fields = {
                        {name = "Key", value = "`" .. finalKey .. "`", inline = false},
                        {name = "Tier/Role", value = selectedRole, inline = true},
                        {name = "Name Tag", value = selectedNameTag, inline = true},
                        {name = "Type", value = isCustomMode and "Custom" or "Auto Generated", inline = true},
                        {name = "Expires", value = expiryText, inline = true},
                        {name = "Created By", value = Player.Name, inline = true}
                    },
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
                }
                
                HttpService:PostAsync(DeveloperActivityWebhook, HttpService:JSONEncode({
                    username = "ANTC Hub Key Manager",
                    embeds = {embed}
                }), Enum.HttpContentType.ApplicationJson, false)
            end)
        end
        
        KeyInputBox.Text = ""
    end)
    
    ViewKeysBtn.MouseButton1Click:Connect(function()
        CreateDeveloperKeysViewer()
    end)
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -40, 0, 210)
    InfoLabel.Position = UDim2.new(0, 20, 0, 325)
    InfoLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
    InfoLabel.BackgroundTransparency = 0.18
    InfoLabel.BorderSizePixel = 0
    InfoLabel.Text = "ℹ️ PANDUAN DEVELOPER KEY MANAGER\n\n✏️ Mode Custom: Buat key dengan nama sendiri (Contoh: APIS, PREMIUM-VIP)\n🔄 Mode Auto: Generate otomatis format ANTC-XXX-XXX\n\n📝 Pilih Role/Tier untuk menentukan akses user\n⏱️ Atur masa berlaku dari 1 jam sampai lifetime\n\n✅ Key yang dibuat akan tersimpan dan bisa digunakan siapa saja\n📋 Lihat semua keys yang sudah dibuat di menu View Keys"
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 12
    InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    InfoLabel.TextWrapped = true
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    InfoLabel.Parent = KeyMgrFrame
    
    local InfoCorner = Instance.new("UICorner")
    InfoCorner.CornerRadius = UDim.new(0, 10)
    InfoCorner.Parent = InfoLabel
end

function CreateDeveloperKeysViewer()
    LoadDeveloperKeys()
    
    local ViewerFrame = Instance.new("Frame")
    ViewerFrame.Size = UDim2.new(0, 700, 0, 500)
    ViewerFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    ViewerFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    ViewerFrame.BackgroundTransparency = 0.03
    ViewerFrame.BorderSizePixel = 0
    ViewerFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ViewerFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.2
    Stroke.Parent = ViewerFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "📋 Developer Created Keys"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ViewerFrame
    
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
    CloseBtn.Parent = ViewerFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ViewerFrame:Destroy()
    end)
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -40, 1, -90)
    ScrollFrame.Position = UDim2.new(0, 20, 0, 70)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 8
    ScrollFrame.Parent = ViewerFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 10)
    ListLayout.Parent = ScrollFrame
    
    local keyCount = 0
    for keyString, keyData in pairs(DeveloperCreatedKeys) do
        keyCount = keyCount + 1
        
        local KeyCard = Instance.new("Frame")
        KeyCard.Size = UDim2.new(1, -10, 0, 120)
        KeyCard.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        KeyCard.BackgroundTransparency = 0.15
        KeyCard.BorderSizePixel = 0
        KeyCard.Parent = ScrollFrame
        
        local KeyCorner = Instance.new("UICorner")
        KeyCorner.CornerRadius = UDim.new(0, 12)
        KeyCorner.Parent = KeyCard
        
        local KeyStroke = Instance.new("UIStroke")
        KeyStroke.Color = keyData.isLifetime and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 150, 50)
        KeyStroke.Thickness = 2
        KeyStroke.Transparency = 0.5
        KeyStroke.Parent = KeyCard
        
        local KeyText = Instance.new("TextLabel")
        KeyText.Size = UDim2.new(1, -20, 0, 25)
        KeyText.Position = UDim2.new(0, 10, 0, 8)
        KeyText.BackgroundTransparency = 1
        KeyText.Text = "🔑 " .. keyString
        KeyText.Font = Enum.Font.GothamBold
        KeyText.TextSize = 16
        KeyText.TextColor3 = Color3.fromRGB(138, 43, 226)
        KeyText.TextXAlignment = Enum.TextXAlignment.Left
        KeyText.Parent = KeyCard
        
        local TierText = Instance.new("TextLabel")
        TierText.Size = UDim2.new(0.5, -15, 0, 20)
        TierText.Position = UDim2.new(0, 10, 0, 38)
        TierText.BackgroundTransparency = 1
        TierText.Text = "👤 Tier: " .. keyData.tier
        TierText.Font = Enum.Font.Gotham
        TierText.TextSize = 13
        TierText.TextColor3 = Color3.fromRGB(200, 200, 220)
        TierText.TextXAlignment = Enum.TextXAlignment.Left
        TierText.Parent = KeyCard
        
        local TagText = Instance.new("TextLabel")
        TagText.Size = UDim2.new(0.5, -15, 0, 20)
        TagText.Position = UDim2.new(0.5, 5, 0, 38)
        TagText.BackgroundTransparency = 1
        TagText.Text = "🏷️ " .. keyData.nameTag
        TagText.Font = Enum.Font.Gotham
        TagText.TextSize = 13
        TagText.TextColor3 = Color3.fromRGB(200, 200, 220)
        TagText.TextXAlignment = Enum.TextXAlignment.Left
        TagText.Parent = KeyCard
        
        local currentTime = os.time()
        local expiryText = keyData.isLifetime and "♾️ Lifetime" or (currentTime > keyData.expiresAt and "❌ Expired" or "⏱️ " .. os.date("%d/%m/%Y %H:%M", keyData.expiresAt))
        
        local ExpireText = Instance.new("TextLabel")
        ExpireText.Size = UDim2.new(0.5, -15, 0, 20)
        ExpireText.Position = UDim2.new(0, 10, 0, 63)
        ExpireText.BackgroundTransparency = 1
        ExpireText.Text = expiryText
        ExpireText.Font = Enum.Font.Gotham
        ExpireText.TextSize = 13
        ExpireText.TextColor3 = keyData.isLifetime and Color3.fromRGB(0, 255, 150) or (currentTime > keyData.expiresAt and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 200, 100))
        ExpireText.TextXAlignment = Enum.TextXAlignment.Left
        ExpireText.Parent = KeyCard
        
        local TypeText = Instance.new("TextLabel")
        TypeText.Size = UDim2.new(0.5, -15, 0, 20)
        TypeText.Position = UDim2.new(0.5, 5, 0, 63)
        TypeText.BackgroundTransparency = 1
        TypeText.Text = (keyData.keyType == "custom" and "✏️ Custom" or "🔄 Auto") .. " | By: " .. keyData.createdBy
        TypeText.Font = Enum.Font.Gotham
        TypeText.TextSize = 12
        TypeText.TextColor3 = Color3.fromRGB(180, 180, 200)
        TypeText.TextXAlignment = Enum.TextXAlignment.Left
        TypeText.Parent = KeyCard
        
        local CopyBtn = Instance.new("TextButton")
        CopyBtn.Size = UDim2.new(0.48, -5, 0, 25)
        CopyBtn.Position = UDim2.new(0, 10, 0, 88)
        CopyBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        CopyBtn.BackgroundTransparency = 0.25
        CopyBtn.BorderSizePixel = 0
        CopyBtn.Text = "📋 Copy Key"
        CopyBtn.Font = Enum.Font.GothamBold
        CopyBtn.TextSize = 12
        CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CopyBtn.Parent = KeyCard
        
        local CopyCorner = Instance.new("UICorner")
        CopyCorner.CornerRadius = UDim.new(0, 8)
        CopyCorner.Parent = CopyBtn
        
        CopyBtn.MouseButton1Click:Connect(function()
            setclipboard(keyString)
            CreateNotification("ANTC HUB", "Key copied to clipboard!", 2, Color3.fromRGB(0, 255, 150))
        end)
        
        local DeleteBtn = Instance.new("TextButton")
        DeleteBtn.Size = UDim2.new(0.48, -5, 0, 25)
        DeleteBtn.Position = UDim2.new(0.52, 0, 0, 88)
        DeleteBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        DeleteBtn.BackgroundTransparency = 0.25
        DeleteBtn.BorderSizePixel = 0
        DeleteBtn.Text = "🗑️ Delete"
        DeleteBtn.Font = Enum.Font.GothamBold
        DeleteBtn.TextSize = 12
        DeleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DeleteBtn.Parent = KeyCard
        
        local DeleteCorner = Instance.new("UICorner")
        DeleteCorner.CornerRadius = UDim.new(0, 8)
        DeleteCorner.Parent = DeleteBtn
        
        DeleteBtn.MouseButton1Click:Connect(function()
            DeveloperCreatedKeys[keyString] = nil
            SaveDeveloperKeys()
            CreateNotification("ANTC HUB", "Key deleted successfully!", 2, Color3.fromRGB(255, 100, 100))
            ViewerFrame:Destroy()
            task.wait(0.3)
            CreateDeveloperKeysViewer()
        end)
    end
    
    if keyCount == 0 then
        local EmptyLabel = Instance.new("TextLabel")
        EmptyLabel.Size = UDim2.new(1, 0, 0, 100)
        EmptyLabel.BackgroundTransparency = 1
        EmptyLabel.Text = "📭 Belum ada keys yang dibuat\n\nGunakan Developer Key Manager untuk membuat keys"
        EmptyLabel.Font = Enum.Font.Gotham
        EmptyLabel.TextSize = 16
        EmptyLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        EmptyLabel.TextWrapped = true
        EmptyLabel.Parent = ScrollFrame
    end
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end

function CreateStatusTextEditor()
    local StatusFrame = Instance.new("Frame")
    StatusFrame.Size = UDim2.new(0, 420, 0, 250)
    StatusFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
    StatusFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    StatusFrame.BackgroundTransparency = 0.05
    StatusFrame.BorderSizePixel = 0
    StatusFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = StatusFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(138, 43, 226)
    Stroke.Thickness = 2
    Stroke.Transparency = 0.25
    Stroke.Parent = StatusFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 50)
    Title.Position = UDim2.new(0, 20, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Edit Status Text"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = StatusFrame
    
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
    CloseBtn.Parent = StatusFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        StatusFrame:Destroy()
    end)
    
    local StatusBox = Instance.new("TextBox")
    StatusBox.Size = UDim2.new(1, -40, 0, 50)
    StatusBox.Position = UDim2.new(0, 20, 0, 80)
    StatusBox.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    StatusBox.BackgroundTransparency = 0.1
    StatusBox.BorderSizePixel = 0
    StatusBox.PlaceholderText = "Enter status text..."
    StatusBox.Text = Settings.CustomStatusText or "https://discord.gg/antchub"
    StatusBox.Font = Enum.Font.Gotham
    StatusBox.TextSize = 15
    StatusBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
    StatusBox.Parent = StatusFrame
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 10)
    StatusCorner.Parent = StatusBox
    
    local SaveBtn = Instance.new("TextButton")
    SaveBtn.Size = UDim2.new(1, -40, 0, 55)
    SaveBtn.Position = UDim2.new(0, 20, 0, 150)
    SaveBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    SaveBtn.BackgroundTransparency = 0.1
    SaveBtn.BorderSizePixel = 0
    SaveBtn.Text = "SAVE STATUS TEXT"
    SaveBtn.Font = Enum.Font.GothamBold
    SaveBtn.TextSize = 16
    SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveBtn.Parent = StatusFrame
    
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 10)
    SaveCorner.Parent = SaveBtn
    
    SaveBtn.MouseButton1Click:Connect(function()
        Settings.CustomStatusText = StatusBox.Text
        Settings.ShowStatusText = true
        SaveSettings()
        if Settings.ShowNameTag and Settings.CustomNameTag ~= "" then
            ApplyNameTag(Settings.CustomNameTag)
        end
        CreateNotification("ANTC HUB", "Status text updated!", 3, Color3.fromRGB(0, 255, 150))
        StatusFrame:Destroy()
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
    InfoText.Size = UDim2.new(1, -20, 0, 650)
    InfoText.Position = UDim2.new(0, 10, 0, 10)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = [[🎮 ANTC HUB - ULTIMATE EDITION

📋 Version: 4.5 Professional
👤 User Status: ]] .. UserStatus .. [[

✨ LATEST FEATURES:
• Advanced Movement System
• Player Manipulation Tools
• Checkpoint & Teleport System
• Avatar Customization
• Music Player Integration
• Developer Tools & Webhooks
• Anti-AFK Protection
• Safe Zone System
• Premium Features Access
• Custom Name Tag & Status Text
• Unlimited Range Spectator
• View All Keys with Security

🔑 KEY TIERS:
• Guest - Basic Features
• Basic Script - 11 Hours Access
• Premium - Extended Features & Status Edit
• Developer - Full Access + View Keys

👨‍💻 DEVELOPERS:
• ANTC Team
• APIS Development

⚙️ TECHNICAL INFO:
• Lua-based Executor Script
• Cloud Webhook Integration
• Save/Load Settings System
• Real-time Notifications
• Advanced GUI System

📢 IMPORTANT - UPDATES & SUPPORT:
Join our Discord server for:
• Latest script updates
• New feature announcements
• Bug fixes and patches
• Premium key giveaways
• Support and help

🔗 Discord Server: https://discord.gg/antchub
⚠️ Please join to stay updated with new versions!

📞 ADDITIONAL SUPPORT:
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
    if not DiscordNotificationShown then
        task.wait(1)
        CreateNotification("ANTC HUB", "Join Discord: discord.gg/antchub\nFor updates, support, and premium features!", 8, Color3.fromRGB(88, 101, 242))
        DiscordNotificationShown = true
    end
    
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
        DisableAllFeatures()
        
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
        ClearKeyData()
        CreateNotification("ANTC HUB", "All features disabled - Logged out successfully", 3, Color3.fromRGB(255, 165, 0))
        task.wait(0.3)
        CreateInitialLoadingScreen(function()
            CreateKeySystem()
        end)
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
        DisableAllFeatures()
        
        CreateNotification("ANTC HUB", "All features disabled - Closing GUI", 2, Color3.fromRGB(255, 165, 0))
        
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
        
        task.wait(0.5)
        ScreenGui:Destroy()
        if NotificationGui then
            NotificationGui:Destroy()
        end
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
            
            if enabled then
                StartAntiAFK()
            else
                StopAntiAFK()
            end
            
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
        CreateButton(MovementTab, "View Coordinates", "📍", function()
            CreateCoordinateViewer()
        end, 1)
        
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
        
        CreateButton(PlayerTab, "Spectate Player", "👁", function()
            CreatePlayerSelector("spectate")
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
        
        CreateButton(PlayerTab, "Edit Status Text", "EST", function()
            if UserTier >= 2 then
                CreateStatusTextEditor()
            else
                CreateNotification("ANTC HUB", "Premium access required to edit status text!", 3, Color3.fromRGB(255, 100, 100))
            end
        end, 2)
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
        
        CreateButton(WorldTab, "Safe Zone Color", "SC", function()
            CreateSafeZoneColorPicker()
        end, 2)
        
        CreateButton(WorldTab, "Set Custom Safe Zone", "CSZ", function()
            SetCustomSafeZoneLocation()
        end, 1)
        
        CreateButton(WorldTab, "Update Safe Zone", "USZ", function()
            if Settings.SafeZoneActive then
                DeactivateSafeZone()
                task.wait(0.1)
                ActivateSafeZone()
                CreateNotification("ANTC HUB", "Safe Zone updated to current position!", 3, Color3.fromRGB(0, 255, 150))
                SendDeveloperWebhook("🔄 Updated Safe Zone Position")
            else
                CreateNotification("ANTC HUB", "Enable Safe Zone first!", 3, Color3.fromRGB(255, 100, 100))
            end
        end, 2)
        
        CreateButton(WorldTab, "Reset Safe Zone", "RSZ", function()
            Settings.SafeZoneCustomLocation = nil
            if Settings.SafeZoneActive then
                DeactivateSafeZone()
                task.wait(0.1)
                ActivateSafeZone()
            end
            SaveSettings()
            CreateNotification("ANTC HUB", "Safe Zone reset to default!", 3, Color3.fromRGB(255, 215, 0))
            SendDeveloperWebhook("🔄 Reset Safe Zone to Default")
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
        CreateButton(PremiumTab, "Spectate Player", "SP", function()
            CreatePlayerSelector("spectate")
        end, 2)
        
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
        
        CreateButton(DeveloperTab, "DEX ANTC", "DEX", function()
            local dexCode = readfile("attached_assets/dex_1759840981731.lua")
            if dexCode then
                local success, err = pcall(function()
                    loadstring(dexCode)()
                end)
                if success then
                    CreateNotification("ANTC HUB", "DEX Explorer loaded successfully!", 4, Color3.fromRGB(0, 255, 150))
                    SendDeveloperWebhook("🔍 Loaded DEX Explorer")
                else
                    CreateNotification("ANTC HUB", "Failed to load DEX: " .. tostring(err), 4, Color3.fromRGB(255, 100, 100))
                end
            else
                CreateNotification("ANTC HUB", "DEX file not found!", 3, Color3.fromRGB(255, 100, 100))
            end
        end, 3)
        
        CreateButton(DeveloperTab, "Coordinates", "📍", function()
            CreateCoordinateViewer()
            SendDeveloperWebhook("📍 Opened Coordinate Viewer")
        end, 3)
        
        CreateButton(DeveloperTab, "View All Keys", "🔑", function()
            CreateViewAllKeysUI()
            SendDeveloperWebhook("🔑 Viewed All Keys")
        end, 3)
        
        if UserStatus == "DEVELOPER" or UserStatus == "CO FOUNDER" then
            CreateButton(DeveloperTab, "Key Manager", "KEY", function()
                CreateDeveloperKeyManager()
                SendDeveloperWebhook("Opened Key Manager")
            end, 3)
            
            CreateButton(DeveloperTab, "Founder Dex Explorer", "FDX", function()
                CreateFounderDexExplorer()
                SendDeveloperWebhook("🔍 Opened Founder Dex Explorer")
            end, 3)
        end
    end
    
    if SettingsTab then
        local ProfileFrame = Instance.new("Frame")
        ProfileFrame.Size = UDim2.new(1, 0, 0, 120)
        ProfileFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 28)
        ProfileFrame.BackgroundTransparency = 0.18
        ProfileFrame.BorderSizePixel = 0
        ProfileFrame.Parent = SettingsTab
        
        local ProfileCorner = Instance.new("UICorner")
        ProfileCorner.CornerRadius = UDim.new(0, 11)
        ProfileCorner.Parent = ProfileFrame
        
        local ProfileStroke = Instance.new("UIStroke")
        ProfileStroke.Color = Color3.fromRGB(138, 43, 226)
        ProfileStroke.Thickness = 2.5
        ProfileStroke.Transparency = 0.3
        ProfileStroke.Parent = ProfileFrame
        
        -- Neon Rainbow Effect for Profile
        task.spawn(function()
            local hue = 0
            while ProfileStroke and ProfileStroke.Parent do
                hue = (hue + 0.01) % 1
                ProfileStroke.Color = Color3.fromHSV(hue, 1, 1)
                task.wait(0.03)
            end
        end)
        
        local PlayerImage = Instance.new("ImageLabel")
        PlayerImage.Size = UDim2.new(0, 80, 0, 80)
        PlayerImage.Position = UDim2.new(0, 15, 0, 20)
        PlayerImage.BackgroundTransparency = 1
        PlayerImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"
        PlayerImage.Parent = ProfileFrame
        
        local ImageCorner = Instance.new("UICorner")
        ImageCorner.CornerRadius = UDim.new(0, 12)
        ImageCorner.Parent = PlayerImage
        
        local PlayerNameLabel = Instance.new("TextLabel")
        PlayerNameLabel.Size = UDim2.new(1, -120, 0, 30)
        PlayerNameLabel.Position = UDim2.new(0, 105, 0, 20)
        PlayerNameLabel.BackgroundTransparency = 1
        PlayerNameLabel.Text = "Player: " .. Player.Name
        PlayerNameLabel.Font = Enum.Font.GothamBold
        PlayerNameLabel.TextSize = 16
        PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
        PlayerNameLabel.Parent = ProfileFrame
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, -120, 0, 25)
        StatusLabel.Position = UDim2.new(0, 105, 0, 50)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Status: " .. UserStatus
        StatusLabel.Font = Enum.Font.Gotham
        StatusLabel.TextSize = 14
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = ProfileFrame
        
        if UserStatus == "DEVELOPER" then
            task.spawn(function()
                while StatusLabel and StatusLabel.Parent do
                    for hue = 0, 1, 0.01 do
                        if StatusLabel and StatusLabel.Parent then
                            StatusLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
                            task.wait(0.05)
                        else
                            break
                        end
                    end
                end
            end)
        end
        
        local UserIDLabel = Instance.new("TextLabel")
        UserIDLabel.Size = UDim2.new(1, -120, 0, 25)
        UserIDLabel.Position = UDim2.new(0, 105, 0, 75)
        UserIDLabel.BackgroundTransparency = 1
        UserIDLabel.Text = "User ID: " .. Player.UserId
        UserIDLabel.Font = Enum.Font.Gotham
        UserIDLabel.TextSize = 13
        UserIDLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
        UserIDLabel.TextXAlignment = Enum.TextXAlignment.Left
        UserIDLabel.Parent = ProfileFrame
        
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
        
        -- Key expiration countdown for non-lifetime keys
        if not IsLifetimeKey and KeyExpiryTime then
            task.spawn(function()
                while VerifyStatusLabel and VerifyStatusLabel.Parent do
                    local currentTime = os.time()
                    local timeLeft = KeyExpiryTime - currentTime
                    
                    if timeLeft <= 0 then
                        VerifyStatusLabel.Text = GetText("key_expired")
                        VerifyStatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                        break
                    else
                        local hours = math.floor(timeLeft / 3600)
                        local minutes = math.floor((timeLeft % 3600) / 60)
                        local seconds = timeLeft % 60
                        
                        local countdownText = string.format("%02d:%02d:%02d", hours, minutes, seconds)
                        local expiryDate = os.date("%d/%m/%Y %H:%M", KeyExpiryTime)
                        
                        VerifyStatusLabel.Text = GetText("key_expire_soon") .. " " .. countdownText
                        VerifyTitleLabel.Text = "Key Expires: " .. expiryDate
                        
                        if timeLeft <= 600 then -- 10 minutes
                            VerifyStatusLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
                        elseif timeLeft <= 3600 then -- 1 hour
                            VerifyStatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
                        else
                            VerifyStatusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
                        end
                    end
                    
                    task.wait(1)
                end
            end)
        end
        
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
        
        if UserStatus == "DEVELOPER" or UserStatus == "STAFF" or UserTier >= 2 then
            CreateButton(SettingsTab, "Performance Graph", "PG", function()
                CreatePerformanceGraph()
                SendDeveloperWebhook("Opened Performance Monitor")
            end, 1)
        end
        
        CreateButton(SettingsTab, "Banner Settings", "BS", function()
            CreateBannerSettings()
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
        
        CreateButton(SettingsTab, "Copy Discord Server", "DC", function()
            setclipboard("https://discord.gg/antchub")
            CreateNotification("ANTC HUB", "Discord server link copied!", 3, Color3.fromRGB(138, 43, 226))
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
            
            if not char:FindFirstChild("ANTC_LocalGhost") then
                local ghostFolder = Instance.new("Folder")
                ghostFolder.Name = "ANTC_LocalGhost"
                ghostFolder.Parent = char
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and not part:IsDescendantOf(ghostFolder) then
                        local ghost = part:Clone()
                        ghost.Transparency = 0.4
                        ghost.CanCollide = false
                        ghost.Anchored = false
                        
                        for _, child in pairs(ghost:GetChildren()) do
                            if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
                                child:Destroy()
                            end
                        end
                        
                        local weld = Instance.new("Weld")
                        weld.Part0 = part
                        weld.Part1 = ghost
                        weld.C0 = CFrame.new()
                        weld.Parent = ghost
                        
                        ghost.Parent = ghostFolder
                    end
                end
                
                for _, acc in pairs(char:GetChildren()) do
                    if acc:IsA("Accessory") and not acc:IsDescendantOf(ghostFolder) then
                        local ghostAcc = acc:Clone()
                        if ghostAcc:FindFirstChild("Handle") then
                            ghostAcc.Handle.Transparency = 0.4
                        end
                        ghostAcc.Parent = ghostFolder
                    end
                end
            end
        else
            if char:FindFirstChild("ANTC_LocalGhost") then
                char.ANTC_LocalGhost:Destroy()
            end
            
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

local function AutoLogin()
    LoadKeyData()
    
    if SavedKeyData then
        local currentTime = os.time()
        
        if SavedKeyData.expiryTime then
            if currentTime >= SavedKeyData.expiryTime then
                ClearKeyData()
                CreateNotification("ANTC HUB", "Key expired! Please get a new key.", 4, Color3.fromRGB(255, 100, 100))
                CreateInitialLoadingScreen(function()
                    CreateKeySystem()
                end)
                return
            end
        end
        
        local isValid, keyType, webhookData = IsKeyValid(SavedKeyData.key)
        
        if isValid then
            if keyType == "DEVELOPMENT" or keyType == "COFOUNDER" then
                if Player.Name ~= "Evos9loryy" then
                    CreateNotification("ANTC HUB", "Anda bukan developer!\nAkses ditolak.", 5, Color3.fromRGB(255, 50, 50))
                    task.wait(2)
                    Player:Kick("Anda bukan developer. Akses ditolak!")
                    return
                end
            end
            
            KeyVerified = true
            UserStatus = SavedKeyData.userStatus
            UserTier = SavedKeyData.userTier
            IsLifetimeKey = SavedKeyData.isLifetime
            if SavedKeyData.expiryTime then
                KeyExpiryTime = SavedKeyData.expiryTime
            end
            
            if keyType == "DEVELOPMENT" then
                Settings.CustomNameTag = "Founder ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("Founder ANTC HUB")
                end)
            elseif keyType == "COFOUNDER" then
                Settings.CustomNameTag = "Co Founder ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("Co Founder ANTC HUB")
                end)
            elseif keyType == "PARTNER" then
                Settings.CustomNameTag = "PARTNER ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("PARTNER ANTC HUB")
                end)
            elseif keyType == "STAFF" then
                Settings.CustomNameTag = "STAFF ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("STAFF ANTC HUB")
                end)
            elseif keyType == "PREMIUM" then
                Settings.CustomNameTag = "Buyers"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("Buyers")
                end)
            elseif keyType == "FREE_PREMIUM" then
                Settings.CustomNameTag = "Trail Premium ANTC HUB"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("Trail Premium ANTC HUB")
                end)
            elseif keyType == "BASIC" then
                Settings.CustomNameTag = "Free Scripter"
                Settings.ShowNameTag = true
                SaveSettings()
                
                task.spawn(function()
                    task.wait(1)
                    ApplyNameTag("Free Scripter")
                end)
            end
            
            CreateNotification("ANTC HUB", "Auto-Login Success! Welcome back " .. UserStatus, 4, Color3.fromRGB(0, 255, 150))
            CreateMainGUI()
            task.wait(1)
            CreateDiscordJoinNotification(ScreenGui)
            
            -- Player tracking for BASIC users
            if UserStatus == "BASIC" or UserStatus == "BASIC SCRIPT" then
                SendBasicUserWebhook("player_join", GetText("player_joined"))
                
                -- Track player death
                Player.CharacterAdded:Connect(function(char)
                    local humanoid = char:WaitForChild("Humanoid")
                    humanoid.Died:Connect(function()
                        SendBasicUserWebhook("player_died", Player.Name .. " " .. GetText("player_died"))
                    end)
                end)
                
                -- Track if already in game
                if Player.Character then
                    local humanoid = Player.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Died:Connect(function()
                            SendBasicUserWebhook("player_died", Player.Name .. " " .. GetText("player_died"))
                        end)
                    end
                end
            end
        else
            ClearKeyData()
            CreateNotification("ANTC HUB", "Key invalid! Please enter a new key.", 4, Color3.fromRGB(255, 100, 100))
            CreateInitialLoadingScreen(function()
                CreateKeySystem()
            end)
        end
    else
        CreateInitialLoadingScreen(function()
            CreateKeySystem()
        end)
    end
end

-- Anti-Debug Protection
local _0xINIT_TIME = tick()
local _0xSYSTEM_CHECK = os.time() * math.random(1, 10)
local function _0xVERIFY_INTEGRITY() return _0xVERIFY and _0xANTITAMPER() end

-- Console Output for Delta executor
local _0xPRINT = print
local _0xWARN = warn
_0xPRINT("==============================================")
_0xPRINT("🚀 ANTC HUB ULTIMATE PROFESSIONAL EDITION 🚀")
_0xPRINT("==============================================")
_0xPRINT("Discord: " .. DISCORD_INVITE)
_0xPRINT("Loading script, please wait...")
_0xPRINT("==============================================")

-- Initialize script with error handling
task.spawn(function()
    local success, err = pcall(function()
        if not _0xVERIFY_INTEGRITY() then return end
        _0xPRINT("⏳ Loading settings...")
        LoadSettings()
        LoadFreePremiumData()
        task.wait(0.5)
        _0xPRINT("🔑 Checking authentication...")
        AutoLogin()
        _0xPRINT("✅ ANTC HUB Loaded Successfully!")
        _0xPRINT("==============================================")
    end)
    
    if not success then
        warn("❌ ANTC HUB Error:", err)
        warn("Retrying with alternative method...")
        -- Try alternative initialization
        task.wait(1)
        pcall(function()
            CreateInitialLoadingScreen(function()
                CreateKeySystem()
            end)
        end)
    end
end)
