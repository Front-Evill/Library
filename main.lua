--[[
    OrbsUI v5.0
    Usage: local OrbsUI = loadstring(game:HttpGet("RAW_URL"))()

    Window:new({
        Title       = "Orbs",
        Description = "By FrontEvill",
        Icon        = "rbxassetid://...",   -- optional icon next to title
        Background  = "rbxassetid://...",   -- optional background image
        Theme       = "Purple",
        MinimizeKey = Enum.KeyCode.RightShift,
    })
]]

local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenSvc = game:GetService("TweenService")
local UIS      = game:GetService("UserInputService")
local Players  = game:GetService("Players")
local RunSvc   = game:GetService("RunService")
local LP       = Players.LocalPlayer

-- ── Icons ────────────────────────────────────────────────────────
local ICO = {
    home="rbxassetid://7733960981",      settings="rbxassetid://7734053495",
    user="rbxassetid://7733974796",      sword="rbxassetid://7734014785",
    eye="rbxassetid://7734053476",       zap="rbxassetid://7734014757",
    shield="rbxassetid://7733942387",    star="rbxassetid://7734053548",
    target="rbxassetid://7734014807",    map="rbxassetid://7733960985",
    lock="rbxassetid://7733960971",      unlock="rbxassetid://7733960987",
    bell="rbxassetid://7733942307",      trash="rbxassetid://7734014815",
    edit="rbxassetid://7733942363",      check="rbxassetid://7733942335",
    close="rbxassetid://7733942347",     plus="rbxassetid://7734014799",
    minus="rbxassetid://7733960983",     arrow_right="rbxassetid://7733942295",
    arrow_left="rbxassetid://7733942289",arrow_up="rbxassetid://7733942299",
    arrow_down="rbxassetid://7733942293",refresh="rbxassetid://7734014803",
    download="rbxassetid://7733942357",  upload="rbxassetid://7733942393",
    search="rbxassetid://7734014789",    info="rbxassetid://7733942379",
    warning="rbxassetid://7733942397",   danger="rbxassetid://7733942353",
    heart="rbxassetid://7733942373",     chat="rbxassetid://7733942341",
    camera="rbxassetid://7733942325",    music="rbxassetid://7733942383",
    fly="rbxassetid://7733942369",       speed="rbxassetid://7733942391",
    ghost="rbxassetid://7733942371",     misc="rbxassetid://7733942387",
    visual="rbxassetid://7733942393",    combat="rbxassetid://7734014785",
    movement="rbxassetid://7733942369",  player="rbxassetid://7733974796",
    world="rbxassetid://7733960985",     kill="rbxassetid://7734014757",
    teleport="rbxassetid://7734014815",  signal="rbxassetid://7733942391",
    save="rbxassetid://7733942363",      terminal="rbxassetid://7734053495",
    play="rbxassetid://7734014757",      wrench="rbxassetid://7733942387",
    run="rbxassetid://7734014785",       script="rbxassetid://7734053495",
    money="rbxassetid://7733942383",     note="rbxassetid://7733942383",
    plug="rbxassetid://7733942387",      locate="rbxassetid://7733960985",
    logs="rbxassetid://7734053495",      ruler="rbxassetid://7734014807",
    scroll="rbxassetid://7733942383",    phone="rbxassetid://7733942341",
    aimbot="rbxassetid://7734014807",    esp="rbxassetid://7733942363",
}

-- ── Themes ───────────────────────────────────────────────────────
local TH_MAP = {
    Purple={A=Color3.fromRGB(128,82,232), AL=Color3.fromRGB(182,148,255), AD=Color3.fromRGB(82,52,168)},
    Red   ={A=Color3.fromRGB(222,62,62),  AL=Color3.fromRGB(255,128,128), AD=Color3.fromRGB(162,38,38)},
    Cyan  ={A=Color3.fromRGB(32,182,222), AL=Color3.fromRGB(108,222,255), AD=Color3.fromRGB(20,132,172)},
    Green ={A=Color3.fromRGB(42,182,102), AL=Color3.fromRGB(108,222,158), AD=Color3.fromRGB(26,132,70)},
    Gold  ={A=Color3.fromRGB(212,162,30), AL=Color3.fromRGB(255,212,82),  AD=Color3.fromRGB(162,120,18)},
    Orange={A=Color3.fromRGB(222,112,30), AL=Color3.fromRGB(255,162,82),  AD=Color3.fromRGB(162,80,18)},
    Pink  ={A=Color3.fromRGB(202,52,162), AL=Color3.fromRGB(255,108,212), AD=Color3.fromRGB(152,30,120)},
    White ={A=Color3.fromRGB(202,202,212),AL=Color3.fromRGB(242,242,255), AD=Color3.fromRGB(162,162,175)},
}

-- ── Base palette ─────────────────────────────────────────────────
-- All frames use 0.26 global transparency (74% opacity)
local ALPHA = 0.26   -- window panels transparency
local BG_ALPHA = 0.27 -- background image transparency

local B = {
    BG=Color3.fromRGB(13,13,20),   S1=Color3.fromRGB(19,19,30),
    S2=Color3.fromRGB(25,25,39),   S3=Color3.fromRGB(31,31,48),
    S4=Color3.fromRGB(37,37,56),   BD=Color3.fromRGB(46,46,70),
    TX=Color3.fromRGB(224,216,255),TS=Color3.fromRGB(132,120,182),
    TD=Color3.fromRGB(72,65,112),  W=Color3.fromRGB(255,255,255),
    CG=Color3.fromRGB(40,202,72),  CR=Color3.fromRGB(232,65,65),
    CW=Color3.fromRGB(238,160,28),
    -- Topbar description color: dark grey
    TDesc=Color3.fromRGB(90,88,105),
}

-- ── Utilities ────────────────────────────────────────────────────
local function lc(a,b,t)
    return Color3.new(a.R+(b.R-a.R)*t, a.G+(b.G-a.G)*t, a.B+(b.B-a.B)*t)
end
local function tw(o,t,p,s,d)
    TweenSvc:Create(o,TweenInfo.new(t or .18,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play()
end
local function cr(f,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 8);c.Parent=f;return c end
local function sk(f,col,th,tr)
    local s=Instance.new("UIStroke");s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    s.Color=col or B.BD;s.Thickness=th or 1;s.Transparency=tr or 0;s.Parent=f;return s
end
local function pd(f,t,b,l,r)
    local p=Instance.new("UIPadding")
    p.PaddingTop=UDim.new(0,t or 0);p.PaddingBottom=UDim.new(0,b or 0)
    p.PaddingLeft=UDim.new(0,l or 0);p.PaddingRight=UDim.new(0,r or 0);p.Parent=f
end
local function vl(f,sp)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Vertical
    l.HorizontalAlignment=Enum.HorizontalAlignment.Left
    l.VerticalAlignment=Enum.VerticalAlignment.Top
    l.Padding=UDim.new(0,sp or 0);l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=f;return l
end
local function hl(f,sp,ha,va)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Horizontal
    l.HorizontalAlignment=ha or Enum.HorizontalAlignment.Left
    l.VerticalAlignment=va or Enum.VerticalAlignment.Center
    l.Padding=UDim.new(0,sp or 0);l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=f;return l
end
-- frame with semi-transparency baked in
local function fr(p,bg,extra_t)
    local f=Instance.new("Frame");f.BackgroundColor3=bg or B.BG
    f.BackgroundTransparency=extra_t or ALPHA
    f.BorderSizePixel=0;f.Parent=p;return f
end
-- solid frame (no transparency)
local function frS(p,bg)
    local f=Instance.new("Frame");f.BackgroundColor3=bg or B.BG
    f.BackgroundTransparency=0;f.BorderSizePixel=0;f.Parent=p;return f
end
-- fully transparent frame (container only)
local function frT(p)
    local f=Instance.new("Frame");f.BackgroundTransparency=1
    f.BorderSizePixel=0;f.Parent=p;return f
end
local function lb(p,tx,sz,fn,co,xt)
    local l=Instance.new("TextLabel");l.BackgroundTransparency=1;l.Text=tx or ""
    l.TextSize=sz or 13;l.Font=fn or Enum.Font.GothamMedium
    l.TextColor3=co or B.TX;l.TextXAlignment=xt or Enum.TextXAlignment.Left
    l.BorderSizePixel=0;l.RichText=false;l.Parent=p;return l
end
local function bt(p)
    local b=Instance.new("TextButton");b.BackgroundTransparency=1;b.Text=""
    b.BorderSizePixel=0;b.Parent=p;return b
end
local function img2(p,id,sz,co)
    local i=Instance.new("ImageLabel");i.BackgroundTransparency=1
    i.Size=UDim2.fromOffset(sz or 14,sz or 14)
    i.Image=id or "";i.ImageColor3=co or B.TS;i.ScaleType=Enum.ScaleType.Fit
    i.Parent=p;return i
end
local function ico(p,name,sz,co)
    return img2(p, ICO[(name or ""):lower()] or "", sz, co)
end
local function fmtT(s)
    local h=math.floor(s/3600);local m=math.floor((s%3600)/60);local sc=math.floor(s%60)
    if h>0 then return string.format("%02d:%02d:%02d",h,m,sc) end
    return string.format("%02d:%02d",m,sc)
end
local function drag(win,handle)
    local d,ds,sp=false,nil,nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then
            d=true;ds=i.Position;sp=win.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if d and(i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then
            local dv=i.Position-ds
            win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dv.X,sp.Y.Scale,sp.Y.Offset+dv.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then d=false end
    end)
end

-- ── Constructor ──────────────────────────────────────────────────
function OrbsUI.new(cfg)
    cfg=cfg or {}
    local self=setmetatable({},OrbsUI)
    self.TH        = TH_MAP[cfg.Theme] or TH_MAP.Purple
    self.ThemeName = cfg.Theme or "Purple"
    self.Title     = cfg.Title or "Orbs"
    self.Desc      = cfg.Description or "By FrontEvill"
    self.IconId    = cfg.Icon or ""
    self.BgId      = cfg.Background or ""
    self.MinKey    = cfg.MinimizeKey or Enum.KeyCode.RightShift
    self.Tabs      = {}
    self.ActiveTab = nil
    self._t0       = tick()
    self._nN       = 0
    self._busy     = false
    self:_build()
    return self
end

-- ── _build ───────────────────────────────────────────────────────
function OrbsUI:_build()
    local TH=self.TH

    -- Screen
    local Gui=Instance.new("ScreenGui")
    Gui.Name="OrbsUI";Gui.ResetOnSpawn=false
    Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;Gui.IgnoreGuiInset=true
    if not pcall(function() Gui.Parent=game:GetService("CoreGui") end) then
        Gui.Parent=LP:WaitForChild("PlayerGui")
    end

    -- Notif holder
    local NH=frT(Gui)
    NH.Size=UDim2.new(0,308,1,0);NH.Position=UDim2.new(1,-314,0,0);NH.ZIndex=900
    local nhl=vl(NH,6);nhl.VerticalAlignment=Enum.VerticalAlignment.Bottom
    nhl.HorizontalAlignment=Enum.HorizontalAlignment.Right
    pd(NH,0,14,0,0)

    -- ── Window ───────────────────────────────────────────────────
    -- Layout constants (all pixel-based, no fractional sizes)
    local W   = 580    -- window width
    local TB_H = 46    -- topbar height
    local TAB_H = 38   -- tab bar height
    local D_H  = 1     -- divider height
    local SB_H = 26    -- status bar height
    local PC_W = 120   -- player card width
    local BODY_H = 300 -- content body height
    -- Total H = TB_H + D_H + TAB_H + D_H + BODY_H + SB_H = 412
    local H = TB_H + D_H + TAB_H + D_H + BODY_H + SB_H  -- 412

    local Win=frT(Gui)
    Win.Size=UDim2.fromOffset(W,H);Win.Position=UDim2.fromScale(.5,.5)
    Win.AnchorPoint=Vector2.new(.5,.5);Win.ZIndex=10;Win.ClipsDescendants=true
    cr(Win,12)

    -- Background layer (image + base color)
    local WinBg=Instance.new("Frame")
    WinBg.Size=UDim2.fromScale(1,1);WinBg.BackgroundColor3=B.BG
    WinBg.BackgroundTransparency=ALPHA;WinBg.BorderSizePixel=0;WinBg.ZIndex=10;WinBg.Parent=Win
    cr(WinBg,12)
    local winSK=sk(WinBg,lc(TH.A,B.BD,.55),1.5,.25)

    if self.BgId ~= "" then
        local BgImg=Instance.new("ImageLabel")
        BgImg.Size=UDim2.fromScale(1,1);BgImg.BackgroundTransparency=1
        BgImg.Image=self.BgId;BgImg.ScaleType=Enum.ScaleType.Crop
        BgImg.ImageTransparency=BG_ALPHA;BgImg.ZIndex=10;BgImg.Parent=WinBg
        cr(BgImg,12)
    end

    -- ── TopBar ───────────────────────────────────────────────────
    -- y=0, h=TB_H
    local TopBar=frT(Win)
    TopBar.Size=UDim2.fromOffset(W,TB_H);TopBar.Position=UDim2.fromOffset(0,0);TopBar.ZIndex=20

    local TopBg=fr(TopBar,lc(TH.A,B.BG,.86))
    TopBg.Size=UDim2.fromScale(1,1);TopBg.ZIndex=20;cr(TopBg,12)
    -- cover bottom corners
    local TopBgFix=Instance.new("Frame")
    TopBgFix.Size=UDim2.new(1,0,0,14);TopBgFix.Position=UDim2.new(0,0,1,-14)
    TopBgFix.BackgroundColor3=lc(TH.A,B.BG,.86);TopBgFix.BackgroundTransparency=ALPHA
    TopBgFix.BorderSizePixel=0;TopBgFix.ZIndex=20;TopBgFix.Parent=TopBar

    -- Divider line at bottom of topbar
    local TopLine=frT(Win)
    TopLine.Size=UDim2.fromOffset(W,D_H);TopLine.Position=UDim2.fromOffset(0,TB_H);TopLine.ZIndex=21
    local TopLineInner=fr(TopLine,lc(TH.A,B.BD,.6),.38)
    TopLineInner.Size=UDim2.fromScale(1,1);TopLineInner.ZIndex=21

    -- Traffic lights (left side of topbar)
    local DotsF=frT(TopBar)
    DotsF.Size=UDim2.fromOffset(58,13);DotsF.Position=UDim2.new(0,14,0.5,-6.5);DotsF.ZIndex=22
    hl(DotsF,6)
    local function wBtn(col)
        local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(13,13)
        b.BackgroundColor3=col;b.Text="";b.BorderSizePixel=0;b.ZIndex=23;b.Parent=DotsF;cr(b,7);return b
    end
    local CloseB=wBtn(Color3.fromRGB(255,95,87))
    local MinB  =wBtn(Color3.fromRGB(254,188,46))
    wBtn(Color3.fromRGB(40,200,64))

    -- Title area (right side): icon + title + desc on ONE line
    local TitleRow=frT(TopBar)
    -- width: up to 260px, right-aligned with 14px margin
    TitleRow.Size=UDim2.new(0,280,1,0);TitleRow.Position=UDim2.new(1,-292,0,0);TitleRow.ZIndex=22
    hl(TitleRow,6,Enum.HorizontalAlignment.Right,Enum.VerticalAlignment.Center)
    pd(TitleRow,0,0,0,0)

    -- desc "by FrontEvill" in dark-grey small font
    local DescL=lb(TitleRow,self.Desc,10,Enum.Font.Gotham,B.TDesc,Enum.TextXAlignment.Right)
    DescL.Size=UDim2.new(0,0,0,13);DescL.AutomaticSize=Enum.AutomaticSize.X;DescL.ZIndex=23

    -- title
    local TitleL=lb(TitleRow,self.Title,14,Enum.Font.GothamBold,TH.AL,Enum.TextXAlignment.Right)
    TitleL.Size=UDim2.new(0,0,0,18);TitleL.AutomaticSize=Enum.AutomaticSize.X;TitleL.ZIndex=23

    -- icon (if provided)
    local IconImg=nil
    if self.IconId ~= "" then
        IconImg=img2(TitleRow,self.IconId,22,TH.AL)
        IconImg.ZIndex=23
    end

    -- ── Tab Bar ──────────────────────────────────────────────────
    -- y = TB_H + D_H = 47, h = TAB_H = 38
    local TabY = TB_H + D_H
    local TabOuter=frT(Win)
    TabOuter.Size=UDim2.fromOffset(W-24, TAB_H)
    TabOuter.Position=UDim2.fromOffset(12, TabY)
    TabOuter.ClipsDescendants=true;TabOuter.ZIndex=20

    -- The actual tab buttons live in here
    local TBF=frT(TabOuter)
    TBF.Size=UDim2.fromScale(1,1);TBF.ZIndex=20
    hl(TBF,5,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

    -- Divider under tab bar
    local TabLineY = TabY + TAB_H
    local TabLine=frT(Win)
    TabLine.Size=UDim2.fromOffset(W,D_H);TabLine.Position=UDim2.fromOffset(0,TabLineY);TabLine.ZIndex=21
    local TabLineInner=fr(TabLine,lc(TH.A,B.BD,.6),.38)
    TabLineInner.Size=UDim2.fromScale(1,1);TabLineInner.ZIndex=21

    -- ── Body ─────────────────────────────────────────────────────
    -- y = TabLineY + D_H = 47+38+1 = 86, h = BODY_H = 300
    local BodyY = TabLineY + D_H
    local Body=frT(Win)
    Body.Size=UDim2.fromOffset(W,BODY_H);Body.Position=UDim2.fromOffset(0,BodyY)
    Body.ClipsDescendants=true;Body.ZIndex=15

    -- Player card
    local PC=fr(Body,B.S1)
    PC.Size=UDim2.fromOffset(PC_W,BODY_H);PC.Position=UDim2.fromOffset(0,0);PC.ZIndex=16;cr(PC,0)

    -- Right border of player card
    local PCSep=frT(Body)
    PCSep.Size=UDim2.fromOffset(1,BODY_H-8);PCSep.Position=UDim2.fromOffset(PC_W,4);PCSep.ZIndex=16
    local PCSepInner=fr(PCSep,B.BD,.62);PCSepInner.Size=UDim2.fromScale(1,1)

    -- Avatar
    local AvBg=fr(PC,lc(TH.A,B.BG,.84))
    AvBg.Size=UDim2.fromOffset(60,60);AvBg.Position=UDim2.new(.5,-30,0,14);AvBg.ZIndex=17;cr(AvBg,12)
    local avSK=sk(AvBg,TH.AL,2,.22)
    local AvImg=Instance.new("ImageLabel");AvImg.BackgroundTransparency=1
    AvImg.Size=UDim2.fromScale(1,1);AvImg.ScaleType=Enum.ScaleType.Fit
    AvImg.ZIndex=18;AvImg.Parent=AvBg;cr(AvImg,11)
    task.spawn(function()
        local ok,url=pcall(function()
            return Players:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
        end)
        if ok then AvImg.Image=url end
    end)

    -- Display name
    local NameL=lb(PC,LP.DisplayName,12,Enum.Font.GothamBold,B.TX,Enum.TextXAlignment.Center)
    NameL.Size=UDim2.new(1,-8,0,15);NameL.Position=UDim2.new(0,4,0,80)
    NameL.TextTruncate=Enum.TextTruncate.AtEnd;NameL.ZIndex=17

    -- Username
    local UserL=lb(PC,"@"..LP.Name,9,Enum.Font.Gotham,B.TS,Enum.TextXAlignment.Center)
    UserL.Size=UDim2.new(1,-8,0,13);UserL.Position=UDim2.new(0,4,0,96)
    UserL.TextTruncate=Enum.TextTruncate.AtEnd;UserL.ZIndex=17

    -- Separator
    local PCsep2=frT(PC)
    PCsep2.Size=UDim2.new(1,-20,0,1);PCsep2.Position=UDim2.new(0,10,0,116);PCsep2.ZIndex=17
    local PCsep2i=fr(PCsep2,B.BD,.6);PCsep2i.Size=UDim2.fromScale(1,1)

    -- Age
    local AgeL=lb(PC,LP.AccountAge.."d old",9,Enum.Font.Gotham,B.TD,Enum.TextXAlignment.Center)
    AgeL.Size=UDim2.new(1,-8,0,12);AgeL.Position=UDim2.new(0,4,0,124);AgeL.ZIndex=17

    -- Main panel
    local MP=frT(Body)
    MP.Size=UDim2.new(1,-(PC_W+8),1,0);MP.Position=UDim2.fromOffset(PC_W+8,0)
    MP.ClipsDescendants=true;MP.ZIndex=15

    -- ── Status bar ───────────────────────────────────────────────
    local SbY = BodyY + BODY_H
    local SBar=frT(Win)
    SBar.Size=UDim2.fromOffset(W,SB_H);SBar.Position=UDim2.fromOffset(0,SbY);SBar.ZIndex=20

    local SBg=fr(SBar,B.S1)
    SBg.Size=UDim2.fromScale(1,1);SBg.ZIndex=20;cr(SBg,12)
    local SBgFix=fr(SBar,B.S1)
    SBgFix.Size=UDim2.new(1,0,0.5,0);SBgFix.ZIndex=20

    local SSDot=frS(SBar,B.CG)
    SSDot.Size=UDim2.fromOffset(7,7);SSDot.Position=UDim2.new(0,12,0.5,-3.5);SSDot.ZIndex=22;cr(SSDot,4)

    local UptL=lb(SBar,"00:00",10,Enum.Font.GothamMedium,lc(TH.A,B.TD,.5),Enum.TextXAlignment.Left)
    UptL.Size=UDim2.new(0,70,1,0);UptL.Position=UDim2.fromOffset(24,0);UptL.ZIndex=22

    local StTxt=lb(SBar,"Connected — Orbs v5.0",10,Enum.Font.Gotham,B.TD,Enum.TextXAlignment.Left)
    StTxt.Size=UDim2.new(1,-110,1,0);StTxt.Position=UDim2.fromOffset(100,0);StTxt.ZIndex=22

    -- ── Float button ─────────────────────────────────────────────
    local FB=frS(Gui,TH.A)
    FB.Size=UDim2.fromOffset(46,46);FB.Position=UDim2.fromOffset(16,16)
    FB.Visible=false;FB.ZIndex=100;cr(FB,23)
    local fbSK=sk(FB,TH.AL,2,.35)
    local FBL=lb(FB,"◈",22,Enum.Font.GothamBold,B.W,Enum.TextXAlignment.Center)
    FBL.Size=UDim2.fromScale(1,1);FBL.TextYAlignment=Enum.TextYAlignment.Center;FBL.ZIndex=101
    local FBC=bt(FB);FBC.Size=UDim2.fromScale(1,1);FBC.ZIndex=102

    -- ── Controls ─────────────────────────────────────────────────
    drag(Win, TopBar)
    drag(FB, FB)

    local function hideWin()
        tw(Win,.22,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
        task.wait(.23);Win.Visible=false;FB.Visible=true
    end
    local function showWin()
        Win.Visible=true;FB.Visible=false;Win.Size=UDim2.fromOffset(0,0)
        tw(Win,.38,{Size=UDim2.fromOffset(W,H)},Enum.EasingStyle.Back)
    end

    CloseB.MouseButton1Click:Connect(function()
        tw(Win,.2,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
        task.wait(.21);Gui:Destroy()
    end)
    MinB.MouseButton1Click:Connect(function() task.spawn(hideWin) end)
    FBC.MouseButton1Click:Connect(function() task.spawn(showWin) end)
    UIS.InputBegan:Connect(function(i,gp)
        if not gp and i.KeyCode==self.MinKey then
            if Win.Visible then task.spawn(hideWin) else task.spawn(showWin) end
        end
    end)

    local tc=RunSvc.Heartbeat:Connect(function() UptL.Text=fmtT(tick()-self._t0) end)

    -- Store refs
    self._gui  = Gui
    self._win  = Win
    self._W    = W
    self._H    = H
    self._MP   = MP
    self._TBF  = TBF
    self._StTxt= StTxt
    self._SSDot= SSDot
    self._NH   = NH
    self._tc   = tc
    self._refs = {
        winSK=winSK, WinBg=WinBg,
        TopBg=TopBg, TopBgFix=TopBgFix,
        TopLineInner=TopLineInner, TabLineInner=TabLineInner,
        TitleL=TitleL, DescL=DescL, IconImg=IconImg,
        avSK=avSK, AvBg=AvBg,
        FB=FB, fbSK=fbSK, UptL=UptL,
    }
end

-- ── SetTheme ─────────────────────────────────────────────────────
function OrbsUI:SetTheme(name)
    local TH=TH_MAP[name]; if not TH then return end
    self.TH=TH; self.ThemeName=name
    local r=self._refs
    tw(r.winSK,      .25,{Color=lc(TH.A,B.BD,.55)})
    tw(r.WinBg,      .25,{BackgroundColor3=B.BG})
    tw(r.TopBg,      .25,{BackgroundColor3=lc(TH.A,B.BG,.86)})
    tw(r.TopBgFix,   .25,{BackgroundColor3=lc(TH.A,B.BG,.86)})
    tw(r.TopLineInner,.25,{BackgroundColor3=lc(TH.A,B.BD,.6)})
    tw(r.TabLineInner,.25,{BackgroundColor3=lc(TH.A,B.BD,.6)})
    tw(r.TitleL,     .25,{TextColor3=TH.AL})
    tw(r.avSK,       .25,{Color=TH.AL})
    tw(r.AvBg,       .25,{BackgroundColor3=lc(TH.A,B.BG,.84)})
    tw(r.FB,         .25,{BackgroundColor3=TH.A})
    tw(r.fbSK,       .25,{Color=TH.AL})
    tw(r.UptL,       .25,{TextColor3=lc(TH.A,B.TD,.5)})
    if r.IconImg then tw(r.IconImg,.25,{ImageColor3=TH.AL}) end
    for _,t in ipairs(self.Tabs) do
        if t._dline then tw(t._dline,.25,{BackgroundColor3=TH.A}) end
        if t==self.ActiveTab then
            tw(t._btn,.25,{BackgroundColor3=lc(TH.A,B.S2,.78)})
            if t._tl then tw(t._tl,.25,{TextColor3=TH.AL}) end
            if t._ic then tw(t._ic,.25,{ImageColor3=TH.AL}) end
            if t._dline then tw(t._dline,.25,{BackgroundTransparency=0}) end
        end
        if t._acBar then tw(t._acBar,.25,{BackgroundColor3=TH.A}) end
    end
end

-- ── SetStatus ────────────────────────────────────────────────────
function OrbsUI:SetStatus(text,kind)
    self._StTxt.Text=text or "Ready"
    local col=kind=="error" and B.CR or kind=="warn" and B.CW or B.CG
    tw(self._SSDot,.2,{BackgroundColor3=col})
end

-- ── Notify ───────────────────────────────────────────────────────
function OrbsUI:Notify(cfg)
    cfg=cfg or {}
    local title=cfg.Title or "Notification"
    local body =cfg.Content or ""
    local dur  =cfg.Duration or 4
    local col  =cfg.Color or self.TH.A
    self._nN=self._nN+1

    local NF=frS(self._NH,B.S2)
    NF.Size=UDim2.new(1,0,0,62);NF.Position=UDim2.new(1,8,0,0)
    NF.LayoutOrder=self._nN;NF.ZIndex=901;cr(NF,10);sk(NF,B.BD,1,.38)

    local NB=frS(NF,col);NB.Size=UDim2.fromOffset(3,36);NB.Position=UDim2.fromOffset(10,13);NB.ZIndex=902;cr(NB,2)
    local NT=lb(NF,title,13,Enum.Font.GothamBold,B.TX);NT.Size=UDim2.new(1,-56,0,17);NT.Position=UDim2.fromOffset(19,10);NT.ZIndex=902
    local NC=lb(NF,body,11,Enum.Font.Gotham,B.TS);NC.Size=UDim2.new(1,-56,0,24);NC.Position=UDim2.fromOffset(19,29)
    NC.TextWrapped=true;NC.TextTruncate=Enum.TextTruncate.AtEnd;NC.ZIndex=902
    local NX=frS(NF,B.S3);NX.Size=UDim2.fromOffset(20,20);NX.Position=UDim2.new(1,-28,0,8);NX.ZIndex=902;cr(NX,6)
    local NXL=lb(NX,"✕",10,Enum.Font.GothamBold,B.TS,Enum.TextXAlignment.Center)
    NXL.Size=UDim2.fromScale(1,1);NXL.TextYAlignment=Enum.TextYAlignment.Center;NXL.ZIndex=903
    local NXB=bt(NX);NXB.Size=UDim2.fromScale(1,1);NXB.ZIndex=904
    NXB.MouseEnter:Connect(function() tw(NX,.1,{BackgroundColor3=B.CR});tw(NXL,.1,{TextColor3=B.W}) end)
    NXB.MouseLeave:Connect(function() tw(NX,.1,{BackgroundColor3=B.S3});tw(NXL,.1,{TextColor3=B.TS}) end)
    tw(NF,.3,{Position=UDim2.new(0,0,0,0)},Enum.EasingStyle.Back)
    local gone=false
    local function dismiss()
        if gone then return end;gone=true
        tw(NF,.2,{Position=UDim2.new(1,8,0,0),BackgroundTransparency=1})
        task.wait(.22);if NF.Parent then NF:Destroy() end
    end
    NXB.MouseButton1Click:Connect(function() task.spawn(dismiss) end)
    NF.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then task.spawn(dismiss) end
    end)
    if dur>0 then task.spawn(function() task.wait(dur+.3);dismiss() end) end
end

-- ── Tab switching ────────────────────────────────────────────────
function OrbsUI:_selectTab(td)
    if self._busy or self.ActiveTab==td then return end
    self._busy=true
    local TH=self.TH
    local prev=self.ActiveTab
    -- deactivate all
    for _,t in ipairs(self.Tabs) do
        if t._tl  then tw(t._tl, .15,{TextColor3=B.TS}) end
        if t._ic  then tw(t._ic, .15,{ImageColor3=B.TD}) end
        if t._dline then tw(t._dline,.15,{BackgroundTransparency=1}) end
        tw(t._btn,.15,{BackgroundTransparency=1,BackgroundColor3=B.S2})
    end
    -- activate
    tw(td._btn,.15,{BackgroundColor3=lc(TH.A,B.S2,.78),BackgroundTransparency=ALPHA})
    if td._tl  then tw(td._tl, .15,{TextColor3=TH.AL}) end
    if td._ic  then tw(td._ic, .15,{ImageColor3=TH.AL}) end
    if td._dline then tw(td._dline,.15,{BackgroundTransparency=0}) end
    -- slide pages
    if prev and prev._sc then
        tw(prev._sc,.16,{Position=UDim2.new(-.06,0,0,0)},Enum.EasingStyle.Quint)
        task.delay(.17,function() prev._sc.Visible=false;prev._sc.Position=UDim2.fromScale(0,0) end)
    end
    td._sc.Position=UDim2.new(.06,0,0,0);td._sc.Visible=true
    tw(td._sc,.2,{Position=UDim2.fromScale(0,0)},Enum.EasingStyle.Quint)
    self.ActiveTab=td
    task.delay(.21,function() self._busy=false end)
end

-- ── AddTab ───────────────────────────────────────────────────────
function OrbsUI:AddTab(cfg)
    cfg=cfg or {}
    local name=cfg.Name or "Tab"
    local icn =cfg.Icon
    local TH  =self.TH

    -- Tab button: fixed height = TAB_H, auto width
    local Btn=Instance.new("TextButton")
    Btn.AutomaticSize=Enum.AutomaticSize.X
    Btn.Size=UDim2.new(0,0,1,-6)   -- full height minus 6px (3px top+bottom margin)
    Btn.AnchorPoint=Vector2.new(0,.5)
    Btn.BackgroundColor3=B.S2
    Btn.BackgroundTransparency=1
    Btn.Text="";Btn.BorderSizePixel=0;Btn.ZIndex=22
    Btn.Parent=self._TBF
    cr(Btn,6)
    pd(Btn,0,0,icn and 10 or 12, 12)
    hl(Btn,5,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

    local bIc=nil
    if icn then bIc=ico(Btn,icn,13,B.TD);bIc.ZIndex=23 end

    local bTl=lb(Btn,name,12,Enum.Font.GothamSemibold,B.TS)
    bTl.AutomaticSize=Enum.AutomaticSize.X;bTl.Size=UDim2.new(0,0,1,0);bTl.ZIndex=23

    -- bottom highlight line
    local dline=frS(Btn,TH.A)
    dline.BackgroundTransparency=1
    dline.Size=UDim2.new(1,-4,0,2);dline.Position=UDim2.new(0,2,1,-2);dline.ZIndex=24;cr(dline,1)

    -- ScrollingFrame for this tab's content
    local SC=Instance.new("ScrollingFrame")
    SC.BackgroundTransparency=1;SC.BorderSizePixel=0
    SC.Size=UDim2.fromScale(1,1)
    SC.ScrollBarThickness=3;SC.ScrollBarImageColor3=B.BD;SC.ScrollBarImageTransparency=.4
    SC.CanvasSize=UDim2.new(0,0,0,0);SC.AutomaticCanvasSize=Enum.AutomaticSize.Y
    SC.Visible=false;SC.ZIndex=16;SC.Parent=self._MP
    vl(SC,7);pd(SC,6,14,5,5)

    local td={Name=name,_btn=Btn,_tl=bTl,_ic=bIc,_dline=dline,_sc=SC,_acBar=nil}
    table.insert(self.Tabs,td)

    Btn.MouseButton1Click:Connect(function() self:_selectTab(td) end)
    Btn.MouseEnter:Connect(function()
        if self.ActiveTab~=td then tw(Btn,.1,{BackgroundTransparency=ALPHA+.2,BackgroundColor3=B.S2}) end
    end)
    Btn.MouseLeave:Connect(function()
        if self.ActiveTab~=td then tw(Btn,.1,{BackgroundTransparency=1}) end
    end)

    if #self.Tabs==1 then
        Btn.BackgroundColor3=lc(TH.A,B.S2,.78);Btn.BackgroundTransparency=ALPHA
        bTl.TextColor3=TH.AL;if bIc then bIc.ImageColor3=TH.AL end
        dline.BackgroundTransparency=0;SC.Visible=true;self.ActiveTab=td
    end

    local selfRef=self

    -- helper: make a content element frame
    local function mkF(h,parent)
        local f=frS(parent or SC,B.S2)
        f.BackgroundTransparency=ALPHA
        f.Size=UDim2.new(1,-2,0,h);cr(f,8);sk(f,B.BD,1,.62);return f
    end

    -- ── AddSection ───────────────────────────────────────────────
    local tabAPI={}

    function tabAPI:AddSection(o)
        o=o or {}
        local secName=o.Name or "Section"
        local TH2=selfRef.TH

        local SF=frS(SC,B.S1)
        SF.BackgroundTransparency=ALPHA+.05
        SF.Size=UDim2.new(1,-2,0,0);SF.AutomaticSize=Enum.AutomaticSize.Y
        cr(SF,10);sk(SF,B.BD,1,.5)

        local SH=frT(SF);SH.Size=UDim2.new(1,0,0,34)
        pd(SH,0,0,12,12);hl(SH,8,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

        local SBar=frS(SH,TH2.A);SBar.Size=UDim2.fromOffset(3,14);cr(SBar,2)
        td._acBar=SBar

        local STL=lb(SH,secName,12,Enum.Font.GothamBold,B.TX);STL.Size=UDim2.new(1,-28,1,0)

        local SDv=frT(SF);SDv.Size=UDim2.new(1,-22,0,1);SDv.Position=UDim2.fromOffset(11,34)
        local SDvi=frS(SDv,B.BD);SDvi.BackgroundTransparency=.6;SDvi.Size=UDim2.fromScale(1,1)

        local SC2=frT(SF);SC2.Size=UDim2.new(1,-22,0,0)
        SC2.Position=UDim2.fromOffset(11,42);SC2.AutomaticSize=Enum.AutomaticSize.Y;vl(SC2,5)

        local bot=Instance.new("UIPadding");bot.PaddingBottom=UDim.new(0,10);bot.Parent=SF

        local function smk(h2)
            local f=frS(SC2,B.S2);f.BackgroundTransparency=ALPHA
            f.Size=UDim2.new(1,0,0,h2);cr(f,7);sk(f,B.BD,1,.64);return f
        end

        local secAPI={}
        function secAPI:AddToggle(o2)   return _Toggle(smk,o2,selfRef.TH) end
        function secAPI:AddSlider(o2)   return _Slider(smk,o2,selfRef.TH) end
        function secAPI:AddButton(o2)   return _Button(smk,o2,selfRef.TH,selfRef._gui) end
        function secAPI:AddInput(o2)    return _Input(smk,o2,selfRef.TH) end
        function secAPI:AddDropdown(o2) return _Dropdown(SC2,o2,selfRef.TH) end
        function secAPI:AddParagraph(o2)
            o2=o2 or {}
            local PF=frS(SC2,B.S2);PF.BackgroundTransparency=ALPHA
            PF.Size=UDim2.new(1,0,0,0);PF.AutomaticSize=Enum.AutomaticSize.Y
            cr(PF,7);sk(PF,B.BD,1,.64);pd(PF,10,10,12,12)
            local PT=lb(PF,o2.Title or "",13,Enum.Font.GothamBold,B.TX)
            PT.Size=UDim2.new(1,0,0,o2.Title~="" and 18 or 0)
            local PC2=lb(PF,o2.Content or "",11,Enum.Font.Gotham,B.TS)
            PC2.Size=UDim2.new(1,0,0,0);PC2.AutomaticSize=Enum.AutomaticSize.Y
            PC2.Position=UDim2.fromOffset(0,o2.Title~="" and 22 or 0)
            PC2.TextWrapped=true;PC2.TextYAlignment=Enum.TextYAlignment.Top
            local p={};function p:SetTitle(v) PT.Text=v end;function p:SetContent(v) PC2.Text=v end;return p
        end
        return secAPI
    end

    function tabAPI:AddToggle(o)   return _Toggle(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddSlider(o)   return _Slider(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddButton(o)   return _Button(function(h) return mkF(h) end, o, selfRef.TH, selfRef._gui) end
    function tabAPI:AddInput(o)    return _Input(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddDropdown(o) return _Dropdown(SC, o, selfRef.TH) end
    function tabAPI:AddLabel(o)
        o=o or {}
        local l=lb(SC,(o.Text or ""):upper(),10,Enum.Font.GothamBold,B.TD)
        l.Size=UDim2.new(1,-2,0,18);l.LetterSpacing=1
        local a={};function a:Set(t) l.Text=t end;return a
    end
    function tabAPI:AddColorPicker(o)
        o=o or {}
        local cb=o.Callback or function() end
        local cols={
            {n="Purple",c=Color3.fromRGB(128,82,232)},{n="Red",   c=Color3.fromRGB(222,62,62)},
            {n="Cyan",  c=Color3.fromRGB(32,182,222)},{n="Green", c=Color3.fromRGB(42,182,102)},
            {n="Gold",  c=Color3.fromRGB(212,162,30)},{n="Orange",c=Color3.fromRGB(222,112,30)},
            {n="Pink",  c=Color3.fromRGB(202,52,162)},{n="White", c=Color3.fromRGB(202,202,212)},
        }
        local RF=mkF(58)
        local HL=lb(RF,(o.Name or "Color"):upper(),10,Enum.Font.GothamBold,B.TD)
        HL.Size=UDim2.new(1,-20,0,14);HL.Position=UDim2.fromOffset(10,6);HL.LetterSpacing=1
        local SR=frT(RF);SR.Size=UDim2.new(1,-20,0,22);SR.Position=UDim2.fromOffset(10,29)
        hl(SR,7)
        local sw={}
        for i,c in ipairs(cols) do
            local s=Instance.new("TextButton");s.Size=UDim2.fromOffset(20,20)
            s.BackgroundColor3=c.c;s.Text="";s.BorderSizePixel=0;s.ZIndex=17;s.Parent=SR;cr(s,5)
            local ss=sk(s,B.W,2,i==1 and 0 or 1)
            table.insert(sw,{b=s,s=ss})
            s.MouseButton1Click:Connect(function()
                for _,x in ipairs(sw) do x.s.Transparency=1 end
                ss.Transparency=0;cb(c.n,c.c)
            end)
        end
    end
    function tabAPI:AddSeparator()
        local s=frT(SC);s.Size=UDim2.new(1,-2,0,1)
        local si=frS(s,B.BD);si.BackgroundTransparency=.65;si.Size=UDim2.fromScale(1,1)
    end

    return tabAPI
end

-- ── Element builders ─────────────────────────────────────────────
function _Toggle(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Toggle";local desc=o.Description or ""
    local def=o.Default or false;local icn=o.Icon;local cb=o.Callback or function() end
    local state=def;local H=desc~="" and 54 or 36

    local F=mkF(H)
    if icn then local i=ico(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL.Size=UDim2.new(1,-(icn and 72 or 54),0,15);TL.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
        DL.Size=UDim2.new(1,-(icn and 72 or 54),0,13);DL.Position=UDim2.fromOffset(icn and 30 or 12,26)
        DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local Tr=frS(F,state and TH.A or B.S4)
    Tr.Size=UDim2.fromOffset(34,18);Tr.Position=UDim2.new(1,-42,0.5,-9);cr(Tr,9)
    local TrSK=sk(Tr,state and TH.AL or B.BD,1,.5)
    local Kn=frS(Tr,B.W);Kn.Size=UDim2.fromOffset(12,12);Kn.Position=UDim2.fromOffset(state and 19 or 3,3);cr(Kn,6)
    local C2=bt(F);C2.Size=UDim2.fromScale(1,1)
    local function set(v)
        state=v
        tw(Tr,.18,{BackgroundColor3=v and TH.A or B.S4})
        tw(TrSK,.18,{Color=v and TH.AL or B.BD})
        tw(Kn,.18,{Position=UDim2.fromOffset(v and 19 or 3,3)},Enum.EasingStyle.Back)
        task.spawn(cb,v)
    end
    C2.MouseEnter:Connect(function() tw(F,.08,{BackgroundColor3=B.S3}) end)
    C2.MouseLeave:Connect(function() tw(F,.08,{BackgroundColor3=B.S2}) end)
    C2.MouseButton1Click:Connect(function() set(not state) end)
    if state then task.spawn(cb,state) end
    local a={};function a:Set(v) set(v) end;function a:Get() return state end;return a
end

function _Slider(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Slider";local desc=o.Description or ""
    local mn=o.Min or 0;local mx=o.Max or 100;local def=o.Default or mn
    local suf=o.Suffix or "";local rnd=o.Rounding or 1;local icn=o.Icon
    local cb=o.Callback or function() end
    local val=math.clamp(def,mn,mx);local drag2=false;local H=desc~="" and 66 or 50

    local F=mkF(H)
    if icn then local i=ico(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,10) end
    local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL.Size=UDim2.new(1,-70,0,15);TL.Position=UDim2.fromOffset(icn and 30 or 12,9)
    local VL=lb(F,tostring(val)..suf,12,Enum.Font.GothamBold,TH.AL,Enum.TextXAlignment.Right)
    VL.Size=UDim2.new(0,52,0,15);VL.Position=UDim2.new(1,-60,0,9)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
        DL.Size=UDim2.new(1,-24,0,13);DL.Position=UDim2.fromOffset(12,26)
        DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local tY=desc~="" and 44 or 30
    local Tr=frS(F,B.S4);Tr.Size=UDim2.new(1,-22,0,4);Tr.Position=UDim2.fromOffset(11,tY);cr(Tr,3)
    local Fi=frS(Tr,TH.A);Fi.Size=UDim2.new((val-mn)/(mx-mn),0,1,0);cr(Fi,3)
    local Kn=frS(Tr,B.W)
    Kn.Size=UDim2.fromOffset(13,13);Kn.Position=UDim2.new((val-mn)/(mx-mn),-6,0.5,-6);cr(Kn,7)
    sk(Kn,TH.AL,1.5,.3)
    local function set(v)
        v=math.clamp(v,mn,mx);if rnd>0 then v=math.round(v/rnd)*rnd end
        val=v;local p=(v-mn)/(mx-mn)
        tw(Fi,.06,{Size=UDim2.new(p,0,1,0)});tw(Kn,.06,{Position=UDim2.new(p,-6,0.5,-6)})
        VL.Text=tostring(v)..suf;task.spawn(cb,v)
    end
    local function gp(x) return math.clamp((x-Tr.AbsolutePosition.X)/Tr.AbsoluteSize.X,0,1) end
    Tr.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag2=true;tw(Kn,.1,{Size=UDim2.fromOffset(17,17)},Enum.EasingStyle.Back);set(mn+(mx-mn)*gp(i.Position.X))
        end
    end)
    Kn.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            drag2=true;tw(Kn,.1,{Size=UDim2.fromOffset(17,17)},Enum.EasingStyle.Back)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag2 and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            set(mn+(mx-mn)*gp(i.Position.X))
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if drag2 and(i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
            drag2=false;tw(Kn,.1,{Size=UDim2.fromOffset(13,13)})
        end
    end)
    set(val)
    local a={};function a:Set(v) set(v) end;function a:Get() return val end;return a
end

function _Button(mkF, o, TH, gui)
    o=o or {}
    local name=o.Name or "Button";local desc=o.Description or ""
    local icn=o.Icon;local conf=o.Confirm or false;local cb=o.Callback or function() end
    local H=desc~="" and 54 or 36

    local F=mkF(H)
    if icn then local i=ico(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL.Size=UDim2.new(1,-(icn and 72 or 52),0,15);TL.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
        DL.Size=UDim2.new(1,-(icn and 72 or 52),0,13);DL.Position=UDim2.fromOffset(icn and 30 or 12,26)
        DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local Ar=frS(F,TH.A);Ar.BackgroundTransparency=.82
    Ar.Size=UDim2.fromOffset(22,22);Ar.Position=UDim2.new(1,-30,0.5,-11);cr(Ar,6)
    local ArL=lb(Ar,"›",17,Enum.Font.GothamBold,TH.AL,Enum.TextXAlignment.Center)
    ArL.Size=UDim2.fromScale(1,1);ArL.TextYAlignment=Enum.TextYAlignment.Center
    local C2=bt(F);C2.Size=UDim2.fromScale(1,1)
    C2.MouseEnter:Connect(function() tw(F,.1,{BackgroundColor3=B.S3});tw(TL,.1,{TextColor3=TH.AL});tw(Ar,.1,{BackgroundTransparency=.62}) end)
    C2.MouseLeave:Connect(function() tw(F,.1,{BackgroundColor3=B.S2});tw(TL,.1,{TextColor3=B.TX});tw(Ar,.1,{BackgroundTransparency=.82}) end)

    local function doConf(cb2)
        local OV=Instance.new("Frame");OV.BackgroundColor3=Color3.new();OV.BackgroundTransparency=.55
        OV.Size=UDim2.fromScale(1,1);OV.BorderSizePixel=0;OV.ZIndex=500;OV.Parent=gui
        local DF=frS(gui,B.S2);DF.Size=UDim2.fromOffset(0,0);DF.Position=UDim2.fromScale(.5,.5)
        DF.AnchorPoint=Vector2.new(.5,.5);DF.ZIndex=501;cr(DF,12);sk(DF,B.BD,1,.32)
        tw(DF,.28,{Size=UDim2.fromOffset(304,120)},Enum.EasingStyle.Back)
        local DT=lb(DF,"Confirm",15,Enum.Font.GothamBold,B.TX);DT.Size=UDim2.new(1,-28,0,20);DT.Position=UDim2.fromOffset(14,12);DT.ZIndex=502
        local DX=lb(DF,"Are you sure?",11,Enum.Font.Gotham,B.TS);DX.Size=UDim2.new(1,-28,0,26);DX.Position=UDim2.fromOffset(14,36);DX.TextWrapped=true;DX.ZIndex=502
        local function dB(tx,co,xoff)
            local db=frS(DF,co);db.Size=UDim2.fromOffset(90,26);db.Position=UDim2.new(1,xoff,1,-36);db.ZIndex=502;cr(db,7)
            local dl=lb(db,tx,11,Enum.Font.GothamSemibold,B.W,Enum.TextXAlignment.Center)
            dl.Size=UDim2.fromScale(1,1);dl.TextYAlignment=Enum.TextYAlignment.Center;dl.ZIndex=503
            local dbb=bt(db);dbb.Size=UDim2.fromScale(1,1);dbb.ZIndex=504;return dbb
        end
        local closed=false
        local function cD()
            if closed then return end;closed=true
            tw(DF,.15,{Size=UDim2.fromOffset(0,0)});task.wait(.16);OV:Destroy();DF:Destroy()
        end
        dB("Cancel",B.S4,-198).MouseButton1Click:Connect(cD)
        dB("Confirm",TH.A,-100).MouseButton1Click:Connect(function() cD();task.spawn(cb2) end)
        OV.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then cD() end end)
    end

    C2.MouseButton1Click:Connect(function()
        tw(F,.06,{Size=UDim2.new(1,-2,0,H-3)});task.wait(.06)
        tw(F,.1,{Size=UDim2.new(1,-2,0,H)},Enum.EasingStyle.Back)
        if conf then doConf(cb) else task.spawn(cb) end
    end)
    local a={};function a:SetText(t) TL.Text=t end;return a
end

function _Input(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Input";local desc=o.Description or ""
    local def=o.Default or "";local ph=o.Placeholder or "Enter value..."
    local num=o.Numeric or false;local fin=o.Finished or false;local icn=o.Icon
    local cb=o.Callback or function() end
    local val=def;local H=desc~="" and 66 or 50

    local F=mkF(H);local FSK=F:FindFirstChildOfClass("UIStroke")
    if icn then local i=ico(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,10) end
    local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL.Size=UDim2.new(1,-24,0,15);TL.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 8 or 6)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
        DL.Size=UDim2.new(1,-24,0,13);DL.Position=UDim2.fromOffset(12,24);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local IB=Instance.new("TextBox");IB.BackgroundColor3=B.S3;IB.BackgroundTransparency=.1;IB.BorderSizePixel=0
    IB.Size=UDim2.new(1,-22,0,24);IB.Position=UDim2.fromOffset(11,desc~="" and 42 or 24)
    IB.Text=def;IB.PlaceholderText=ph;IB.PlaceholderColor3=B.TD;IB.TextColor3=B.TX
    IB.TextSize=12;IB.Font=Enum.Font.Gotham;IB.TextXAlignment=Enum.TextXAlignment.Left;IB.ZIndex=17;IB.Parent=F
    cr(IB,6);pd(IB,0,0,9,9)
    local ibSK=sk(IB,B.BD,1,.5)
    IB.Focused:Connect(function()
        tw(ibSK,.12,{Color=TH.A,Transparency=.1});if FSK then tw(FSK,.12,{Color=TH.A,Transparency=.32}) end
    end)
    IB.FocusLost:Connect(function(e)
        tw(ibSK,.12,{Color=B.BD,Transparency=.5});if FSK then tw(FSK,.12,{Color=B.BD,Transparency=.62}) end
        if fin and e then val=IB.Text;task.spawn(cb,val) end
    end)
    if not fin then
        IB:GetPropertyChangedSignal("Text"):Connect(function()
            if num then local cl=IB.Text:gsub("[^%d%.%-]","");if cl~=IB.Text then IB.Text=cl end end
            val=IB.Text;task.spawn(cb,val)
        end)
    end
    local a={};function a:Set(v) IB.Text=tostring(v);val=tostring(v) end;function a:Get() return val end;return a
end

function _Dropdown(parent, o, TH)
    o=o or {}
    local name=o.Name or "Dropdown";local desc=o.Description or ""
    local items=o.Items or {};local multi=o.Multi or false
    local def=o.Default or(multi and {} or(items[1] or ""))
    local icn=o.Icon;local cb=o.Callback or function() end
    local open=false;local H=desc~="" and 54 or 36
    local sel=multi and {} or def
    if multi and type(def)=="table" then for _,v in pairs(def) do sel[v]=true end end

    local F=frS(parent,B.S2);F.BackgroundTransparency=ALPHA
    F.Size=UDim2.new(1,-2,0,H);F.ClipsDescendants=true;cr(F,8)
    local FSK=sk(F,B.BD,1,.62)
    if icn then local i=ico(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL.Size=UDim2.new(1,-(icn and 62 or 44),0,15);TL.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    local Ar=lb(F,"⌄",13,Enum.Font.GothamBold,B.TS,Enum.TextXAlignment.Center)
    Ar.Size=UDim2.fromOffset(16,15);Ar.Position=UDim2.new(1,-22,0,desc~="" and 9 or 10)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
        DL.Size=UDim2.new(1,-44,0,13);DL.Position=UDim2.fromOffset(12,25);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local VL=lb(F,"",11,Enum.Font.GothamMedium,TH.AL)
    VL.Size=UDim2.new(1,-44,0,13);VL.Position=UDim2.fromOffset(12,desc~="" and 38 or 22);VL.TextTruncate=Enum.TextTruncate.AtEnd

    local DL2=frS(F,B.S3);DL2.Size=UDim2.new(1,-6,0,0);DL2.Position=UDim2.fromOffset(3,H+3);cr(DL2,7);sk(DL2,B.BD,1,.52)
    local DSc=Instance.new("ScrollingFrame");DSc.BackgroundTransparency=1;DSc.BorderSizePixel=0
    DSc.Size=UDim2.fromScale(1,1);DSc.ScrollBarThickness=2;DSc.ScrollBarImageColor3=B.BD
    DSc.CanvasSize=UDim2.new(0,0,0,0);DSc.AutomaticCanvasSize=Enum.AutomaticSize.Y;DSc.ZIndex=18;DSc.Parent=DL2
    pd(DSc,3,3,4,4);vl(DSc,2)
    local DC=bt(F);DC.Size=UDim2.new(1,0,0,H)

    local function updL()
        if multi then local s={};for v,on in pairs(sel) do if on then table.insert(s,v) end end
            VL.Text=#s==0 and "None" or(#s==1 and s[1] or s[1].." +"..#s-1)
        else VL.Text=sel~="" and sel or "None" end
    end
    local function togO()
        open=not open;local lh=open and math.min(#items*26+6,126) or 0
        tw(F,.2,{Size=UDim2.new(1,-2,0,H+(open and lh+6 or 0))})
        tw(DL2,.2,{Size=UDim2.new(1,-6,0,lh)});tw(Ar,.16,{Rotation=open and 180 or 0})
        tw(FSK,.14,{Color=open and TH.A or B.BD,Transparency=open and .18 or .62})
    end
    DC.MouseButton1Click:Connect(togO)
    local function buildI()
        for _,c in ipairs(DSc:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        for i,v in ipairs(items) do
            local OF=frS(DSc,B.S2);OF.BackgroundTransparency=.6
            OF.Size=UDim2.new(1,0,0,24);OF.LayoutOrder=i;cr(OF,5)
            local isA=multi and sel[v] or(not multi and sel==v)
            local OL=lb(OF,v,11,Enum.Font.GothamMedium,isA and TH.AL or B.TS)
            OL.Size=UDim2.new(1,-8,1,0);OL.Position=UDim2.fromOffset(7,0);OL.ZIndex=19
            local OB=bt(OF);OB.Size=UDim2.fromScale(1,1);OB.ZIndex=20
            OB.MouseEnter:Connect(function() tw(OF,.07,{BackgroundTransparency=.28}) end)
            OB.MouseLeave:Connect(function() tw(OF,.07,{BackgroundTransparency=.6}) end)
            OB.MouseButton1Click:Connect(function()
                if multi then
                    sel[v]=not sel[v];tw(OL,.1,{TextColor3=sel[v] and TH.AL or B.TS})
                    updL();local s={};for sv,on in pairs(sel) do if on then table.insert(s,sv) end end;task.spawn(cb,s)
                else
                    sel=v
                    for _,c2 in ipairs(DSc:GetChildren()) do
                        if c2:IsA("Frame") then local l2=c2:FindFirstChildOfClass("TextLabel");if l2 then l2.TextColor3=B.TS end end
                    end
                    tw(OL,.1,{TextColor3=TH.AL});updL();togO();task.spawn(cb,v)
                end
            end)
        end
    end
    buildI();updL()
    local a={}
    function a:Set(v)
        if multi then sel={};if type(v)=="table" then for _,sv in pairs(v) do sel[sv]=true end end
        else sel=v end;buildI();updL()
    end
    function a:SetItems(vals) items=vals;buildI();updL() end
    function a:Get()
        if multi then local s={};for sv,on in pairs(sel) do if on then table.insert(s,sv) end end;return s end;return sel
    end
    return a
end

function OrbsUI:Toggle()
    self.Visible=not self.Visible;self._win.Visible=self.Visible
end
function OrbsUI:Destroy()
    if self._tc then self._tc:Disconnect() end;self._gui:Destroy()
end

return OrbsUI
