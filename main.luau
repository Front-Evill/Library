--[[
    OrbsUI Library v3.0
    Usage: local OrbsUI = loadstring(game:HttpGet("RAW_URL"))()
]]

local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")

local LP = Players.LocalPlayer

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
    fly         = "rbxassetid://7733942369",
    speed       = "rbxassetid://7733942391",
    ghost       = "rbxassetid://7733942371",
    misc        = "rbxassetid://7733942387",
    visual      = "rbxassetid://7733942393",
    combat      = "rbxassetid://7734014785",
    movement    = "rbxassetid://7733942369",
    player      = "rbxassetid://7733974796",
    world       = "rbxassetid://7733960985",
    kill        = "rbxassetid://7734014757",
    teleport    = "rbxassetid://7734014815",
    signal      = "rbxassetid://7733942391",
    save        = "rbxassetid://7733942363",
    terminal    = "rbxassetid://7734053495",
    play        = "rbxassetid://7734014757",
    wrench      = "rbxassetid://7733942387",
    run         = "rbxassetid://7734014785",
    script      = "rbxassetid://7734053495",
    money       = "rbxassetid://7733942383",
    note        = "rbxassetid://7733942383",
    plug        = "rbxassetid://7733942387",
    locate      = "rbxassetid://7733960985",
    logs        = "rbxassetid://7734053495",
    ruler       = "rbxassetid://7734014807",
    scroll      = "rbxassetid://7733942383",
    phone       = "rbxassetid://7733942341",
    aimbot      = "rbxassetid://7734014807",
    esp         = "rbxassetid://7733942363",
}

local THEMES = {
    Purple = { A = Color3.fromRGB(130,85,235),  AL = Color3.fromRGB(185,150,255), AD = Color3.fromRGB(85,55,170) },
    Red    = { A = Color3.fromRGB(225,65,65),   AL = Color3.fromRGB(255,130,130), AD = Color3.fromRGB(165,40,40) },
    Cyan   = { A = Color3.fromRGB(35,185,225),  AL = Color3.fromRGB(110,225,255), AD = Color3.fromRGB(22,135,175) },
    Green  = { A = Color3.fromRGB(45,185,105),  AL = Color3.fromRGB(110,225,160), AD = Color3.fromRGB(28,135,72) },
    Gold   = { A = Color3.fromRGB(215,165,32),  AL = Color3.fromRGB(255,215,85),  AD = Color3.fromRGB(165,122,20) },
    Orange = { A = Color3.fromRGB(225,115,32),  AL = Color3.fromRGB(255,165,85),  AD = Color3.fromRGB(165,82,20) },
    Pink   = { A = Color3.fromRGB(205,55,165),  AL = Color3.fromRGB(255,110,215), AD = Color3.fromRGB(155,32,122) },
    White  = { A = Color3.fromRGB(205,205,215), AL = Color3.fromRGB(245,245,255), AD = Color3.fromRGB(165,165,178) },
}

local C = {
    BG   = Color3.fromRGB(14, 14, 22),
    S1   = Color3.fromRGB(20, 20, 32),
    S2   = Color3.fromRGB(26, 26, 40),
    S3   = Color3.fromRGB(32, 32, 48),
    S4   = Color3.fromRGB(38, 38, 56),
    Bdr  = Color3.fromRGB(48, 48, 72),
    Txt  = Color3.fromRGB(225, 218, 255),
    TxtS = Color3.fromRGB(135, 122, 185),
    TxtD = Color3.fromRGB(75,  68,  115),
    W    = Color3.fromRGB(255, 255, 255),
    G    = Color3.fromRGB(42,  205, 75),
    R    = Color3.fromRGB(235, 68,  68),
    Warn = Color3.fromRGB(240, 162, 30),
}

local function tw(obj, t, props, sty, dir)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.18,
            sty or Enum.EasingStyle.Quint,
            dir or Enum.EasingDirection.Out),
        props):Play()
end
local function cr(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 8); c.Parent = p; return c
end
local function sk(p, col, thick, trans)
    local s = Instance.new("UIStroke")
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Color = col or C.Bdr; s.Thickness = thick or 1; s.Transparency = trans or 0
    s.Parent = p; return s
end
local function pd(p, t, b, l, r)
    local u = Instance.new("UIPadding")
    u.PaddingTop = UDim.new(0,t or 0); u.PaddingBottom = UDim.new(0,b or 0)
    u.PaddingLeft = UDim.new(0,l or 0); u.PaddingRight = UDim.new(0,r or 0)
    u.Parent = p
end
local function vl(p, sp)
    local l = Instance.new("UIListLayout")
    l.FillDirection = Enum.FillDirection.Vertical
    l.HorizontalAlignment = Enum.HorizontalAlignment.Left
    l.VerticalAlignment = Enum.VerticalAlignment.Top
    l.Padding = UDim.new(0, sp or 0)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = p; return l
end
local function hl(p, sp, ha, va)
    local l = Instance.new("UIListLayout")
    l.FillDirection = Enum.FillDirection.Horizontal
    l.HorizontalAlignment = ha or Enum.HorizontalAlignment.Left
    l.VerticalAlignment = va or Enum.VerticalAlignment.Center
    l.Padding = UDim.new(0, sp or 0)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Parent = p; return l
end
local function fr(parent, bg, bgT)
    local f = Instance.new("Frame")
    f.BackgroundColor3 = bg or C.BG
    f.BackgroundTransparency = bgT or 0
    f.BorderSizePixel = 0; f.Parent = parent; return f
end
local function lb(parent, text, sz, font, col)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1; l.Text = text or ""
    l.TextSize = sz or 13; l.Font = font or Enum.Font.GothamMedium
    l.TextColor3 = col or C.Txt; l.TextXAlignment = Enum.TextXAlignment.Left
    l.BorderSizePixel = 0; l.Parent = parent; return l
end
local function bt(parent)
    local b = Instance.new("TextButton")
    b.BackgroundTransparency = 1; b.Text = ""; b.BorderSizePixel = 0
    b.Parent = parent; return b
end
local function ic(parent, name, sz, col)
    local i = Instance.new("ImageLabel")
    i.BackgroundTransparency = 1
    i.Size = UDim2.fromOffset(sz or 14, sz or 14)
    i.Image = ICONS[(name or ""):lower()] or ""
    i.ImageColor3 = col or C.TxtS; i.ScaleType = Enum.ScaleType.Fit
    i.Parent = parent; return i
end
local function lerp3(a, b, t)
    return Color3.new(a.R+(b.R-a.R)*t, a.G+(b.G-a.G)*t, a.B+(b.B-a.B)*t)
end
local function fmtTime(s)
    local h = math.floor(s/3600); local m = math.floor((s%3600)/60); local sc = math.floor(s%60)
    if h > 0 then return string.format("%02d:%02d:%02d",h,m,sc) end
    return string.format("%02d:%02d",m,sc)
end
local function drag(win, handle)
    local d,ds,sp = false,nil,nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            d=true; ds=i.Position; sp=win.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then d=false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if d and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - ds
            win.Position = UDim2.new(sp.X.Scale, sp.X.Offset+delta.X, sp.Y.Scale, sp.Y.Offset+delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then d=false end
    end)
end

function OrbsUI.new(cfg)
    cfg = cfg or {}
    local self       = setmetatable({}, OrbsUI)
    self.Title       = cfg.Title       or "Orbs"
    self.Desc        = cfg.Description or "By FrontEvill"
    self.TH          = THEMES[cfg.Theme] or THEMES.Purple
    self.ThemeName   = cfg.Theme or "Purple"
    self.MinKey      = cfg.MinimizeKey or Enum.KeyCode.RightShift
    self.Tabs        = {}
    self.ActiveTab   = nil
    self.Visible     = true
    self._t0         = tick()
    self._notifN     = 0
    self._switching  = false
    self:_build()
    return self
end

function OrbsUI:_applyTheme(TH)
    self.TH = TH
    local refs = self._themeRefs
    if not refs then return end

    tw(refs.winStroke,    0.25, {Color = lerp3(TH.A, C.Bdr, 0.5)})
    tw(refs.topBar,       0.25, {BackgroundColor3 = lerp3(TH.A, C.BG, 0.88)})
    tw(refs.topBarFix,    0.25, {BackgroundColor3 = lerp3(TH.A, C.BG, 0.88)})
    tw(refs.topLine,      0.25, {BackgroundColor3 = lerp3(TH.A, C.Bdr, 0.65)})
    tw(refs.titleLbl,     0.25, {TextColor3 = TH.AL})
    tw(refs.descLbl,      0.25, {TextColor3 = lerp3(TH.A, C.TxtD, 0.5)})
    tw(refs.tabsDivider,  0.25, {BackgroundColor3 = lerp3(TH.A, C.Bdr, 0.7)})
    tw(refs.tabsDivider2, 0.25, {BackgroundColor3 = lerp3(TH.A, C.Bdr, 0.7)})
    tw(refs.pcardStroke,  0.25, {Color = lerp3(TH.A, C.Bdr, 0.45)})
    tw(refs.avatarStroke, 0.25, {Color = TH.AL})
    tw(refs.avatarBg,     0.25, {BackgroundColor3 = lerp3(TH.A, C.BG, 0.82)})
    tw(refs.statusDot2,   0.25, {BackgroundColor3 = TH.A})
    tw(refs.floatBtn,     0.25, {BackgroundColor3 = TH.A})
    tw(refs.floatStroke,  0.25, {Color = TH.AL})
    tw(refs.uptimeLbl,    0.25, {TextColor3 = lerp3(TH.A, C.TxtD, 0.6)})

    for _, t in ipairs(self.Tabs) do
        if t._dot then tw(t._dot, 0.25, {BackgroundColor3 = TH.A}) end
        if t == self.ActiveTab then
            tw(t._btn, 0.25, {BackgroundColor3 = lerp3(TH.A, C.BG, 0.82)})
            if t._txtLbl  then tw(t._txtLbl,  0.25, {TextColor3  = TH.AL}) end
            if t._iconImg then tw(t._iconImg, 0.25, {ImageColor3 = TH.AL}) end
            if t._dotLine then tw(t._dotLine, 0.25, {BackgroundColor3 = TH.A}) end
        end
        if t._accentBar then tw(t._accentBar, 0.25, {BackgroundColor3 = TH.A}) end
    end
end

function OrbsUI:_build()
    local TH = self.TH

    local Screen = Instance.new("ScreenGui")
    Screen.Name = "OrbsUI"; Screen.ResetOnSpawn = false
    Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Screen.IgnoreGuiInset = true
    local ok = pcall(function() Screen.Parent = game:GetService("CoreGui") end)
    if not ok then Screen.Parent = LP:WaitForChild("PlayerGui") end

    local NotifHolder = fr(Screen, Color3.new(), 1)
    NotifHolder.Size = UDim2.new(0,320,1,-28)
    NotifHolder.Position = UDim2.new(1,-328,1,-14)
    NotifHolder.AnchorPoint = Vector2.new(0,1)
    NotifHolder.ZIndex = 900
    local nhl = vl(NotifHolder, 7)
    nhl.VerticalAlignment = Enum.VerticalAlignment.Bottom
    nhl.HorizontalAlignment = Enum.HorizontalAlignment.Right

    local WIN_W, WIN_H = 560, 390
    local Window = fr(Screen, C.BG)
    Window.Size        = UDim2.fromOffset(WIN_W, WIN_H)
    Window.Position    = UDim2.fromScale(0.5, 0.5)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.ZIndex      = 10
    cr(Window, 14)
    local winStroke = sk(Window, lerp3(TH.A, C.Bdr, 0.5), 1.5, 0.3)

    local TopBar = fr(Window, lerp3(TH.A, C.BG, 0.88))
    TopBar.Size   = UDim2.new(1, 0, 0, 44)
    TopBar.ZIndex = 11
    cr(TopBar, 14)
    local TopBarFix = fr(TopBar, lerp3(TH.A, C.BG, 0.88))
    TopBarFix.Size     = UDim2.new(1, 0, 0.5, 0)
    TopBarFix.Position = UDim2.new(0, 0, 0.5, 0)
    TopBarFix.ZIndex   = 11
    local TopLine = fr(TopBar, lerp3(TH.A, C.Bdr, 0.65), 0.4)
    TopLine.Size     = UDim2.new(1, 0, 0, 1)
    TopLine.Position = UDim2.new(0, 0, 1, 0)
    TopLine.ZIndex   = 12

    local BtnRow = fr(TopBar, Color3.new(), 1)
    BtnRow.Size = UDim2.new(0,72,1,0); BtnRow.Position = UDim2.fromOffset(12,0); BtnRow.ZIndex = 12
    hl(BtnRow, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

    local function wBtn(col)
        local b = Instance.new("TextButton")
        b.Size = UDim2.fromOffset(13,13); b.BackgroundColor3 = col
        b.Text = ""; b.BorderSizePixel = 0; b.ZIndex = 13; b.Parent = BtnRow; cr(b, 7); return b
    end
    local CloseB = wBtn(Color3.fromRGB(255,95,87))
    wBtn(Color3.fromRGB(254,188,46))
    wBtn(Color3.fromRGB(40,200,64))

    local TitleBlock = fr(TopBar, Color3.new(), 1)
    TitleBlock.Size = UDim2.new(0,220,1,0); TitleBlock.Position = UDim2.new(1,-228,0,0); TitleBlock.ZIndex = 12

    local TitleLbl = lb(TitleBlock, self.Title, 14, Enum.Font.GothamBold, TH.AL)
    TitleLbl.Size = UDim2.new(1,0,0,18); TitleLbl.Position = UDim2.fromOffset(0,6)
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Right; TitleLbl.ZIndex = 13

    local DescLbl = lb(TitleBlock, self.Desc, 10, Enum.Font.Gotham, lerp3(TH.A, C.TxtD, 0.5))
    DescLbl.Size = UDim2.new(1,0,0,13); DescLbl.Position = UDim2.fromOffset(0,26)
    DescLbl.TextXAlignment = Enum.TextXAlignment.Right; DescLbl.ZIndex = 13

    local UptimeLbl = lb(Window, "00:00", 10, Enum.Font.GothamMedium, lerp3(TH.A, C.TxtD, 0.6))
    UptimeLbl.Size = UDim2.new(0,80,0,14); UptimeLbl.Position = UDim2.new(0,14,1,-22); UptimeLbl.ZIndex = 12

    local StatusDot2 = fr(Window, TH.A)
    StatusDot2.Size = UDim2.fromOffset(6,6); StatusDot2.Position = UDim2.new(1,-22,1,-22); StatusDot2.ZIndex = 12; cr(StatusDot2,3)

    local TabsDivider = fr(Window, lerp3(TH.A, C.Bdr, 0.7), 0.4)
    TabsDivider.Size = UDim2.new(1,0,0,1); TabsDivider.Position = UDim2.fromOffset(0,44); TabsDivider.ZIndex = 12

    local TabsOuter = fr(Window, Color3.new(), 1)
    TabsOuter.Size = UDim2.new(1,-28,0,36); TabsOuter.Position = UDim2.fromOffset(14,50); TabsOuter.ZIndex = 11

    local TabsFrame = fr(TabsOuter, Color3.new(), 1)
    TabsFrame.Size = UDim2.fromScale(1,1); TabsFrame.ZIndex = 11
    hl(TabsFrame, 4, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

    local TabsDivider2 = fr(Window, lerp3(TH.A, C.Bdr, 0.7), 0.4)
    TabsDivider2.Size = UDim2.new(1,0,0,1); TabsDivider2.Position = UDim2.fromOffset(0,86); TabsDivider2.ZIndex = 12

    local BodyArea = fr(Window, Color3.new(), 1)
    BodyArea.Size     = UDim2.new(1,-28,1,-116)
    BodyArea.Position = UDim2.fromOffset(14,92)
    BodyArea.ZIndex   = 11
    BodyArea.ClipsDescendants = true

    local PCARD_W = 118

    local PlayerCard = fr(BodyArea, C.S1)
    PlayerCard.Size     = UDim2.new(0, PCARD_W, 1, 0)
    PlayerCard.Position = UDim2.fromOffset(0, 0)
    PlayerCard.ZIndex   = 12
    cr(PlayerCard, 12)
    local pcardStroke = sk(PlayerCard, lerp3(TH.A, C.Bdr, 0.45), 1.5, 0.25)

    local AvatarBg = fr(PlayerCard, lerp3(TH.A, C.BG, 0.82))
    AvatarBg.Size        = UDim2.fromOffset(62, 62)
    AvatarBg.Position    = UDim2.new(0.5, -31, 0, 14)
    AvatarBg.ZIndex      = 13
    cr(AvatarBg, 14)
    local avatarStroke = sk(AvatarBg, TH.AL, 2, 0.25)

    local AvatarImg = Instance.new("ImageLabel")
    AvatarImg.BackgroundTransparency = 1; AvatarImg.Size = UDim2.new(1,0,1,0)
    AvatarImg.ScaleType = Enum.ScaleType.Fit; AvatarImg.ZIndex = 14; AvatarImg.Parent = AvatarBg
    cr(AvatarImg, 13)

    task.spawn(function()
        local ok2, url = pcall(function()
            return Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if ok2 then AvatarImg.Image = url end
    end)

    local DisplayLbl = lb(PlayerCard, LP.DisplayName, 12, Enum.Font.GothamBold, C.Txt)
    DisplayLbl.Size = UDim2.new(1,-12,0,16); DisplayLbl.Position = UDim2.new(0,6,0,82)
    DisplayLbl.TextXAlignment = Enum.TextXAlignment.Center; DisplayLbl.TextTruncate = Enum.TextTruncate.AtEnd
    DisplayLbl.ZIndex = 13

    local UserLbl = lb(PlayerCard, "@"..LP.Name, 10, Enum.Font.Gotham, C.TxtS)
    UserLbl.Size = UDim2.new(1,-12,0,14); UserLbl.Position = UDim2.new(0,6,0,99)
    UserLbl.TextXAlignment = Enum.TextXAlignment.Center; UserLbl.TextTruncate = Enum.TextTruncate.AtEnd
    UserLbl.ZIndex = 13

    local Sep2 = fr(PlayerCard, C.Bdr, 0.65)
    Sep2.Size = UDim2.new(1,-20,0,1); Sep2.Position = UDim2.new(0,10,0,120); Sep2.ZIndex = 13

    local AgeLbl = lb(PlayerCard, LP.AccountAge.."d old", 9, Enum.Font.Gotham, C.TxtD)
    AgeLbl.Size = UDim2.new(1,-12,0,12); AgeLbl.Position = UDim2.new(0,6,0,128)
    AgeLbl.TextXAlignment = Enum.TextXAlignment.Center; AgeLbl.ZIndex = 13

    local MainPanel = fr(BodyArea, Color3.new(), 1)
    MainPanel.Size     = UDim2.new(1, -(PCARD_W+8), 1, 0)
    MainPanel.Position = UDim2.fromOffset(PCARD_W+8, 0)
    MainPanel.ZIndex   = 11
    MainPanel.ClipsDescendants = true

    local SBar = fr(Window, C.S1)
    SBar.Size = UDim2.new(1,0,0,28); SBar.Position = UDim2.new(0,0,1,-28); SBar.ZIndex = 11
    cr(SBar, 14)
    local SBarFix = fr(SBar, C.S1)
    SBarFix.Size = UDim2.new(1,0,0.5,0); SBarFix.ZIndex = 11
    local SDot = fr(SBar, C.G)
    SDot.Size = UDim2.fromOffset(7,7); SDot.Position = UDim2.new(0,12,0.5,-3.5); SDot.ZIndex = 12; cr(SDot,4)
    local STxt = lb(SBar, "Connected — Orbs v3.0", 10, Enum.Font.Gotham, C.TxtD)
    STxt.Size = UDim2.new(1,-32,1,0); STxt.Position = UDim2.fromOffset(24,0); STxt.ZIndex = 12

    local FloatBtn = fr(Screen, TH.A)
    FloatBtn.Size = UDim2.fromOffset(46,46); FloatBtn.Position = UDim2.fromOffset(16,16)
    FloatBtn.Visible = false; FloatBtn.ZIndex = 100; cr(FloatBtn, 23)
    local floatStroke = sk(FloatBtn, TH.AL, 2, 0.4)
    local FL = lb(FloatBtn, "◈", 22, Enum.Font.GothamBold, C.W)
    FL.Size = UDim2.fromScale(1,1); FL.TextXAlignment = Enum.TextXAlignment.Center
    FL.TextYAlignment = Enum.TextYAlignment.Center; FL.ZIndex = 101
    local FC = bt(FloatBtn); FC.Size = UDim2.fromScale(1,1); FC.ZIndex = 102

    drag(Window, TopBar)
    drag(FloatBtn, FloatBtn)

    local function hideWin()
        tw(Window, 0.22, {Size = UDim2.fromOffset(0,0)}, Enum.EasingStyle.Quint)
        task.wait(0.22); Window.Visible = false; FloatBtn.Visible = true
    end
    local function showWin()
        Window.Visible = true; FloatBtn.Visible = false
        Window.Size = UDim2.fromOffset(0,0)
        tw(Window, 0.38, {Size = UDim2.fromOffset(WIN_W,WIN_H)}, Enum.EasingStyle.Back)
    end

    CloseB.MouseButton1Click:Connect(function()
        tw(Window, 0.2, {Size = UDim2.fromOffset(0,0)}, Enum.EasingStyle.Quint)
        task.wait(0.2); Screen:Destroy()
    end)
    bt(TopBar).Size = UDim2.new(0,30,1,0)
    local MinB = Instance.new("TextButton"); MinB.BackgroundTransparency=1; MinB.Text=""; MinB.BorderSizePixel=0
    MinB.Size = UDim2.fromOffset(26,26); MinB.Position = UDim2.fromOffset(20,9); MinB.ZIndex = 14; MinB.Parent = TopBar
    MinB.MouseButton1Click:Connect(function() task.spawn(hideWin) end)
    FC.MouseButton1Click:Connect(function() task.spawn(showWin) end)
    UserInputService.InputBegan:Connect(function(i, gp)
        if not gp and i.KeyCode == self.MinKey then
            if Window.Visible then task.spawn(hideWin) else task.spawn(showWin) end
        end
    end)

    local timerConn = RunService.Heartbeat:Connect(function()
        UptimeLbl.Text = fmtTime(tick()-self._t0)
    end)

    self._gui         = Screen
    self._window      = Window
    self._mainPanel   = MainPanel
    self._tabsFrame   = TabsFrame
    self._statusTxt   = STxt
    self._statusDot   = SDot
    self._notifHolder = NotifHolder
    self._timerConn   = timerConn
    self._themeRefs   = {
        winStroke    = winStroke,
        topBar       = TopBar,
        topBarFix    = TopBarFix,
        topLine      = TopLine,
        titleLbl     = TitleLbl,
        descLbl      = DescLbl,
        tabsDivider  = TabsDivider,
        tabsDivider2 = TabsDivider2,
        pcardStroke  = pcardStroke,
        avatarStroke = avatarStroke,
        avatarBg     = AvatarBg,
        statusDot2   = StatusDot2,
        floatBtn     = FloatBtn,
        floatStroke  = floatStroke,
        uptimeLbl    = UptimeLbl,
    }
end

function OrbsUI:SetStatus(text, kind)
    self._statusTxt.Text = text or "Ready"
    local dot = self._statusDot
    if kind == "error" then tw(dot, 0.2, {BackgroundColor3 = C.R})
    elseif kind == "warn" then tw(dot, 0.2, {BackgroundColor3 = C.Warn})
    else tw(dot, 0.2, {BackgroundColor3 = C.G}) end
end

function OrbsUI:Notify(cfg)
    cfg = cfg or {}
    local title    = cfg.Title    or "Notification"
    local content  = cfg.Content  or ""
    local duration = cfg.Duration or 4
    local color    = cfg.Color    or self.TH.A

    self._notifN = self._notifN + 1

    local NF = fr(self._notifHolder, C.S2)
    NF.Size = UDim2.new(1,0,0,64); NF.Position = UDim2.new(1,10,0,0)
    NF.LayoutOrder = self._notifN; NF.ZIndex = 901
    cr(NF, 10); sk(NF, C.Bdr, 1, 0.35)

    local NBar = fr(NF, color)
    NBar.Size = UDim2.fromOffset(3,38); NBar.Position = UDim2.fromOffset(10,13); NBar.ZIndex = 902; cr(NBar,2)

    local NT = lb(NF, title, 13, Enum.Font.GothamBold, C.Txt)
    NT.Size = UDim2.new(1,-58,0,18); NT.Position = UDim2.fromOffset(20,10); NT.ZIndex = 902

    local NC = lb(NF, content, 11, Enum.Font.Gotham, C.TxtS)
    NC.Size = UDim2.new(1,-58,0,26); NC.Position = UDim2.fromOffset(20,30)
    NC.TextWrapped = true; NC.TextTruncate = Enum.TextTruncate.AtEnd; NC.ZIndex = 902

    local NCX = fr(NF, C.S3)
    NCX.Size = UDim2.fromOffset(20,20); NCX.Position = UDim2.new(1,-28,0,8); NCX.ZIndex = 902; cr(NCX,6)
    local NCXL = lb(NCX, "✕", 10, Enum.Font.GothamBold, C.TxtS)
    NCXL.Size = UDim2.fromScale(1,1); NCXL.TextXAlignment = Enum.TextXAlignment.Center
    NCXL.TextYAlignment = Enum.TextYAlignment.Center; NCXL.ZIndex = 903
    local NCXB = bt(NCX); NCXB.Size = UDim2.fromScale(1,1); NCXB.ZIndex = 904
    NCXB.MouseEnter:Connect(function() tw(NCX,0.1,{BackgroundColor3=C.R}); tw(NCXL,0.1,{TextColor3=C.W}) end)
    NCXB.MouseLeave:Connect(function() tw(NCX,0.1,{BackgroundColor3=C.S3}); tw(NCXL,0.1,{TextColor3=C.TxtS}) end)

    tw(NF, 0.3, {Position = UDim2.new(0,0,0,0)}, Enum.EasingStyle.Back)

    local gone = false
    local function dismiss()
        if gone then return end; gone = true
        tw(NF, 0.2, {Position = UDim2.new(1,10,0,0), BackgroundTransparency = 1})
        task.wait(0.22); if NF.Parent then NF:Destroy() end
    end
    NCXB.MouseButton1Click:Connect(function() task.spawn(dismiss) end)
    NF.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then task.spawn(dismiss) end
    end)
    if duration > 0 then task.spawn(function() task.wait(duration+0.3); dismiss() end) end
end

function OrbsUI:SetTheme(name)
    local theme = THEMES[name]; if not theme then return end
    self:_applyTheme(theme)
    self.ThemeName = name
end

function OrbsUI:_selectTab(tabData)
    if self._switching then return end
    if self.ActiveTab == tabData then return end
    self._switching = true

    local TH = self.TH
    local prev = self.ActiveTab

    for _, t in ipairs(self.Tabs) do
        if t._txtLbl  then tw(t._txtLbl,  0.18, {TextColor3  = C.TxtS}) end
        if t._iconImg then tw(t._iconImg, 0.18, {ImageColor3 = C.TxtD}) end
        if t._dotLine then tw(t._dotLine, 0.18, {BackgroundTransparency = 1}) end
        tw(t._btn, 0.18, {BackgroundTransparency = 1, BackgroundColor3 = C.S2})
    end

    tw(tabData._btn, 0.18, {
        BackgroundColor3       = lerp3(TH.A, C.BG, 0.82),
        BackgroundTransparency = 0,
    })
    if tabData._txtLbl  then tw(tabData._txtLbl,  0.18, {TextColor3  = TH.AL}) end
    if tabData._iconImg then tw(tabData._iconImg, 0.18, {ImageColor3 = TH.AL}) end
    if tabData._dotLine then tw(tabData._dotLine, 0.18, {BackgroundTransparency = 0}) end

    if prev and prev._scroll then
        tw(prev._scroll, 0.18, {Position = UDim2.new(-0.06,0,0,0)})
        task.delay(0.18, function()
            prev._scroll.Visible = false
            prev._scroll.Position = UDim2.fromScale(0,0)
        end)
    end

    tabData._scroll.Position = UDim2.new(0.06,0,0,0)
    tabData._scroll.Visible  = true
    tw(tabData._scroll, 0.22, {Position = UDim2.fromScale(0,0)}, Enum.EasingStyle.Quint)

    self.ActiveTab  = tabData
    task.delay(0.22, function() self._switching = false end)
end

function OrbsUI:AddTab(cfg)
    cfg = cfg or {}
    local tabName  = cfg.Name or "Tab"
    local iconName = cfg.Icon
    local TH       = self.TH

    local TabBtn = Instance.new("TextButton")
    TabBtn.AutomaticSize = Enum.AutomaticSize.X
    TabBtn.Size  = UDim2.new(0,0,1,0)
    TabBtn.BackgroundColor3 = C.S2
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text  = ""; TabBtn.BorderSizePixel = 0; TabBtn.ZIndex = 12
    TabBtn.Parent = self._tabsFrame
    cr(TabBtn, 7); pd(TabBtn, 5,5, iconName and 9 or 11, 11)
    hl(TabBtn, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

    local iconImg = nil
    if iconName then
        iconImg = ic(TabBtn, iconName, 13, C.TxtD); iconImg.ZIndex = 13
    end

    local txtLbl = lb(TabBtn, tabName, 12, Enum.Font.GothamSemibold, C.TxtS)
    txtLbl.AutomaticSize = Enum.AutomaticSize.X
    txtLbl.Size = UDim2.new(0,0,1,0); txtLbl.ZIndex = 13

    local dotLine = fr(TabBtn, TH.A, 1)
    dotLine.Size     = UDim2.new(1,-4,0,2)
    dotLine.Position = UDim2.new(0,2,1,-2)
    dotLine.ZIndex   = 14; cr(dotLine, 1)

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.BackgroundTransparency = 1; ScrollFrame.BorderSizePixel = 0
    ScrollFrame.Size = UDim2.fromScale(1,1)
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = C.Bdr
    ScrollFrame.CanvasSize = UDim2.new(0,0,0,0)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.Visible = false; ScrollFrame.ZIndex = 12
    ScrollFrame.Parent  = self._mainPanel
    vl(ScrollFrame, 7); pd(ScrollFrame, 4, 10, 2, 2)

    local tabData = {
        Name    = tabName,
        _btn    = TabBtn,
        _txtLbl = txtLbl,
        _iconImg = iconImg,
        _dotLine = dotLine,
        _scroll = ScrollFrame,
        _accentBar = nil,
    }
    table.insert(self.Tabs, tabData)

    TabBtn.MouseButton1Click:Connect(function() self:_selectTab(tabData) end)
    TabBtn.MouseEnter:Connect(function()
        if self.ActiveTab ~= tabData then
            tw(TabBtn, 0.12, {BackgroundTransparency = 0.82, BackgroundColor3 = C.S2})
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if self.ActiveTab ~= tabData then
            tw(TabBtn, 0.12, {BackgroundTransparency = 1})
        end
    end)

    if #self.Tabs == 1 then
        TabBtn.BackgroundColor3 = lerp3(TH.A, C.BG, 0.82)
        TabBtn.BackgroundTransparency = 0
        txtLbl.TextColor3  = TH.AL
        if iconImg then iconImg.ImageColor3 = TH.AL end
        dotLine.BackgroundTransparency = 0
        ScrollFrame.Visible = true
        self.ActiveTab = tabData
    end

    local tabAPI = {}
    local self_ref = self

    local function mkElem(h)
        local f = fr(ScrollFrame, C.S2)
        f.Size = UDim2.new(1,-2,0,h); cr(f,8); sk(f, C.Bdr, 1, 0.62); return f
    end

    function tabAPI:AddSection(cfg2)
        cfg2 = cfg2 or {}
        local secName = cfg2.Name or "Section"
        local TH2 = self_ref.TH

        local SF = fr(ScrollFrame, C.S1)
        SF.Size = UDim2.new(1,-2,0,0); SF.AutomaticSize = Enum.AutomaticSize.Y
        cr(SF, 10); sk(SF, C.Bdr, 1, 0.5)

        local SH = fr(SF, Color3.new(), 1)
        SH.Size = UDim2.new(1,0,0,36); pd(SH,0,0,12,12)
        hl(SH, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

        local SBar = fr(SH, TH2.A)
        SBar.Size = UDim2.fromOffset(3,14); cr(SBar,2)
        tabData._accentBar = SBar

        local STL = lb(SH, secName, 12, Enum.Font.GothamBold, C.Txt)
        STL.Size = UDim2.new(1,-30,1,0)

        local SD = fr(SF, C.Bdr, 0.6)
        SD.Size = UDim2.new(1,-24,0,1); SD.Position = UDim2.fromOffset(12,36)

        local SC = fr(SF, Color3.new(), 1)
        SC.Size = UDim2.new(1,-24,0,0); SC.Position = UDim2.fromOffset(12,44)
        SC.AutomaticSize = Enum.AutomaticSize.Y; vl(SC, 6)

        local SBot = Instance.new("UIPadding")
        SBot.PaddingBottom = UDim.new(0,12); SBot.Parent = SF

        local secAPI = {}

        local function sMkElem(h)
            local f = fr(SC, C.S2); f.Size = UDim2.new(1,0,0,h); cr(f,7); sk(f, C.Bdr, 1, 0.65); return f
        end

        function secAPI:AddToggle(o)
            return mkToggle(SC, o, self_ref.TH, sMkElem)
        end
        function secAPI:AddSlider(o)
            return mkSlider(SC, o, self_ref.TH, sMkElem)
        end
        function secAPI:AddButton(o)
            return mkButton(SC, o, self_ref.TH, self_ref._gui, sMkElem)
        end
        function secAPI:AddInput(o)
            return mkInput(SC, o, self_ref.TH, sMkElem)
        end
        function secAPI:AddDropdown(o)
            return mkDropdown(SC, o, self_ref.TH)
        end
        function secAPI:AddParagraph(o)
            o = o or {}
            local PF = fr(SC, C.S2); PF.Size = UDim2.new(1,0,0,0); PF.AutomaticSize = Enum.AutomaticSize.Y
            cr(PF,7); sk(PF,C.Bdr,1,0.65); pd(PF,10,10,12,12)
            local PTL = lb(PF, o.Title or "", 13, Enum.Font.GothamBold, C.Txt)
            PTL.Size = UDim2.new(1,0,0, o.Title ~= "" and 18 or 0)
            local PCL = lb(PF, o.Content or "", 11, Enum.Font.Gotham, C.TxtS)
            PCL.Size = UDim2.new(1,0,0,0); PCL.AutomaticSize = Enum.AutomaticSize.Y
            PCL.Position = UDim2.fromOffset(0, o.Title ~= "" and 22 or 0)
            PCL.TextWrapped = true; PCL.TextYAlignment = Enum.TextYAlignment.Top
            local p = {}; function p:SetTitle(v) PTL.Text=v end; function p:SetContent(v) PCL.Text=v end; return p
        end
        return secAPI
    end

    function tabAPI:AddToggle(o)   return mkToggle(ScrollFrame, o, self_ref.TH, mkElem) end
    function tabAPI:AddSlider(o)   return mkSlider(ScrollFrame, o, self_ref.TH, mkElem) end
    function tabAPI:AddButton(o)   return mkButton(ScrollFrame, o, self_ref.TH, self_ref._gui, mkElem) end
    function tabAPI:AddInput(o)    return mkInput(ScrollFrame, o, self_ref.TH, mkElem) end
    function tabAPI:AddDropdown(o) return mkDropdown(ScrollFrame, o, self_ref.TH) end

    function tabAPI:AddLabel(o)
        o = o or {}
        local l = lb(ScrollFrame, (o.Text or ""):upper(), 10, Enum.Font.GothamBold, C.TxtD)
        l.Size = UDim2.new(1,-2,0,18); l.LetterSpacing = 1
        local a = {}; function a:Set(t) l.Text = t end; return a
    end

    function tabAPI:AddColorPicker(o)
        o = o or {}
        local cb = o.Callback or function() end
        local colors = {
            {n="Purple",c=Color3.fromRGB(130,85,235)},
            {n="Red",   c=Color3.fromRGB(225,65,65)},
            {n="Cyan",  c=Color3.fromRGB(35,185,225)},
            {n="Green", c=Color3.fromRGB(45,185,105)},
            {n="Gold",  c=Color3.fromRGB(215,165,32)},
            {n="Orange",c=Color3.fromRGB(225,115,32)},
            {n="Pink",  c=Color3.fromRGB(205,55,165)},
            {n="White", c=Color3.fromRGB(205,205,215)},
        }
        local Row = mkElem(58)
        Row.Size = UDim2.new(1,-2,0,58)
        local HL = lb(Row, (o.Name or "Theme Color"):upper(), 10, Enum.Font.GothamBold, C.TxtD)
        HL.Size = UDim2.new(1,-20,0,14); HL.Position = UDim2.fromOffset(10,6); HL.LetterSpacing = 1
        local SR = fr(Row, Color3.new(), 1)
        SR.Size = UDim2.new(1,-20,0,22); SR.Position = UDim2.fromOffset(10,28)
        hl(SR, 7, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        local swatches = {}
        for i,c in ipairs(colors) do
            local sw = Instance.new("TextButton")
            sw.Size = UDim2.fromOffset(20,20); sw.BackgroundColor3 = c.c
            sw.Text = ""; sw.BorderSizePixel = 0; sw.ZIndex = 15; sw.Parent = SR; cr(sw,5)
            local ss = sk(sw, C.W, 2, i==1 and 0.0 or 1.0)
            table.insert(swatches, {b=sw,s=ss,n=c.n,c=c.c})
            sw.MouseButton1Click:Connect(function()
                for _,x in ipairs(swatches) do x.s.Transparency=1 end
                ss.Transparency=0; cb(c.n, c.c)
            end)
        end
    end

    function tabAPI:AddSeparator()
        local s = fr(ScrollFrame, C.Bdr, 0.65)
        s.Size = UDim2.new(1,-2,0,1)
    end

    return tabAPI
end

function mkToggle(parent, o, TH, mkF)
    o = o or {}
    local tname = o.Name or "Toggle"; local tdesc = o.Description or ""
    local tdef  = o.Default or false;  local ticon = o.Icon
    local tcb   = o.Callback or function() end
    local state = tdef; local baseH = tdesc ~= "" and 56 or 38

    local TF = mkF(baseH)
    if ticon then
        local i = ic(TF, ticon, 14, C.TxtS); i.Position = UDim2.fromOffset(10, baseH/2-7)
    end
    local TTL = lb(TF, tname, 12, Enum.Font.GothamSemibold, C.Txt)
    TTL.Size = UDim2.new(1,-(ticon and 72 or 56),0,16)
    TTL.Position = UDim2.fromOffset(ticon and 30 or 12, tdesc ~= "" and 9 or 11)
    if tdesc ~= "" then
        local TDL = lb(TF, tdesc, 10, Enum.Font.Gotham, C.TxtS)
        TDL.Size = UDim2.new(1,-(ticon and 72 or 56),0,13)
        TDL.Position = UDim2.fromOffset(ticon and 30 or 12, 27)
        TDL.TextTruncate = Enum.TextTruncate.AtEnd
    end
    local Track = fr(TF, state and TH.A or C.S4)
    Track.Size = UDim2.fromOffset(36,20); Track.Position = UDim2.new(1,-44,0.5,-10); cr(Track,10)
    local tsk = sk(Track, state and TH.AL or C.Bdr, 1, 0.5)
    local Knob = fr(Track, C.W)
    Knob.Size = UDim2.fromOffset(14,14); Knob.Position = UDim2.fromOffset(state and 19 or 3, 3); cr(Knob,7)
    local TClick = bt(TF); TClick.Size = UDim2.fromScale(1,1)

    local function setOn(v)
        state = v
        tw(Track, 0.2, {BackgroundColor3 = v and TH.A or C.S4})
        tw(tsk,   0.2, {Color = v and TH.AL or C.Bdr})
        tw(Knob,  0.2, {Position = UDim2.fromOffset(v and 19 or 3, 3)}, Enum.EasingStyle.Back)
        task.spawn(tcb, v)
    end
    TClick.MouseEnter:Connect(function() tw(TF,0.1,{BackgroundColor3=C.S3}) end)
    TClick.MouseLeave:Connect(function() tw(TF,0.1,{BackgroundColor3=C.S2}) end)
    TClick.MouseButton1Click:Connect(function() setOn(not state) end)
    if state then task.spawn(tcb, state) end

    local a = {}; function a:Set(v) setOn(v) end; function a:Get() return state end; return a
end

function mkSlider(parent, o, TH, mkF)
    o = o or {}
    local sname  = o.Name or "Slider"; local sdesc = o.Description or ""
    local smin   = o.Min or 0;         local smax   = o.Max or 100
    local sdef   = o.Default or smin;  local ssuf   = o.Suffix or ""
    local sround = o.Rounding or 1;    local sicon  = o.Icon
    local scb    = o.Callback or function() end
    local val    = math.clamp(sdef, smin, smax); local dragging = false
    local baseH  = sdesc ~= "" and 68 or 52

    local SF = mkF(baseH)
    if sicon then
        local i = ic(SF, sicon, 14, C.TxtS); i.Position = UDim2.fromOffset(10,10)
    end
    local STL = lb(SF, sname, 12, Enum.Font.GothamSemibold, C.Txt)
    STL.Size = UDim2.new(1,-72,0,16); STL.Position = UDim2.fromOffset(sicon and 30 or 12, 9)
    local SVL = lb(SF, tostring(val)..ssuf, 12, Enum.Font.GothamBold, TH.AL)
    SVL.Size = UDim2.new(0,54,0,16); SVL.Position = UDim2.new(1,-62,0,9)
    SVL.TextXAlignment = Enum.TextXAlignment.Right
    if sdesc ~= "" then
        local SDL = lb(SF, sdesc, 10, Enum.Font.Gotham, C.TxtS)
        SDL.Size = UDim2.new(1,-24,0,13); SDL.Position = UDim2.fromOffset(12,27)
        SDL.TextTruncate = Enum.TextTruncate.AtEnd
    end
    local tY = sdesc ~= "" and 46 or 32
    local STrack = fr(SF, C.S4); STrack.Size = UDim2.new(1,-24,0,5); STrack.Position = UDim2.fromOffset(12,tY); cr(STrack,3)
    local SFill  = fr(STrack, TH.A); SFill.Size = UDim2.new((val-smin)/(smax-smin),0,1,0); cr(SFill,3)
    local SKnob  = fr(STrack, C.W)
    SKnob.Size = UDim2.fromOffset(14,14); SKnob.Position = UDim2.new((val-smin)/(smax-smin),-7,0.5,-7); cr(SKnob,7)
    sk(SKnob, TH.AL, 1.5, 0.3)

    local function setVal(v)
        v = math.clamp(v, smin, smax)
        if sround > 0 then v = math.round(v/sround)*sround end
        val = v; local p = (v-smin)/(smax-smin)
        tw(SFill, 0.06, {Size=UDim2.new(p,0,1,0)})
        tw(SKnob, 0.06, {Position=UDim2.new(p,-7,0.5,-7)})
        SVL.Text = tostring(v)..ssuf; task.spawn(scb,v)
    end
    local function getPct(x) return math.clamp((x-STrack.AbsolutePosition.X)/STrack.AbsoluteSize.X,0,1) end
    STrack.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; tw(SKnob,0.1,{Size=UDim2.fromOffset(18,18)},Enum.EasingStyle.Back)
            setVal(smin+(smax-smin)*getPct(i.Position.X))
        end
    end)
    SKnob.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; tw(SKnob,0.1,{Size=UDim2.fromOffset(18,18)},Enum.EasingStyle.Back)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            setVal(smin+(smax-smin)*getPct(i.Position.X))
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
            dragging=false; tw(SKnob,0.1,{Size=UDim2.fromOffset(14,14)})
        end
    end)
    setVal(val)
    local a={}; function a:Set(v) setVal(v) end; function a:Get() return val end; return a
end

function mkButton(parent, o, TH, gui, mkF)
    o = o or {}
    local bname   = o.Name or "Button"; local bdesc = o.Description or ""
    local bicon   = o.Icon;             local confirm = o.Confirm or false
    local bcb     = o.Callback or function() end
    local baseH   = bdesc ~= "" and 56 or 38

    local BF = mkF(baseH)
    if bicon then
        local i = ic(BF, bicon, 14, C.TxtS); i.Position = UDim2.fromOffset(10, baseH/2-7)
    end
    local BTL = lb(BF, bname, 12, Enum.Font.GothamSemibold, C.Txt)
    BTL.Size = UDim2.new(1,-(bicon and 74 or 52),0,16)
    BTL.Position = UDim2.fromOffset(bicon and 30 or 12, bdesc ~= "" and 9 or 11)
    if bdesc ~= "" then
        local BDL = lb(BF, bdesc, 10, Enum.Font.Gotham, C.TxtS)
        BDL.Size = UDim2.new(1,-(bicon and 74 or 52),0,13)
        BDL.Position = UDim2.fromOffset(bicon and 30 or 12, 27)
        BDL.TextTruncate = Enum.TextTruncate.AtEnd
    end
    local BArr = fr(BF, TH.A, 0.82)
    BArr.Size = UDim2.fromOffset(24,24); BArr.Position = UDim2.new(1,-32,0.5,-12); cr(BArr,7)
    local BAL = lb(BArr, "›", 18, Enum.Font.GothamBold, TH.AL)
    BAL.Size = UDim2.fromScale(1,1); BAL.TextXAlignment = Enum.TextXAlignment.Center; BAL.TextYAlignment = Enum.TextYAlignment.Center
    local BClick = bt(BF); BClick.Size = UDim2.fromScale(1,1)
    BClick.MouseEnter:Connect(function()
        tw(BF,0.12,{BackgroundColor3=C.S3}); tw(BTL,0.12,{TextColor3=TH.AL}); tw(BArr,0.12,{BackgroundTransparency=0.6})
    end)
    BClick.MouseLeave:Connect(function()
        tw(BF,0.12,{BackgroundColor3=C.S2}); tw(BTL,0.12,{TextColor3=C.Txt}); tw(BArr,0.12,{BackgroundTransparency=0.82})
    end)

    local function doConfirm(cb)
        local OV = fr(gui, Color3.fromRGB(0,0,0), 0.58)
        OV.Size=UDim2.fromScale(1,1); OV.ZIndex=500
        local DF = fr(gui, C.S2)
        DF.Size=UDim2.fromOffset(0,0); DF.Position=UDim2.fromScale(0.5,0.5); DF.AnchorPoint=Vector2.new(0.5,0.5)
        DF.ZIndex=501; cr(DF,12); sk(DF,C.Bdr,1,0.3)
        tw(DF,0.28,{Size=UDim2.fromOffset(310,128)},Enum.EasingStyle.Back)
        local DT=lb(DF,"Confirm",15,Enum.Font.GothamBold,C.Txt); DT.Size=UDim2.new(1,-28,0,22); DT.Position=UDim2.fromOffset(14,12); DT.ZIndex=502
        local DX=lb(DF,"Are you sure you want to run this?",11,Enum.Font.Gotham,C.TxtS); DX.Size=UDim2.new(1,-28,0,28); DX.Position=UDim2.fromOffset(14,38); DX.TextWrapped=true; DX.ZIndex=502
        local function dBt(txt,col,xoff)
            local db=fr(DF,col); db.Size=UDim2.fromOffset(92,28); db.Position=UDim2.new(1,xoff,1,-38); db.ZIndex=502; cr(db,7)
            local dl=lb(db,txt,12,Enum.Font.GothamSemibold,C.W); dl.Size=UDim2.fromScale(1,1); dl.TextXAlignment=Enum.TextXAlignment.Center; dl.TextYAlignment=Enum.TextYAlignment.Center; dl.ZIndex=503
            local dbb=bt(db); dbb.Size=UDim2.fromScale(1,1); dbb.ZIndex=504; return dbb
        end
        local closed=false
        local function closeD()
            if closed then return end; closed=true
            tw(DF,0.16,{Size=UDim2.fromOffset(0,0)}); task.wait(0.16); OV:Destroy(); DF:Destroy()
        end
        dBt("Cancel",C.S4,-202).MouseButton1Click:Connect(closeD)
        dBt("Confirm",TH.A,-102).MouseButton1Click:Connect(function() closeD(); task.spawn(cb) end)
        OV.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then closeD() end end)
    end

    BClick.MouseButton1Click:Connect(function()
        tw(BF,0.06,{Size=UDim2.new(1,-2,0,baseH-4)}); task.wait(0.06)
        tw(BF,0.12,{Size=UDim2.new(1,-2,0,baseH)},Enum.EasingStyle.Back)
        if confirm then doConfirm(bcb) else task.spawn(bcb) end
    end)
    local a={}; function a:SetText(t) BTL.Text=t end; return a
end

function mkInput(parent, o, TH, mkF)
    o = o or {}
    local iname = o.Name or "Input"; local idesc = o.Description or ""
    local idef  = o.Default or "";   local iph   = o.Placeholder or "Enter value..."
    local inum  = o.Numeric or false; local ifin  = o.Finished or false
    local iicon = o.Icon;             local icb   = o.Callback or function() end
    local val   = idef; local baseH = idesc ~= "" and 68 or 52

    local IF = mkF(baseH)
    local iStr = IF:FindFirstChildOfClass("UIStroke")
    if iicon then local i=ic(IF,iicon,14,C.TxtS); i.Position=UDim2.fromOffset(10,10) end
    local ITL=lb(IF,iname,12,Enum.Font.GothamSemibold,C.Txt)
    ITL.Size=UDim2.new(1,-24,0,16); ITL.Position=UDim2.fromOffset(iicon and 30 or 12, idesc~="" and 8 or 6)
    if idesc~="" then
        local IDL=lb(IF,idesc,10,Enum.Font.Gotham,C.TxtS); IDL.Size=UDim2.new(1,-24,0,13)
        IDL.Position=UDim2.fromOffset(12,24); IDL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local IBox=Instance.new("TextBox")
    IBox.BackgroundColor3=C.S3; IBox.BackgroundTransparency=0; IBox.BorderSizePixel=0
    IBox.Size=UDim2.new(1,-24,0,24); IBox.Position=UDim2.fromOffset(12,idesc~="" and 44 or 24)
    IBox.Text=idef; IBox.PlaceholderText=iph; IBox.PlaceholderColor3=C.TxtD
    IBox.TextColor3=C.Txt; IBox.TextSize=12; IBox.Font=Enum.Font.Gotham
    IBox.TextXAlignment=Enum.TextXAlignment.Left; IBox.ZIndex=15; IBox.Parent=IF
    cr(IBox,6); pd(IBox,0,0,9,9)
    local ibS=sk(IBox,C.Bdr,1,0.5)
    IBox.Focused:Connect(function() tw(ibS,0.12,{Color=TH.A,Transparency=0.1}); if iStr then tw(iStr,0.12,{Color=TH.A,Transparency=0.35}) end end)
    IBox.FocusLost:Connect(function(e) tw(ibS,0.12,{Color=C.Bdr,Transparency=0.5}); if iStr then tw(iStr,0.12,{Color=C.Bdr,Transparency=0.62}) end
        if ifin and e then val=IBox.Text; task.spawn(icb,val) end
    end)
    if not ifin then
        IBox:GetPropertyChangedSignal("Text"):Connect(function()
            if inum then local cl=IBox.Text:gsub("[^%d%.%-]",""); if cl~=IBox.Text then IBox.Text=cl end end
            val=IBox.Text; task.spawn(icb,val)
        end)
    end
    local a={}; function a:Set(v) IBox.Text=tostring(v); val=tostring(v) end; function a:Get() return val end; return a
end

function mkDropdown(parent, o, TH)
    o = o or {}
    local dname  = o.Name or "Dropdown"; local ddesc = o.Description or ""
    local ditems = o.Items or {};         local dmulti = o.Multi or false
    local ddef   = o.Default or (dmulti and {} or (ditems[1] or ""))
    local dicon  = o.Icon;               local dcb = o.Callback or function() end
    local open   = false; local baseH = ddesc ~= "" and 56 or 38
    local sel    = dmulti and {} or ddef
    if dmulti and type(ddef)=="table" then for _,v in pairs(ddef) do sel[v]=true end end

    local DF=fr(parent,C.S2); DF.Size=UDim2.new(1,-2,0,baseH); DF.ClipsDescendants=true; cr(DF,8)
    local dS=sk(DF,C.Bdr,1,0.62)
    if dicon then local i=ic(DF,dicon,14,C.TxtS); i.Position=UDim2.fromOffset(10,baseH/2-7) end
    local DTL=lb(DF,dname,12,Enum.Font.GothamSemibold,C.Txt)
    DTL.Size=UDim2.new(1,-(dicon and 62 or 44),0,16); DTL.Position=UDim2.fromOffset(dicon and 30 or 12, ddesc~="" and 9 or 11)
    local DArr=lb(DF,"⌄",13,Enum.Font.GothamBold,C.TxtS)
    DArr.Size=UDim2.fromOffset(18,16); DArr.Position=UDim2.new(1,-24,0,ddesc~="" and 9 or 11); DArr.TextXAlignment=Enum.TextXAlignment.Center
    if ddesc~="" then
        local DDL=lb(DF,ddesc,10,Enum.Font.Gotham,C.TxtS); DDL.Size=UDim2.new(1,-44,0,13)
        DDL.Position=UDim2.fromOffset(12,25); DDL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local DVL=lb(DF,"",11,Enum.Font.GothamMedium,TH.AL)
    DVL.Size=UDim2.new(1,-44,0,13); DVL.Position=UDim2.fromOffset(12,ddesc~="" and 40 or 23); DVL.TextTruncate=Enum.TextTruncate.AtEnd

    local DList=fr(DF,C.S3); DList.Size=UDim2.new(1,-8,0,0); DList.Position=UDim2.fromOffset(4,baseH+4); cr(DList,7); sk(DList,C.Bdr,1,0.5)
    local DSc=Instance.new("ScrollingFrame")
    DSc.BackgroundTransparency=1; DSc.BorderSizePixel=0; DSc.Size=UDim2.fromScale(1,1)
    DSc.ScrollBarThickness=2; DSc.ScrollBarImageColor3=C.Bdr
    DSc.CanvasSize=UDim2.new(0,0,0,0); DSc.AutomaticCanvasSize=Enum.AutomaticSize.Y; DSc.ZIndex=16; DSc.Parent=DList
    pd(DSc,3,3,4,4); vl(DSc,2)
    local DC=bt(DF); DC.Size=UDim2.new(1,0,0,baseH)

    local function updLbl()
        if dmulti then local s={} for v,on in pairs(sel) do if on then table.insert(s,v) end end
            DVL.Text=#s==0 and "None" or (#s==1 and s[1] or s[1].." +"..#s-1)
        else DVL.Text=sel~="" and sel or "None" end
    end
    local function togOpen()
        open=not open; local lh=open and math.min(#ditems*28+6,132) or 0
        tw(DF,0.2,{Size=UDim2.new(1,-2,0,baseH+(open and lh+8 or 0))})
        tw(DList,0.2,{Size=UDim2.new(1,-8,0,lh)}); tw(DArr,0.16,{Rotation=open and 180 or 0})
        tw(dS,0.14,{Color=open and TH.A or C.Bdr, Transparency=open and 0.2 or 0.62})
    end
    DC.MouseButton1Click:Connect(togOpen)
    local function buildItems()
        for _,c in ipairs(DSc:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        for i,v in ipairs(ditems) do
            local OF=fr(DSc,C.S2,0.6); OF.Size=UDim2.new(1,0,0,26); OF.LayoutOrder=i; cr(OF,6)
            local isA=dmulti and sel[v] or (not dmulti and sel==v)
            local OL=lb(OF,v,11,Enum.Font.GothamMedium,isA and TH.AL or C.TxtS)
            OL.Size=UDim2.new(1,-10,1,0); OL.Position=UDim2.fromOffset(8,0); OL.ZIndex=17
            local OB=bt(OF); OB.Size=UDim2.fromScale(1,1); OB.ZIndex=18
            OB.MouseEnter:Connect(function() tw(OF,0.08,{BackgroundTransparency=0.3}) end)
            OB.MouseLeave:Connect(function() tw(OF,0.08,{BackgroundTransparency=0.6}) end)
            OB.MouseButton1Click:Connect(function()
                if dmulti then
                    sel[v]=not sel[v]; tw(OL,0.1,{TextColor3=sel[v] and TH.AL or C.TxtS})
                    updLbl(); local s={} for sv,on in pairs(sel) do if on then table.insert(s,sv) end end; task.spawn(dcb,s)
                else
                    sel=v
                    for _,c2 in ipairs(DSc:GetChildren()) do
                        if c2:IsA("Frame") then local l2=c2:FindFirstChildOfClass("TextLabel"); if l2 then l2.TextColor3=C.TxtS end end
                    end
                    tw(OL,0.1,{TextColor3=TH.AL}); updLbl(); togOpen(); task.spawn(dcb,v)
                end
            end)
        end
    end
    buildItems(); updLbl()
    local a={}
    function a:Set(v)
        if dmulti then sel={}; if type(v)=="table" then for _,sv in pairs(v) do sel[sv]=true end end
        else sel=v end; buildItems(); updLbl()
    end
    function a:SetItems(vals) ditems=vals; buildItems(); updLbl() end
    function a:Get()
        if dmulti then local s={} for sv,on in pairs(sel) do if on then table.insert(s,sv) end end; return s end; return sel
    end
    return a
end

function OrbsUI:Toggle()
    self.Visible = not self.Visible
    self._window.Visible   = self.Visible
end

function OrbsUI:Destroy()
    if self._timerConn then self._timerConn:Disconnect() end
    self._gui:Destroy()
end

return OrbsUI
