--[[
    OrbsUI Library
    Version: 1.0.0
    Usage: local OrbsUI = loadstring(game:HttpGet("RAW_URL"))()
]]

local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ICONS = {
    home        = "rbxassetid://7733960981",
    settings    = "rbxassetid://7734053495",
    user        = "rbxassetid://7733974796",
    sword       = "rbxassetid://7734014785",
    eye         = "rbxassetid://7734053476",
    zap         = "rbxassetid://7734014757",
    shield      = "rbxassetid://7733942387",
    star        = "rbxassetid://7734053548",
    target      = "rbxassetid://7734014807",
    map         = "rbxassetid://7733960985",
    lock        = "rbxassetid://7733960971",
    unlock      = "rbxassetid://7733960987",
    bell        = "rbxassetid://7733942307",
    trash       = "rbxassetid://7734014815",
    edit        = "rbxassetid://7733942363",
    check       = "rbxassetid://7733942335",
    close       = "rbxassetid://7733942347",
    plus        = "rbxassetid://7734014799",
    minus       = "rbxassetid://7733960983",
    arrow_right = "rbxassetid://7733942295",
    arrow_left  = "rbxassetid://7733942289",
    arrow_up    = "rbxassetid://7733942299",
    arrow_down  = "rbxassetid://7733942293",
    refresh     = "rbxassetid://7734014803",
    download    = "rbxassetid://7733942357",
    upload      = "rbxassetid://7733942393",
    search      = "rbxassetid://7734014789",
    info        = "rbxassetid://7733942379",
    warning     = "rbxassetid://7733942397",
    danger      = "rbxassetid://7733942353",
    heart       = "rbxassetid://7733942373",
    chat        = "rbxassetid://7733942341",
    camera      = "rbxassetid://7733942325",
    music       = "rbxassetid://7733942383",
    run         = "rbxassetid://7734014785",
    fly         = "rbxassetid://7733942369",
    speed       = "rbxassetid://7733942391",
    ghost       = "rbxassetid://7733942371",
    aimbot      = "rbxassetid://7734014807",
    esp         = "rbxassetid://7733942363",
    misc        = "rbxassetid://7733942387",
    visual      = "rbxassetid://7733942393",
    combat      = "rbxassetid://7734014785",
    movement    = "rbxassetid://7733942369",
    script      = "rbxassetid://7734053495",
    player      = "rbxassetid://7733974796",
    world       = "rbxassetid://7733960985",
    money       = "rbxassetid://7733942383",
    kill        = "rbxassetid://7734014757",
    teleport    = "rbxassetid://7734014815",
}

local THEMES = {
    Purple = {
        Accent      = Color3.fromRGB(120, 80, 220),
        AccentLight = Color3.fromRGB(180, 140, 255),
        AccentDark  = Color3.fromRGB(80, 50, 160),
    },
    Red = {
        Accent      = Color3.fromRGB(220, 60, 60),
        AccentLight = Color3.fromRGB(255, 120, 120),
        AccentDark  = Color3.fromRGB(160, 40, 40),
    },
    Cyan = {
        Accent      = Color3.fromRGB(30, 180, 220),
        AccentLight = Color3.fromRGB(100, 220, 255),
        AccentDark  = Color3.fromRGB(20, 130, 170),
    },
    Green = {
        Accent      = Color3.fromRGB(40, 180, 100),
        AccentLight = Color3.fromRGB(100, 220, 150),
        AccentDark  = Color3.fromRGB(25, 130, 70),
    },
    Gold = {
        Accent      = Color3.fromRGB(210, 160, 30),
        AccentLight = Color3.fromRGB(255, 210, 80),
        AccentDark  = Color3.fromRGB(160, 120, 20),
    },
    Orange = {
        Accent      = Color3.fromRGB(220, 110, 30),
        AccentLight = Color3.fromRGB(255, 160, 80),
        AccentDark  = Color3.fromRGB(160, 80, 20),
    },
    Pink = {
        Accent      = Color3.fromRGB(200, 50, 160),
        AccentLight = Color3.fromRGB(255, 100, 210),
        AccentDark  = Color3.fromRGB(150, 30, 120),
    },
    White = {
        Accent      = Color3.fromRGB(200, 200, 210),
        AccentLight = Color3.fromRGB(240, 240, 255),
        AccentDark  = Color3.fromRGB(160, 160, 180),
    },
}

local BASE = {
    BG          = Color3.fromRGB(18, 18, 28),
    BGSecondary = Color3.fromRGB(24, 24, 38),
    BGTertiary  = Color3.fromRGB(30, 30, 46),
    TopBar      = Color3.fromRGB(22, 22, 34),
    Border      = Color3.fromRGB(50, 50, 75),
    TextPrimary = Color3.fromRGB(220, 210, 255),
    TextMuted   = Color3.fromRGB(130, 115, 180),
    TextDim     = Color3.fromRGB(80, 70, 120),
    White       = Color3.fromRGB(255, 255, 255),
    Green       = Color3.fromRGB(40, 200, 70),
    Red         = Color3.fromRGB(255, 80, 80),
}

local function lerp(a, b, t) return a + (b - a) * t end
local function lerpColor(a, b, t)
    return Color3.new(
        lerp(a.R, b.R, t),
        lerp(a.G, b.G, t),
        lerp(a.B, b.B, t)
    )
end

local function tween(obj, props, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(duration or 0.15, style, direction), props):Play()
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function makePadding(parent, t, b, l, r)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, t or 0)
    p.PaddingBottom = UDim.new(0, b or 0)
    p.PaddingLeft = UDim.new(0, l or 0)
    p.PaddingRight = UDim.new(0, r or 0)
    p.Parent = parent
    return p
end

local function makeStroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or BASE.Border
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.5
    s.Parent = parent
    return s
end

local function makeListLayout(parent, direction, padding, halign)
    local l = Instance.new("UIListLayout")
    l.FillDirection = direction or Enum.FillDirection.Vertical
    l.Padding = UDim.new(0, padding or 6)
    l.HorizontalAlignment = halign or Enum.HorizontalAlignment.Left
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = parent
    return l
end

local function getIcon(name)
    return ICONS[name:lower()] or ICONS["info"]
end

local function createImageLabel(parent, iconName, size, pos, color)
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, size or 16, 0, size or 16)
    img.Position = pos or UDim2.new(0, 0, 0, 0)
    img.BackgroundTransparency = 1
    img.Image = getIcon(iconName or "info")
    img.ImageColor3 = color or BASE.TextMuted
    img.Parent = parent
    return img
end

function OrbsUI.new(options)
    options = options or {}
    local self = setmetatable({}, OrbsUI)

    self.Title       = options.Title or "Orbs"
    self.Description = options.Description or "By FrontEvill"
    self.Theme       = THEMES[options.Theme] or THEMES.Purple
    self.CurrentTheme = options.Theme or "Purple"
    self.Tabs        = {}
    self.ActiveTab   = nil
    self.Dragging    = false
    self.DragStart   = nil
    self.StartPos    = nil
    self.Visible     = true

    self:_build()
    return self
end

function OrbsUI:_build()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OrbsUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true

    local ok, _ = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not ok then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = UDim2.new(0, 500, 0, 340)
    Window.Position = UDim2.new(0.5, -250, 0.5, -170)
    Window.BackgroundColor3 = BASE.BG
    Window.BorderSizePixel = 0
    makeCorner(Window, 12)
    makeStroke(Window, BASE.Border, 1.5, 0.4)
    Window.Parent = ScreenGui

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 38)
    TopBar.BackgroundColor3 = BASE.TopBar
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 5
    makeCorner(TopBar, 12)
    TopBar.Parent = Window

    local TopBarFix = Instance.new("Frame")
    TopBarFix.Size = UDim2.new(1, 0, 0.5, 0)
    TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarFix.BackgroundColor3 = BASE.TopBar
    TopBarFix.BorderSizePixel = 0
    TopBarFix.ZIndex = 4
    TopBarFix.Parent = TopBar

    local BtnRow = Instance.new("Frame")
    BtnRow.Size = UDim2.new(0, 80, 1, 0)
    BtnRow.Position = UDim2.new(0, 10, 0, 0)
    BtnRow.BackgroundTransparency = 1
    BtnRow.ZIndex = 6
    BtnRow.Parent = TopBar

    local function makeWinBtn(color, xpos)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 12, 0, 12)
        b.Position = UDim2.new(0, xpos, 0.5, -6)
        b.BackgroundColor3 = color
        b.Text = ""
        b.BorderSizePixel = 0
        b.ZIndex = 7
        makeCorner(b, 6)
        b.Parent = BtnRow
        return b
    end

    local CloseBtn = makeWinBtn(Color3.fromRGB(255, 95, 87), 0)
    makeWinBtn(Color3.fromRGB(254, 188, 46), 18)
    makeWinBtn(Color3.fromRGB(40, 200, 64), 36)

    CloseBtn.MouseButton1Click:Connect(function()
        self:Toggle()
    end)

    local TitleBlock = Instance.new("Frame")
    TitleBlock.Size = UDim2.new(0, 180, 1, 0)
    TitleBlock.Position = UDim2.new(1, -190, 0, 0)
    TitleBlock.BackgroundTransparency = 1
    TitleBlock.ZIndex = 6
    TitleBlock.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0.55, 0)
    TitleLabel.Position = UDim2.new(0, 0, 0.05, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = self.Title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 13
    TitleLabel.TextColor3 = BASE.TextPrimary
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Right
    TitleLabel.ZIndex = 7
    TitleLabel.Parent = TitleBlock

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, 0, 0.4, 0)
    DescLabel.Position = UDim2.new(0, 0, 0.58, 0)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = self.Description
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 10
    DescLabel.TextColor3 = BASE.TextDim
    DescLabel.TextXAlignment = Enum.TextXAlignment.Right
    DescLabel.ZIndex = 7
    DescLabel.Parent = TitleBlock

    local Divider1 = Instance.new("Frame")
    Divider1.Size = UDim2.new(1, 0, 0, 1)
    Divider1.Position = UDim2.new(0, 0, 0, 38)
    Divider1.BackgroundColor3 = BASE.Border
    Divider1.BackgroundTransparency = 0.6
    Divider1.BorderSizePixel = 0
    Divider1.Parent = Window

    local TabsFrame = Instance.new("Frame")
    TabsFrame.Name = "TabsFrame"
    TabsFrame.Size = UDim2.new(1, -24, 0, 34)
    TabsFrame.Position = UDim2.new(0, 12, 0, 46)
    TabsFrame.BackgroundTransparency = 1
    TabsFrame.ClipsDescendants = true
    TabsFrame.Parent = Window

    local TabsLayout = makeListLayout(TabsFrame, Enum.FillDirection.Horizontal, 6)
    TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    local Divider2 = Instance.new("Frame")
    Divider2.Size = UDim2.new(1, 0, 0, 1)
    Divider2.Position = UDim2.new(0, 0, 0, 80)
    Divider2.BackgroundColor3 = BASE.Border
    Divider2.BackgroundTransparency = 0.6
    Divider2.BorderSizePixel = 0
    Divider2.Parent = Window

    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -24, 1, -130)
    ContentArea.Position = UDim2.new(0, 12, 0, 90)
    ContentArea.BackgroundTransparency = 1
    ContentArea.ClipsDescendants = true
    ContentArea.Parent = Window

    local PlayerCard = Instance.new("Frame")
    PlayerCard.Name = "PlayerCard"
    PlayerCard.Size = UDim2.new(0, 110, 1, 0)
    PlayerCard.BackgroundColor3 = BASE.BGTertiary
    PlayerCard.BorderSizePixel = 0
    makeCorner(PlayerCard, 10)
    makeStroke(PlayerCard, BASE.Border, 1, 0.6)
    PlayerCard.Parent = ContentArea

    local AvatarFrame = Instance.new("Frame")
    AvatarFrame.Size = UDim2.new(0, 56, 0, 56)
    AvatarFrame.Position = UDim2.new(0.5, -28, 0, 14)
    AvatarFrame.BackgroundColor3 = Color3.fromRGB(40, 25, 80)
    AvatarFrame.BorderSizePixel = 0
    makeCorner(AvatarFrame, 10)
    makeStroke(AvatarFrame, self.Theme.AccentLight, 1.5, 0.6)
    AvatarFrame.Parent = PlayerCard

    local AvatarImg = Instance.new("ImageLabel")
    AvatarImg.Size = UDim2.new(1, 0, 1, 0)
    AvatarImg.BackgroundTransparency = 1
    AvatarImg.ScaleType = Enum.ScaleType.Fit
    AvatarImg.Parent = AvatarFrame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -10, 0, 18)
    NameLabel.Position = UDim2.new(0, 5, 0, 76)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 11
    NameLabel.TextColor3 = BASE.TextPrimary
    NameLabel.TextXAlignment = Enum.TextXAlignment.Center
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    NameLabel.Text = LocalPlayer.DisplayName or LocalPlayer.Name
    NameLabel.Parent = PlayerCard

    local TagLabel = Instance.new("TextLabel")
    TagLabel.Size = UDim2.new(1, -10, 0, 14)
    TagLabel.Position = UDim2.new(0, 5, 0, 94)
    TagLabel.BackgroundTransparency = 1
    TagLabel.Font = Enum.Font.Gotham
    TagLabel.TextSize = 10
    TagLabel.TextColor3 = BASE.TextDim
    TagLabel.TextXAlignment = Enum.TextXAlignment.Center
    TagLabel.Text = "@" .. LocalPlayer.Name
    TagLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TagLabel.Parent = PlayerCard

    local function loadAvatar()
        local userId = LocalPlayer.UserId
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size150x150
        local ok2, url = pcall(function()
            return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
        end)
        if ok2 then
            AvatarImg.Image = url
        end
    end
    task.spawn(loadAvatar)

    local MainPanel = Instance.new("Frame")
    MainPanel.Name = "MainPanel"
    MainPanel.Size = UDim2.new(1, -120, 1, 0)
    MainPanel.Position = UDim2.new(0, 120, 0, 0)
    MainPanel.BackgroundTransparency = 1
    MainPanel.Parent = ContentArea

    local StatusBar = Instance.new("Frame")
    StatusBar.Size = UDim2.new(1, 0, 0, 26)
    StatusBar.Position = UDim2.new(0, 0, 1, -26)
    StatusBar.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
    StatusBar.BorderSizePixel = 0
    StatusBar.Parent = Window

    local StatusBarCorner = Instance.new("UICorner")
    StatusBarCorner.CornerRadius = UDim.new(0, 12)
    StatusBarCorner.Parent = StatusBar

    local StatusBarFix = Instance.new("Frame")
    StatusBarFix.Size = UDim2.new(1, 0, 0.5, 0)
    StatusBarFix.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
    StatusBarFix.BorderSizePixel = 0
    StatusBarFix.Parent = StatusBar

    local StatusDot = Instance.new("Frame")
    StatusDot.Size = UDim2.new(0, 6, 0, 6)
    StatusDot.Position = UDim2.new(0, 12, 0.5, -3)
    StatusDot.BackgroundColor3 = BASE.Green
    StatusDot.BorderSizePixel = 0
    makeCorner(StatusDot, 3)
    StatusDot.Parent = StatusBar

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, -30, 1, 0)
    StatusText.Position = UDim2.new(0, 22, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 10
    StatusText.TextColor3 = BASE.TextDim
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Text = "Connected — Orbs v1.0"
    StatusText.Parent = StatusBar

    self._gui        = ScreenGui
    self._window     = Window
    self._tabsFrame  = TabsFrame
    self._mainPanel  = MainPanel
    self._statusText = StatusText
    self._avatarStroke = makeStroke(AvatarFrame, self.Theme.AccentLight, 1.5, 0.6)
    self._titleLabel = TitleLabel
    self._descLabel  = DescLabel

    self:_setupDrag(TopBar, Window)
end

function OrbsUI:_setupDrag(handle, window)
    local dragging = false
    local dragInput, mousePos, framePos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = window.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            local newPos = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
            tween(window, {Position = newPos}, 0.05)
        end
    end)
end

function OrbsUI:SetStatus(text, isError)
    self._statusText.Text = text or "Ready"
    self._statusText.TextColor3 = isError and BASE.Red or BASE.TextDim
end

function OrbsUI:SetTheme(themeName)
    local theme = THEMES[themeName]
    if not theme then return end
    self.Theme = theme
    self.CurrentTheme = themeName

    for _, tabData in ipairs(self.Tabs) do
        tabData._btn.TextColor3 = BASE.TextMuted
        tabData._btn.BackgroundTransparency = 1
        if tabData._iconImg then
            tabData._iconImg.ImageColor3 = BASE.TextMuted
        end
    end

    if self.ActiveTab then
        local btn = self.ActiveTab._btn
        tween(btn, {BackgroundColor3 = lerpColor(theme.Accent, BASE.BG, 0.75), BackgroundTransparency = 0}, 0.2)
        btn.TextColor3 = theme.AccentLight
        if self.ActiveTab._iconImg then
            self.ActiveTab._iconImg.ImageColor3 = theme.AccentLight
        end
    end
end

function OrbsUI:AddTab(options)
    options = options or {}
    local tabName = options.Name or "Tab"
    local iconName = options.Icon or "info"

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 0, 1, 0)
    TabBtn.AutomaticSize = Enum.AutomaticSize.X
    TabBtn.BackgroundColor3 = BASE.BGTertiary
    TabBtn.BackgroundTransparency = 1
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12
    TabBtn.TextColor3 = BASE.TextMuted
    TabBtn.Text = ""
    TabBtn.BorderSizePixel = 0
    makeCorner(TabBtn, 6)
    TabBtn.Parent = self._tabsFrame

    local TabBtnLayout = Instance.new("UIListLayout")
    TabBtnLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBtnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TabBtnLayout.Padding = UDim.new(0, 5)
    TabBtnLayout.Parent = TabBtn

    makePadding(TabBtn, 5, 5, 10, 10)

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 14, 0, 14)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = getIcon(iconName)
    iconImg.ImageColor3 = BASE.TextMuted
    iconImg.Parent = TabBtn

    local tabText = Instance.new("TextLabel")
    tabText.BackgroundTransparency = 1
    tabText.Font = Enum.Font.GothamSemibold
    tabText.TextSize = 12
    tabText.TextColor3 = BASE.TextMuted
    tabText.Text = tabName
    tabText.AutomaticSize = Enum.AutomaticSize.X
    tabText.Size = UDim2.new(0, 0, 1, 0)
    tabText.Parent = TabBtn

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = BASE.Border
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.Visible = false
    ScrollFrame.Parent = self._mainPanel

    local ItemLayout = makeListLayout(ScrollFrame, Enum.FillDirection.Vertical, 6)
    makePadding(ScrollFrame, 4, 8, 4, 4)

    local tabData = {
        Name     = tabName,
        _btn     = TabBtn,
        _text    = tabText,
        _iconImg = iconImg,
        _scroll  = ScrollFrame,
        _layout  = ItemLayout,
    }

    table.insert(self.Tabs, tabData)

    TabBtn.MouseButton1Click:Connect(function()
        self:_selectTab(tabData)
    end)

    TabBtn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tabData then
            tween(TabBtn, {BackgroundTransparency = 0.8, BackgroundColor3 = BASE.BGTertiary}, 0.1)
        end
    end)

    TabBtn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tabData then
            tween(TabBtn, {BackgroundTransparency = 1}, 0.1)
        end
    end)

    if #self.Tabs == 1 then
        self:_selectTab(tabData)
    end

    local tabAPI = {}

    function tabAPI:AddToggle(opts)
        opts = opts or {}
        local label    = opts.Name or "Toggle"
        local default  = opts.Default or false
        local iconN    = opts.Icon
        local callback = opts.Callback or function() end
        local state    = default

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, -8, 0, 36)
        Row.BackgroundColor3 = BASE.BGSecondary
        Row.BorderSizePixel = 0
        makeCorner(Row, 7)
        makeStroke(Row, BASE.Border, 1, 0.7)
        Row.Parent = ScrollFrame

        if iconN then
            createImageLabel(Row, iconN, 14, UDim2.new(0, 10, 0.5, -7), BASE.TextMuted)
        end

        local LabelTxt = Instance.new("TextLabel")
        LabelTxt.Size = UDim2.new(1, -(iconN and 70 or 55), 1, 0)
        LabelTxt.Position = UDim2.new(0, iconN and 30 or 12, 0, 0)
        LabelTxt.BackgroundTransparency = 1
        LabelTxt.Font = Enum.Font.Gotham
        LabelTxt.TextSize = 12
        LabelTxt.TextColor3 = BASE.TextPrimary
        LabelTxt.TextXAlignment = Enum.TextXAlignment.Left
        LabelTxt.Text = label
        LabelTxt.Parent = Row

        local ToggleTrack = Instance.new("Frame")
        ToggleTrack.Size = UDim2.new(0, 32, 0, 17)
        ToggleTrack.Position = UDim2.new(1, -42, 0.5, -8.5)
        ToggleTrack.BackgroundColor3 = state and tabData._btn.BackgroundColor3 or Color3.fromRGB(50, 50, 75)
        ToggleTrack.BorderSizePixel = 0
        makeCorner(ToggleTrack, 9)
        makeStroke(ToggleTrack, BASE.Border, 1, 0.5)
        ToggleTrack.Parent = Row

        local Thumb = Instance.new("Frame")
        Thumb.Size = UDim2.new(0, 12, 0, 12)
        Thumb.Position = state and UDim2.new(0, 17, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        Thumb.BackgroundColor3 = BASE.White
        Thumb.BorderSizePixel = 0
        makeCorner(Thumb, 6)
        Thumb.Parent = ToggleTrack

        local function updateToggle(val)
            state = val
            local theme = tabData._btn.Parent.Parent.Parent
            local accent = OrbsUI._instances and OrbsUI._instances[1] and OrbsUI._instances[1].Theme.Accent or Color3.fromRGB(120, 80, 220)
            tween(ToggleTrack, {BackgroundColor3 = val and accent or Color3.fromRGB(50,50,75)}, 0.15)
            tween(Thumb, {Position = val and UDim2.new(0,17,0.5,-6) or UDim2.new(0,2,0.5,-6)}, 0.15)
            callback(val)
        end

        if state then
            ToggleTrack.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
            Thumb.Position = UDim2.new(0, 17, 0.5, -6)
        end

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 2
        btn.Parent = Row

        btn.MouseButton1Click:Connect(function()
            updateToggle(not state)
        end)

        local toggleAPI = {}
        function toggleAPI:Set(val) updateToggle(val) end
        function toggleAPI:Get() return state end
        return toggleAPI
    end

    function tabAPI:AddSlider(opts)
        opts = opts or {}
        local label    = opts.Name or "Slider"
        local min      = opts.Min or 0
        local max      = opts.Max or 100
        local default  = opts.Default or min
        local suffix   = opts.Suffix or ""
        local iconN    = opts.Icon
        local callback = opts.Callback or function() end
        local value    = math.clamp(default, min, max)

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, -8, 0, 50)
        Row.BackgroundColor3 = BASE.BGSecondary
        Row.BorderSizePixel = 0
        makeCorner(Row, 7)
        makeStroke(Row, BASE.Border, 1, 0.7)
        Row.Parent = ScrollFrame

        if iconN then
            createImageLabel(Row, iconN, 14, UDim2.new(0, 10, 0, 10), BASE.TextMuted)
        end

        local TopRow = Instance.new("Frame")
        TopRow.Size = UDim2.new(1, -20, 0, 20)
        TopRow.Position = UDim2.new(0, 10, 0, 8)
        TopRow.BackgroundTransparency = 1
        TopRow.Parent = Row

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Size = UDim2.new(0.7, 0, 1, 0)
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.TextSize = 12
        SliderLabel.TextColor3 = BASE.TextPrimary
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        SliderLabel.Text = label
        SliderLabel.Parent = TopRow

        local ValLabel = Instance.new("TextLabel")
        ValLabel.Size = UDim2.new(0.3, 0, 1, 0)
        ValLabel.Position = UDim2.new(0.7, 0, 0, 0)
        ValLabel.BackgroundTransparency = 1
        ValLabel.Font = Enum.Font.GothamBold
        ValLabel.TextSize = 12
        ValLabel.TextColor3 = self.Theme and self.Theme.AccentLight or Color3.fromRGB(180,140,255)
        ValLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValLabel.Text = tostring(math.floor(value)) .. suffix
        ValLabel.Parent = TopRow

        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(1, -20, 0, 4)
        Track.Position = UDim2.new(0, 10, 0, 36)
        Track.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
        Track.BorderSizePixel = 0
        makeCorner(Track, 2)
        Track.Parent = Row

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(120, 80, 220)
        Fill.BorderSizePixel = 0
        makeCorner(Fill, 2)
        Fill.Parent = Track

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 12, 0, 12)
        Knob.Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6)
        Knob.BackgroundColor3 = BASE.White
        Knob.BorderSizePixel = 0
        makeCorner(Knob, 6)
        makeStroke(Knob, Color3.fromRGB(120,80,220), 1.5, 0)
        Knob.Parent = Track

        local draggingSlider = false

        local function updateSlider(inputPos)
            local trackAbs = Track.AbsolutePosition
            local trackSize = Track.AbsoluteSize
            local rel = math.clamp((inputPos.X - trackAbs.X) / trackSize.X, 0, 1)
            value = math.floor(min + (max - min) * rel)
            local pct = (value - min) / (max - min)
            Fill.Size = UDim2.new(pct, 0, 1, 0)
            Knob.Position = UDim2.new(pct, -6, 0.5, -6)
            ValLabel.Text = tostring(value) .. suffix
            callback(value)
        end

        Track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = true
                updateSlider(input.Position)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or
               input.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input.Position)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = false
            end
        end)

        local sliderAPI = {}
        function sliderAPI:Set(val)
            value = math.clamp(val, min, max)
            local pct = (value - min) / (max - min)
            Fill.Size = UDim2.new(pct, 0, 1, 0)
            Knob.Position = UDim2.new(pct, -6, 0.5, -6)
            ValLabel.Text = tostring(math.floor(value)) .. suffix
            callback(value)
        end
        function sliderAPI:Get() return value end
        return sliderAPI
    end

    function tabAPI:AddButton(opts)
        opts = opts or {}
        local label    = opts.Name or "Button"
        local iconN    = opts.Icon
        local callback = opts.Callback or function() end

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -8, 0, 34)
        Btn.BackgroundColor3 = lerpColor(Color3.fromRGB(120,80,220), BASE.BG, 0.75)
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextSize = 12
        Btn.TextColor3 = Color3.fromRGB(180, 140, 255)
        Btn.Text = ""
        Btn.BorderSizePixel = 0
        makeCorner(Btn, 7)
        makeStroke(Btn, Color3.fromRGB(150,100,255), 1, 0.5)
        Btn.Parent = ScrollFrame

        local BtnInner = Instance.new("Frame")
        BtnInner.Size = UDim2.new(1, 0, 1, 0)
        BtnInner.BackgroundTransparency = 1
        BtnInner.Parent = Btn

        local innerLayout = Instance.new("UIListLayout")
        innerLayout.FillDirection = Enum.FillDirection.Horizontal
        innerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        innerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        innerLayout.Padding = UDim.new(0, 6)
        innerLayout.Parent = BtnInner

        if iconN then
            local ico = Instance.new("ImageLabel")
            ico.Size = UDim2.new(0, 14, 0, 14)
            ico.BackgroundTransparency = 1
            ico.Image = getIcon(iconN)
            ico.ImageColor3 = Color3.fromRGB(180, 140, 255)
            ico.Parent = BtnInner
        end

        local BtnText = Instance.new("TextLabel")
        BtnText.BackgroundTransparency = 1
        BtnText.Font = Enum.Font.GothamSemibold
        BtnText.TextSize = 12
        BtnText.TextColor3 = Color3.fromRGB(180, 140, 255)
        BtnText.Text = label
        BtnText.AutomaticSize = Enum.AutomaticSize.X
        BtnText.Size = UDim2.new(0, 0, 1, 0)
        BtnText.Parent = BtnInner

        Btn.MouseEnter:Connect(function()
            tween(Btn, {BackgroundColor3 = lerpColor(Color3.fromRGB(120,80,220), BASE.BG, 0.55)}, 0.1)
        end)
        Btn.MouseLeave:Connect(function()
            tween(Btn, {BackgroundColor3 = lerpColor(Color3.fromRGB(120,80,220), BASE.BG, 0.75)}, 0.1)
        end)
        Btn.MouseButton1Click:Connect(function()
            tween(Btn, {BackgroundTransparency = 0.3}, 0.05)
            task.delay(0.1, function()
                tween(Btn, {BackgroundTransparency = 0}, 0.1)
            end)
            callback()
        end)

        local btnAPI = {}
        function btnAPI:SetText(t) BtnText.Text = t end
        return btnAPI
    end

    function tabAPI:AddInput(opts)
        opts = opts or {}
        local label    = opts.Name or "Input"
        local placeholder = opts.Placeholder or "Type here..."
        local default  = opts.Default or ""
        local iconN    = opts.Icon
        local callback = opts.Callback or function() end

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, -8, 0, 52)
        Row.BackgroundColor3 = BASE.BGSecondary
        Row.BorderSizePixel = 0
        makeCorner(Row, 7)
        makeStroke(Row, BASE.Border, 1, 0.7)
        Row.Parent = ScrollFrame

        local LabelTxt = Instance.new("TextLabel")
        LabelTxt.Size = UDim2.new(1, -20, 0, 18)
        LabelTxt.Position = UDim2.new(0, 10, 0, 6)
        LabelTxt.BackgroundTransparency = 1
        LabelTxt.Font = Enum.Font.Gotham
        LabelTxt.TextSize = 10
        LabelTxt.TextColor3 = BASE.TextDim
        LabelTxt.TextXAlignment = Enum.TextXAlignment.Left
        LabelTxt.Text = label:upper()
        LabelTxt.LetterSpacing = 1
        LabelTxt.Parent = Row

        local InputBox = Instance.new("TextBox")
        InputBox.Size = UDim2.new(1, -20, 0, 22)
        InputBox.Position = UDim2.new(0, 10, 0, 24)
        InputBox.BackgroundColor3 = Color3.fromRGB(25, 25, 42)
        InputBox.Font = Enum.Font.Gotham
        InputBox.TextSize = 12
        InputBox.TextColor3 = BASE.TextPrimary
        InputBox.PlaceholderText = placeholder
        InputBox.PlaceholderColor3 = BASE.TextDim
        InputBox.Text = default
        InputBox.ClearTextOnFocus = false
        InputBox.BorderSizePixel = 0
        makeCorner(InputBox, 5)
        makeStroke(InputBox, BASE.Border, 1, 0.5)
        InputBox.Parent = Row

        makePadding(InputBox, 0, 0, 8, 8)

        InputBox.FocusLost:Connect(function(enter)
            callback(InputBox.Text, enter)
        end)

        local inputAPI = {}
        function inputAPI:Set(val) InputBox.Text = val end
        function inputAPI:Get() return InputBox.Text end
        return inputAPI
    end

    function tabAPI:AddDropdown(opts)
        opts = opts or {}
        local label    = opts.Name or "Dropdown"
        local items    = opts.Items or {}
        local default  = opts.Default or (items[1] or "Select...")
        local iconN    = opts.Icon
        local callback = opts.Callback or function() end
        local selected = default
        local open     = false

        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, -8, 0, 36)
        Container.BackgroundTransparency = 1
        Container.ClipsDescendants = false
        Container.BorderSizePixel = 0
        Container.ZIndex = 10
        Container.Parent = ScrollFrame

        local Header = Instance.new("TextButton")
        Header.Size = UDim2.new(1, 0, 1, 0)
        Header.BackgroundColor3 = BASE.BGSecondary
        Header.Text = ""
        Header.BorderSizePixel = 0
        Header.ZIndex = 10
        makeCorner(Header, 7)
        makeStroke(Header, BASE.Border, 1, 0.7)
        Header.Parent = Container

        if iconN then
            createImageLabel(Header, iconN, 14, UDim2.new(0, 10, 0.5, -7), BASE.TextMuted)
        end

        local HeaderLabel = Instance.new("TextLabel")
        HeaderLabel.Size = UDim2.new(1, -50, 1, 0)
        HeaderLabel.Position = UDim2.new(0, iconN and 30 or 12, 0, 0)
        HeaderLabel.BackgroundTransparency = 1
        HeaderLabel.Font = Enum.Font.Gotham
        HeaderLabel.TextSize = 12
        HeaderLabel.TextColor3 = BASE.TextPrimary
        HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
        HeaderLabel.Text = selected
        HeaderLabel.Parent = Header

        local Arrow = Instance.new("TextLabel")
        Arrow.Size = UDim2.new(0, 20, 1, 0)
        Arrow.Position = UDim2.new(1, -28, 0, 0)
        Arrow.BackgroundTransparency = 1
        Arrow.Font = Enum.Font.GothamBold
        Arrow.TextSize = 12
        Arrow.TextColor3 = BASE.TextMuted
        Arrow.Text = "▾"
        Arrow.Parent = Header

        local Dropdown = Instance.new("Frame")
        Dropdown.Size = UDim2.new(1, 0, 0, 0)
        Dropdown.Position = UDim2.new(0, 0, 1, 4)
        Dropdown.BackgroundColor3 = BASE.BGTertiary
        Dropdown.BorderSizePixel = 0
        Dropdown.ClipsDescendants = true
        Dropdown.ZIndex = 20
        makeCorner(Dropdown, 7)
        makeStroke(Dropdown, BASE.Border, 1, 0.5)
        Dropdown.Parent = Container

        local ItemLayout = makeListLayout(Dropdown, Enum.FillDirection.Vertical, 2)
        makePadding(Dropdown, 4, 4, 4, 4)

        for _, item in ipairs(items) do
            local ItemBtn = Instance.new("TextButton")
            ItemBtn.Size = UDim2.new(1, 0, 0, 28)
            ItemBtn.BackgroundColor3 = BASE.BGTertiary
            ItemBtn.BackgroundTransparency = 1
            ItemBtn.Font = Enum.Font.Gotham
            ItemBtn.TextSize = 12
            ItemBtn.TextColor3 = BASE.TextPrimary
            ItemBtn.Text = item
            ItemBtn.ZIndex = 21
            makeCorner(ItemBtn, 5)
            ItemBtn.Parent = Dropdown

            ItemBtn.MouseEnter:Connect(function()
                tween(ItemBtn, {BackgroundTransparency = 0.6, BackgroundColor3 = BASE.BGSecondary}, 0.1)
            end)
            ItemBtn.MouseLeave:Connect(function()
                tween(ItemBtn, {BackgroundTransparency = 1}, 0.1)
            end)
            ItemBtn.MouseButton1Click:Connect(function()
                selected = item
                HeaderLabel.Text = item
                open = false
                tween(Dropdown, {Size = UDim2.new(1, 0, 0, 0)}, 0.15)
                tween(Container, {Size = UDim2.new(1, -8, 0, 36)}, 0.15)
                callback(item)
            end)
        end

        Header.MouseButton1Click:Connect(function()
            open = not open
            local itemH = #items * 30 + 8
            if open then
                tween(Dropdown, {Size = UDim2.new(1, 0, 0, itemH)}, 0.2)
                tween(Container, {Size = UDim2.new(1, -8, 0, 36 + itemH + 4)}, 0.2)
            else
                tween(Dropdown, {Size = UDim2.new(1, 0, 0, 0)}, 0.15)
                tween(Container, {Size = UDim2.new(1, -8, 0, 36)}, 0.15)
            end
        end)

        local ddAPI = {}
        function ddAPI:Set(val)
            if table.find(items, val) then
                selected = val
                HeaderLabel.Text = val
                callback(val)
            end
        end
        function ddAPI:Get() return selected end
        return ddAPI
    end

    function tabAPI:AddLabel(opts)
        opts = opts or {}
        local text = opts.Text or "Label"

        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1, -8, 0, 20)
        Lbl.BackgroundTransparency = 1
        Lbl.Font = Enum.Font.GothamBold
        Lbl.TextSize = 10
        Lbl.TextColor3 = BASE.TextDim
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.Text = text:upper()
        Lbl.LetterSpacing = 1
        Lbl.Parent = ScrollFrame

        local lblAPI = {}
        function lblAPI:Set(t) Lbl.Text = t end
        return lblAPI
    end

    function tabAPI:AddColorPicker(opts)
        opts = opts or {}
        local label    = opts.Name or "Theme Color"
        local callback = opts.Callback or function() end

        local colorNames = {"Purple","Red","Cyan","Green","Gold","Orange","Pink","White"}
        local colorVals = {
            Color3.fromRGB(120,80,220),
            Color3.fromRGB(220,60,60),
            Color3.fromRGB(30,180,220),
            Color3.fromRGB(40,180,100),
            Color3.fromRGB(210,160,30),
            Color3.fromRGB(220,110,30),
            Color3.fromRGB(200,50,160),
            Color3.fromRGB(200,200,210),
        }

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, -8, 0, 58)
        Row.BackgroundColor3 = BASE.BGSecondary
        Row.BorderSizePixel = 0
        makeCorner(Row, 7)
        makeStroke(Row, BASE.Border, 1, 0.7)
        Row.Parent = ScrollFrame

        local LblTxt = Instance.new("TextLabel")
        LblTxt.Size = UDim2.new(1, -20, 0, 18)
        LblTxt.Position = UDim2.new(0, 10, 0, 6)
        LblTxt.BackgroundTransparency = 1
        LblTxt.Font = Enum.Font.GothamBold
        LblTxt.TextSize = 10
        LblTxt.TextColor3 = BASE.TextDim
        LblTxt.TextXAlignment = Enum.TextXAlignment.Left
        LblTxt.Text = label:upper()
        LblTxt.LetterSpacing = 1
        LblTxt.Parent = Row

        local SwatchRow = Instance.new("Frame")
        SwatchRow.Size = UDim2.new(1, -20, 0, 22)
        SwatchRow.Position = UDim2.new(0, 10, 0, 28)
        SwatchRow.BackgroundTransparency = 1
        SwatchRow.Parent = Row

        local SwatchLayout = makeListLayout(SwatchRow, Enum.FillDirection.Horizontal, 6)
        SwatchLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local swatchBtns = {}
        for i, name in ipairs(colorNames) do
            local sw = Instance.new("TextButton")
            sw.Size = UDim2.new(0, 18, 0, 18)
            sw.BackgroundColor3 = colorVals[i]
            sw.Text = ""
            sw.BorderSizePixel = 0
            makeCorner(sw, 4)
            makeStroke(sw, BASE.White, 2, i == 1 and 0 or 1)
            sw.Parent = SwatchRow
            table.insert(swatchBtns, {btn = sw, name = name})

            sw.MouseButton1Click:Connect(function()
                for _, s in ipairs(swatchBtns) do
                    s.btn:FindFirstChildOfClass("UIStroke").Transparency = 1
                end
                sw:FindFirstChildOfClass("UIStroke").Transparency = 0
                callback(name, colorVals[i])
            end)
        end
    end

    function tabAPI:AddSeparator()
        local Sep = Instance.new("Frame")
        Sep.Size = UDim2.new(1, -8, 0, 1)
        Sep.BackgroundColor3 = BASE.Border
        Sep.BackgroundTransparency = 0.6
        Sep.BorderSizePixel = 0
        Sep.Parent = ScrollFrame
    end

    return tabAPI
end

function OrbsUI:_selectTab(tabData)
    for _, t in ipairs(self.Tabs) do
        t._scroll.Visible = false
        tween(t._btn, {BackgroundTransparency = 1}, 0.15)
        t._text.TextColor3 = BASE.TextMuted
        if t._iconImg then t._iconImg.ImageColor3 = BASE.TextMuted end
    end

    tabData._scroll.Visible = true
    tween(tabData._btn, {
        BackgroundColor3 = lerpColor(self.Theme.Accent, BASE.BG, 0.75),
        BackgroundTransparency = 0
    }, 0.15)
    tabData._text.TextColor3 = self.Theme.AccentLight
    if tabData._iconImg then tabData._iconImg.ImageColor3 = self.Theme.AccentLight end
    self.ActiveTab = tabData
end

function OrbsUI:Toggle()
    self.Visible = not self.Visible
    self._window.Visible = self.Visible
end

function OrbsUI:Destroy()
    self._gui:Destroy()
end

return OrbsUI
