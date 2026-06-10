--[[
    OrbsUI v4.0
    Usage: local OrbsUI = loadstring(game:HttpGet("RAW_URL"))()
]]

local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenSvc  = game:GetService("TweenService")
local UIS       = game:GetService("UserInputService")
local Players   = game:GetService("Players")
local RunSvc    = game:GetService("RunService")
local LP        = Players.LocalPlayer

local ICO = {
    home="rbxassetid://7733960981", settings="rbxassetid://7734053495",
    user="rbxassetid://7733974796", sword="rbxassetid://7734014785",
    eye="rbxassetid://7734053476",  zap="rbxassetid://7734014757",
    shield="rbxassetid://7733942387", star="rbxassetid://7734053548",
    target="rbxassetid://7734014807", map="rbxassetid://7733960985",
    lock="rbxassetid://7733960971",   unlock="rbxassetid://7733960987",
    bell="rbxassetid://7733942307",   trash="rbxassetid://7734014815",
    edit="rbxassetid://7733942363",   check="rbxassetid://7733942335",
    close="rbxassetid://7733942347",  plus="rbxassetid://7734014799",
    minus="rbxassetid://7733960983",  arrow_right="rbxassetid://7733942295",
    arrow_left="rbxassetid://7733942289", arrow_up="rbxassetid://7733942299",
    arrow_down="rbxassetid://7733942293", refresh="rbxassetid://7734014803",
    download="rbxassetid://7733942357",   upload="rbxassetid://7733942393",
    search="rbxassetid://7734014789",     info="rbxassetid://7733942379",
    warning="rbxassetid://7733942397",    danger="rbxassetid://7733942353",
    heart="rbxassetid://7733942373",      chat="rbxassetid://7733942341",
    camera="rbxassetid://7733942325",     music="rbxassetid://7733942383",
    fly="rbxassetid://7733942369",        speed="rbxassetid://7733942391",
    ghost="rbxassetid://7733942371",      misc="rbxassetid://7733942387",
    visual="rbxassetid://7733942393",     combat="rbxassetid://7734014785",
    movement="rbxassetid://7733942369",   player="rbxassetid://7733974796",
    world="rbxassetid://7733960985",      kill="rbxassetid://7734014757",
    teleport="rbxassetid://7734014815",   signal="rbxassetid://7733942391",
    save="rbxassetid://7733942363",       terminal="rbxassetid://7734053495",
    play="rbxassetid://7734014757",       wrench="rbxassetid://7733942387",
    run="rbxassetid://7734014785",        script="rbxassetid://7734053495",
    money="rbxassetid://7733942383",      note="rbxassetid://7733942383",
    plug="rbxassetid://7733942387",       locate="rbxassetid://7733960985",
    logs="rbxassetid://7734053495",       ruler="rbxassetid://7734014807",
    scroll="rbxassetid://7733942383",     phone="rbxassetid://7733942341",
    aimbot="rbxassetid://7734014807",     esp="rbxassetid://7733942363",
}

local TH_MAP = {
    Purple = {A=Color3.fromRGB(128,82,232), AL=Color3.fromRGB(182,148,255), AD=Color3.fromRGB(82,52,168)},
    Red    = {A=Color3.fromRGB(222,62,62),  AL=Color3.fromRGB(255,128,128), AD=Color3.fromRGB(162,38,38)},
    Cyan   = {A=Color3.fromRGB(32,182,222), AL=Color3.fromRGB(108,222,255), AD=Color3.fromRGB(20,132,172)},
    Green  = {A=Color3.fromRGB(42,182,102), AL=Color3.fromRGB(108,222,158), AD=Color3.fromRGB(26,132,70)},
    Gold   = {A=Color3.fromRGB(212,162,30), AL=Color3.fromRGB(255,212,82),  AD=Color3.fromRGB(162,120,18)},
    Orange = {A=Color3.fromRGB(222,112,30), AL=Color3.fromRGB(255,162,82),  AD=Color3.fromRGB(162,80,18)},
    Pink   = {A=Color3.fromRGB(202,52,162), AL=Color3.fromRGB(255,108,212), AD=Color3.fromRGB(152,30,120)},
    White  = {A=Color3.fromRGB(202,202,212),AL=Color3.fromRGB(242,242,255), AD=Color3.fromRGB(162,162,175)},
}

local B = {
    BG = Color3.fromRGB(13,13,20),
    S1 = Color3.fromRGB(19,19,30),
    S2 = Color3.fromRGB(25,25,39),
    S3 = Color3.fromRGB(31,31,48),
    S4 = Color3.fromRGB(37,37,56),
    BD = Color3.fromRGB(46,46,70),
    TX = Color3.fromRGB(224,216,255),
    TS = Color3.fromRGB(132,120,182),
    TD = Color3.fromRGB(72,65,112),
    W  = Color3.fromRGB(255,255,255),
    CG = Color3.fromRGB(40,202,72),
    CR = Color3.fromRGB(232,65,65),
    CW = Color3.fromRGB(238,160,28),
}

local function lc(a,b,t) return Color3.new(a.R+(b.R-a.R)*t,a.G+(b.G-a.G)*t,a.B+(b.B-a.B)*t) end

local function tw(obj,t,p,s,d)
    TweenSvc:Create(obj,TweenInfo.new(t or .18,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play()
end
local function cr(f,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 8);c.Parent=f;return c end
local function sk(f,col,th,tr)
    local s=Instance.new("UIStroke");s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
    s.Color=col or B.BD;s.Thickness=th or 1;s.Transparency=tr or 0;s.Parent=f;return s
end
local function pd(f,t,b,l,r)
    local p=Instance.new("UIPadding");p.PaddingTop=UDim.new(0,t or 0);p.PaddingBottom=UDim.new(0,b or 0)
    p.PaddingLeft=UDim.new(0,l or 0);p.PaddingRight=UDim.new(0,r or 0);p.Parent=f
end
local function vl(f,sp)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Vertical
    l.HorizontalAlignment=Enum.HorizontalAlignment.Left;l.VerticalAlignment=Enum.VerticalAlignment.Top
    l.Padding=UDim.new(0,sp or 0);l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=f;return l
end
local function hl(f,sp,ha,va)
    local l=Instance.new("UIListLayout");l.FillDirection=Enum.FillDirection.Horizontal
    l.HorizontalAlignment=ha or Enum.HorizontalAlignment.Left
    l.VerticalAlignment=va or Enum.VerticalAlignment.Center
    l.Padding=UDim.new(0,sp or 0);l.SortOrder=Enum.SortOrder.LayoutOrder;l.Parent=f;return l
end
local function fr(p,bg,bt2)
    local f=Instance.new("Frame");f.BackgroundColor3=bg or B.BG
    f.BackgroundTransparency=bt2 or 0;f.BorderSizePixel=0;f.Parent=p;return f
end
local function lb(p,tx,sz,fn,co)
    local l=Instance.new("TextLabel");l.BackgroundTransparency=1;l.Text=tx or ""
    l.TextSize=sz or 13;l.Font=fn or Enum.Font.GothamMedium;l.TextColor3=co or B.TX
    l.TextXAlignment=Enum.TextXAlignment.Left;l.BorderSizePixel=0;l.Parent=p;return l
end
local function bt(p)
    local b=Instance.new("TextButton");b.BackgroundTransparency=1;b.Text=""
    b.BorderSizePixel=0;b.Parent=p;return b
end
local function img(p,name,sz,co)
    local i=Instance.new("ImageLabel");i.BackgroundTransparency=1
    i.Size=UDim2.fromOffset(sz or 14,sz or 14)
    i.Image=ICO[(name or ""):lower()] or "";i.ImageColor3=co or B.TS
    i.ScaleType=Enum.ScaleType.Fit;i.Parent=p;return i
end
local function fmtT(s)
    local h=math.floor(s/3600);local m=math.floor((s%3600)/60);local sc=math.floor(s%60)
    if h>0 then return string.format("%02d:%02d:%02d",h,m,sc) end
    return string.format("%02d:%02d",m,sc)
end

-- Smooth dragging with no jitter
local function makeDraggable(win, handle)
    local dragging,start,origin=false,nil,nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then
            dragging=true; start=i.Position; origin=win.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-start
            win.Position=UDim2.new(origin.X.Scale,origin.X.Offset+d.X,origin.Y.Scale,origin.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
end

function OrbsUI.new(cfg)
    cfg=cfg or {}
    local self=setmetatable({},OrbsUI)
    self.TH       = TH_MAP[cfg.Theme] or TH_MAP.Purple
    self.ThemeName= cfg.Theme or "Purple"
    self.Title    = cfg.Title or "Orbs"
    self.Desc     = cfg.Description or "By FrontEvill"
    self.MinKey   = cfg.MinimizeKey or Enum.KeyCode.RightShift
    self.Tabs     = {}
    self.ActiveTab= nil
    self._t0      = tick()
    self._nN      = 0
    self._busy    = false
    self:_build()
    return self
end

function OrbsUI:_build()
    local TH=self.TH

    -- ScreenGui
    local Gui=Instance.new("ScreenGui")
    Gui.Name="OrbsUI";Gui.ResetOnSpawn=false
    Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;Gui.IgnoreGuiInset=true
    if not pcall(function() Gui.Parent=game:GetService("CoreGui") end) then
        Gui.Parent=LP:WaitForChild("PlayerGui")
    end

    -- Notification holder (bottom-right)
    local NH=fr(Gui,Color3.new(),1)
    NH.Size=UDim2.new(0,300,1,0);NH.Position=UDim2.new(1,-308,0,0);NH.ZIndex=900
    local nhl=vl(NH,6);nhl.VerticalAlignment=Enum.VerticalAlignment.Bottom
    nhl.HorizontalAlignment=Enum.HorizontalAlignment.Right
    pd(NH,0,12,0,0)

    local W,H=560,400
    local Win=fr(Gui,B.BG)
    Win.Size=UDim2.fromOffset(W,H);Win.Position=UDim2.fromScale(.5,.5)
    Win.AnchorPoint=Vector2.new(.5,.5);Win.ZIndex=10;Win.ClipsDescendants=false
    cr(Win,12)
    local winSK=sk(Win,lc(TH.A,B.BD,.55),1.5,.25)

    -- TopBar (44px)
    local TB=fr(Win,lc(TH.A,B.BG,.87))
    TB.Size=UDim2.new(1,0,0,44);TB.ZIndex=11;cr(TB,12)
    -- fix bottom corners of topbar
    local TBfix=fr(TB,lc(TH.A,B.BG,.87))
    TBfix.Size=UDim2.new(1,0,0,12);TBfix.Position=UDim2.new(0,0,1,-12);TBfix.ZIndex=11
    local TBline=fr(TB,lc(TH.A,B.BD,.62),.35)
    TBline.Size=UDim2.new(1,0,0,1);TBline.Position=UDim2.new(0,0,1,0);TBline.ZIndex=12

    -- Traffic lights
    local dots=fr(TB,Color3.new(),1)
    dots.Size=UDim2.new(0,64,0,13);dots.Position=UDim2.fromOffset(12,0)
    dots.ZIndex=12;hl(dots,6,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)
    dots.Position=UDim2.new(0,14,0.5,-6)
    local function wDot(col)
        local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(13,13)
        b.BackgroundColor3=col;b.Text="";b.BorderSizePixel=0;b.ZIndex=13;b.Parent=dots;cr(b,7);return b
    end
    local CloseB=wDot(Color3.fromRGB(255,95,87))
    local MinB=wDot(Color3.fromRGB(254,188,46))
    wDot(Color3.fromRGB(40,200,64))

    -- Title block (right side)
    local TB2=fr(TB,Color3.new(),1)
    TB2.Size=UDim2.new(0,200,1,0);TB2.Position=UDim2.new(1,-208,0,0);TB2.ZIndex=12
    local TL=lb(TB2,self.Title,14,Enum.Font.GothamBold,TH.AL)
    TL.Size=UDim2.new(1,0,0,17);TL.Position=UDim2.fromOffset(0,7)
    TL.TextXAlignment=Enum.TextXAlignment.Right;TL.ZIndex=13
    local DL=lb(TB2,self.Desc,10,Enum.Font.Gotham,lc(TH.A,B.TD,.45))
    DL.Size=UDim2.new(1,0,0,13);DL.Position=UDim2.fromOffset(0,26)
    DL.TextXAlignment=Enum.TextXAlignment.Right;DL.ZIndex=13

    -- Divider under topbar
    local D1=fr(Win,lc(TH.A,B.BD,.65),.38)
    D1.Size=UDim2.new(1,0,0,1);D1.Position=UDim2.fromOffset(0,44);D1.ZIndex=12

    local TabBar=fr(Win,Color3.new(),1)
    TabBar.Size=UDim2.new(1,-24,0,40);TabBar.Position=UDim2.fromOffset(12,46)
    TabBar.ZIndex=11;TabBar.ClipsDescendants=true
    local TBF=fr(TabBar,Color3.new(),1)
    TBF.Size=UDim2.fromScale(1,1);TBF.ZIndex=11
    hl(TBF,4,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

    local D2=fr(Win,lc(TH.A,B.BD,.65),.38)
    D2.Size=UDim2.new(1,0,0,1);D2.Position=UDim2.fromOffset(0,86);D2.ZIndex=12

    -- Total body height = H - 44(topbar) - 1(D1) - 40(tabbar) - 1(D2) - 24(statusbar) = H-110
    local BodyH = H - 110
    local Body=fr(Win,Color3.new(),1)
    Body.Size=UDim2.fromOffset(W-24, BodyH)
    Body.Position=UDim2.fromOffset(12,88)
    Body.ZIndex=11;Body.ClipsDescendants=true

    local PC_W=110
    local PC=fr(Body,B.S1)
    PC.Size=UDim2.fromOffset(PC_W,BodyH);PC.ZIndex=12;cr(PC,10)
    local pcSK=sk(PC,lc(TH.A,B.BD,.42),1.5,.22)

    local AvW=fr(PC,lc(TH.A,B.BG,.84))
    AvW.Size=UDim2.fromOffset(58,58);AvW.Position=UDim2.new(.5,-29,0,12);AvW.ZIndex=13;cr(AvW,12)
    local avSK=sk(AvW,TH.AL,2,.2)
    local AvI=Instance.new("ImageLabel");AvI.BackgroundTransparency=1
    AvI.Size=UDim2.fromScale(1,1);AvI.ScaleType=Enum.ScaleType.Fit;AvI.ZIndex=14;AvI.Parent=AvW;cr(AvI,11)
    task.spawn(function()
        local ok,url=pcall(function()
            return Players:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
        end)
        if ok then AvI.Image=url end
    end)

    local NL=lb(PC,LP.DisplayName,12,Enum.Font.GothamBold,B.TX)
    NL.Size=UDim2.new(1,-8,0,15);NL.Position=UDim2.new(0,4,0,76)
    NL.TextXAlignment=Enum.TextXAlignment.Center;NL.TextTruncate=Enum.TextTruncate.AtEnd;NL.ZIndex=13

    local UL=lb(PC,"@"..LP.Name,9,Enum.Font.Gotham,B.TS)
    UL.Size=UDim2.new(1,-8,0,13);UL.Position=UDim2.new(0,4,0,92)
    UL.TextXAlignment=Enum.TextXAlignment.Center;UL.TextTruncate=Enum.TextTruncate.AtEnd;UL.ZIndex=13

    local sep=fr(PC,B.BD,.62)
    sep.Size=UDim2.new(1,-18,0,1);sep.Position=UDim2.new(0,9,0,112);sep.ZIndex=13

    local AL=lb(PC,LP.AccountAge.."d old",9,Enum.Font.Gotham,B.TD)
    AL.Size=UDim2.new(1,-8,0,12);AL.Position=UDim2.new(0,4,0,120)
    AL.TextXAlignment=Enum.TextXAlignment.Center;AL.ZIndex=13

    -- Vertical separator between card and content
    local vsep=fr(Body,B.BD,.62)
    vsep.Size=UDim2.fromOffset(1,BodyH-8);vsep.Position=UDim2.fromOffset(PC_W+4,4);vsep.ZIndex=12

    -- Main panel (right of card)
    local MP=fr(Body,Color3.new(),1)
    MP.Size=UDim2.new(1,-(PC_W+10),1,0)
    MP.Position=UDim2.fromOffset(PC_W+10,0)
    MP.ZIndex=11;MP.ClipsDescendants=true

    local SB=fr(Win,B.S1)
    SB.Size=UDim2.new(1,0,0,24);SB.Position=UDim2.new(0,0,1,-24);SB.ZIndex=11;cr(SB,12)
    local SBfix=fr(SB,B.S1);SBfix.Size=UDim2.new(1,0,.5,0);SBfix.ZIndex=11

    local UL2=lb(SB,"00:00",10,Enum.Font.GothamMedium,B.TD)
    UL2.Size=UDim2.new(0,70,1,0);UL2.Position=UDim2.fromOffset(12,0);UL2.ZIndex=12

    local ST=lb(SB,"Connected",10,Enum.Font.Gotham,B.TD)
    ST.Size=UDim2.new(1,-120,1,0);ST.Position=UDim2.fromOffset(86,0)
    ST.TextXAlignment=Enum.TextXAlignment.Center;ST.ZIndex=12

    local SD=fr(SB,B.CG)
    SD.Size=UDim2.fromOffset(7,7);SD.Position=UDim2.new(1,-16,0.5,-3.5);SD.ZIndex=12;cr(SD,4)

    local FB=fr(Gui,TH.A)
    FB.Size=UDim2.fromOffset(46,46);FB.Position=UDim2.fromOffset(16,16)
    FB.Visible=false;FB.ZIndex=100;cr(FB,23)
    local fbSK=sk(FB,TH.AL,2,.35)
    local FBL=lb(FB,"◈",22,Enum.Font.GothamBold,B.W)
    FBL.Size=UDim2.fromScale(1,1);FBL.TextXAlignment=Enum.TextXAlignment.Center
    FBL.TextYAlignment=Enum.TextYAlignment.Center;FBL.ZIndex=101
    local FBC=bt(FB);FBC.Size=UDim2.fromScale(1,1);FBC.ZIndex=102

    makeDraggable(Win,TB)
    makeDraggable(FB,FB)

    local function hide()
        tw(Win,.22,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
        task.wait(.23);Win.Visible=false;FB.Visible=true
    end
    local function show()
        Win.Visible=true;FB.Visible=false;Win.Size=UDim2.fromOffset(0,0)
        tw(Win,.38,{Size=UDim2.fromOffset(W,H)},Enum.EasingStyle.Back)
    end

    CloseB.MouseButton1Click:Connect(function()
        tw(Win,.2,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
        task.wait(.21);Gui:Destroy()
    end)
    MinB.MouseButton1Click:Connect(function() task.spawn(hide) end)
    FBC.MouseButton1Click:Connect(function() task.spawn(show) end)
    UIS.InputBegan:Connect(function(i,gp)
        if not gp and i.KeyCode==self.MinKey then
            if Win.Visible then task.spawn(hide) else task.spawn(show) end
        end
    end)

    local tc=RunSvc.Heartbeat:Connect(function()
        UL2.Text=fmtT(tick()-self._t0)
    end)

    self._gui   = Gui
    self._win   = Win
    self._MP    = MP
    self._TBF   = TBF
    self._ST    = ST
    self._SD    = SD
    self._NH    = NH
    self._tc    = tc
    self._W, self._H = W, H
    self._refs  = {
        winSK=winSK, TB=TB, TBfix=TBfix, TBline=TBline,
        TL=TL, DL=DL, D1=D1, D2=D2,
        pcSK=pcSK, avSK=avSK, AvW=AvW,
        FB=FB, fbSK=fbSK, UL2=UL2,
    }
end

function OrbsUI:SetTheme(name)
    local TH=TH_MAP[name]; if not TH then return end
    self.TH=TH; self.ThemeName=name
    local r=self._refs
    tw(r.winSK, .25,{Color=lc(TH.A,B.BD,.55)})
    tw(r.TB,    .25,{BackgroundColor3=lc(TH.A,B.BG,.87)})
    tw(r.TBfix, .25,{BackgroundColor3=lc(TH.A,B.BG,.87)})
    tw(r.TBline,.25,{BackgroundColor3=lc(TH.A,B.BD,.62)})
    tw(r.TL,    .25,{TextColor3=TH.AL})
    tw(r.DL,    .25,{TextColor3=lc(TH.A,B.TD,.45)})
    tw(r.D1,    .25,{BackgroundColor3=lc(TH.A,B.BD,.65)})
    tw(r.D2,    .25,{BackgroundColor3=lc(TH.A,B.BD,.65)})
    tw(r.pcSK,  .25,{Color=lc(TH.A,B.BD,.42)})
    tw(r.avSK,  .25,{Color=TH.AL})
    tw(r.AvW,   .25,{BackgroundColor3=lc(TH.A,B.BG,.84)})
    tw(r.FB,    .25,{BackgroundColor3=TH.A})
    tw(r.fbSK,  .25,{Color=TH.AL})
    tw(r.UL2,   .25,{TextColor3=lc(TH.A,B.TD,.55)})
    for _,t in ipairs(self.Tabs) do
        if t._dline then tw(t._dline,.25,{BackgroundColor3=TH.A}) end
        if t==self.ActiveTab then
            tw(t._btn,.25,{BackgroundColor3=lc(TH.A,B.BG,.83)})
            if t._tl then tw(t._tl,.25,{TextColor3=TH.AL}) end
            if t._ic then tw(t._ic,.25,{ImageColor3=TH.AL}) end
            if t._dline then tw(t._dline,.25,{BackgroundTransparency=0}) end
        end
    end
end

function OrbsUI:SetStatus(text,kind)
    self._ST.Text=text or "Ready"
    tw(self._SD,.2,{BackgroundColor3=kind=="error" and B.CR or kind=="warn" and B.CW or B.CG})
end

function OrbsUI:Notify(cfg)
    cfg=cfg or {}
    local title=cfg.Title or "Notification"
    local body=cfg.Content or ""
    local dur=cfg.Duration or 4
    local col=cfg.Color or self.TH.A
    self._nN=self._nN+1

    local NF=fr(self._NH,B.S2)
    NF.Size=UDim2.new(1,0,0,62);NF.Position=UDim2.new(1,8,0,0)
    NF.LayoutOrder=self._nN;NF.ZIndex=901;cr(NF,10);sk(NF,B.BD,1,.38)

    local NB=fr(NF,col);NB.Size=UDim2.fromOffset(3,36);NB.Position=UDim2.fromOffset(10,13);NB.ZIndex=902;cr(NB,2)
    local NT=lb(NF,title,13,Enum.Font.GothamBold,B.TX);NT.Size=UDim2.new(1,-56,0,17);NT.Position=UDim2.fromOffset(19,10);NT.ZIndex=902
    local NC=lb(NF,body,11,Enum.Font.Gotham,B.TS);NC.Size=UDim2.new(1,-56,0,24);NC.Position=UDim2.fromOffset(19,29);NC.TextWrapped=true;NC.TextTruncate=Enum.TextTruncate.AtEnd;NC.ZIndex=902

    local NX=fr(NF,B.S3);NX.Size=UDim2.fromOffset(20,20);NX.Position=UDim2.new(1,-28,0,8);NX.ZIndex=902;cr(NX,6)
    local NXL=lb(NX,"✕",10,Enum.Font.GothamBold,B.TS);NXL.Size=UDim2.fromScale(1,1);NXL.TextXAlignment=Enum.TextXAlignment.Center;NXL.TextYAlignment=Enum.TextYAlignment.Center;NXL.ZIndex=903
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
        tw(t._btn,.15,{BackgroundTransparency=1})
    end
    -- activate new
    tw(td._btn,.15,{BackgroundColor3=lc(TH.A,B.BG,.83),BackgroundTransparency=0})
    if td._tl  then tw(td._tl, .15,{TextColor3=TH.AL}) end
    if td._ic  then tw(td._ic, .15,{ImageColor3=TH.AL}) end
    if td._dline then tw(td._dline,.15,{BackgroundTransparency=0}) end
    -- slide pages
    if prev and prev._sc then
        tw(prev._sc,.16,{Position=UDim2.new(-.08,0,0,0)},Enum.EasingStyle.Quint)
        task.delay(.16,function() prev._sc.Visible=false;prev._sc.Position=UDim2.fromScale(0,0) end)
    end
    td._sc.Position=UDim2.new(.08,0,0,0);td._sc.Visible=true
    tw(td._sc,.2,{Position=UDim2.fromScale(0,0)},Enum.EasingStyle.Quint)
    self.ActiveTab=td
    task.delay(.2,function() self._busy=false end)
end

function OrbsUI:AddTab(cfg)
    cfg=cfg or {}
    local name=cfg.Name or "Tab"
    local icn=cfg.Icon
    local TH=self.TH

    -- Tab button
    local Btn=Instance.new("TextButton")
    Btn.AutomaticSize=Enum.AutomaticSize.X
    Btn.Size=UDim2.new(0,0,1,-4)
    Btn.AnchorPoint=Vector2.new(0,.5)
    Btn.BackgroundColor3=B.S2;Btn.BackgroundTransparency=1
    Btn.Text="";Btn.BorderSizePixel=0;Btn.ZIndex=12
    Btn.Parent=self._TBF;cr(Btn,6)
    pd(Btn,0,0,icn and 10 or 12,12)
    local bhl=hl(Btn,5,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

    local bIc=nil
    if icn then bIc=img(Btn,icn,13,B.TD);bIc.ZIndex=13 end

    local bTl=lb(Btn,name,12,Enum.Font.GothamSemibold,B.TS)
    bTl.AutomaticSize=Enum.AutomaticSize.X;bTl.Size=UDim2.new(0,0,1,0);bTl.ZIndex=13

    -- Active indicator line at bottom
    local dline=fr(Btn,TH.A,1)
    dline.Size=UDim2.new(1,-6,0,2);dline.Position=UDim2.new(0,3,1,-2);dline.ZIndex=14;cr(dline,1)

    -- ScrollingFrame for page content
    local SC=Instance.new("ScrollingFrame")
    SC.BackgroundTransparency=1;SC.BorderSizePixel=0
    SC.Size=UDim2.fromScale(1,1)
    SC.ScrollBarThickness=3;SC.ScrollBarImageColor3=B.BD
    SC.ScrollBarImageTransparency=.35
    SC.CanvasSize=UDim2.new(0,0,0,0);SC.AutomaticCanvasSize=Enum.AutomaticSize.Y
    SC.Visible=false;SC.ZIndex=12;SC.Parent=self._MP
    vl(SC,7);pd(SC,6,12,4,4)

    local td={Name=name,_btn=Btn,_tl=bTl,_ic=bIc,_dline=dline,_sc=SC}
    table.insert(self.Tabs,td)

    Btn.MouseButton1Click:Connect(function() self:_selectTab(td) end)
    Btn.MouseEnter:Connect(function()
        if self.ActiveTab~=td then tw(Btn,.1,{BackgroundTransparency=.8,BackgroundColor3=B.S2}) end
    end)
    Btn.MouseLeave:Connect(function()
        if self.ActiveTab~=td then tw(Btn,.1,{BackgroundTransparency=1}) end
    end)

    -- First tab auto-selected
    if #self.Tabs==1 then
        Btn.BackgroundColor3=lc(TH.A,B.BG,.83);Btn.BackgroundTransparency=0
        bTl.TextColor3=TH.AL;if bIc then bIc.ImageColor3=TH.AL end
        dline.BackgroundTransparency=0;SC.Visible=true;self.ActiveTab=td
    end

    -- Element builder helpers
    local selfRef=self
    local function mkF(h,parent)
        local f=fr(parent or SC,B.S2)
        f.Size=UDim2.new(1,-2,0,h);cr(f,8);sk(f,B.BD,1,.6);return f
    end

    local tabAPI={}

    function tabAPI:AddSection(o)
        o=o or {}
        local secName=o.Name or "Section"
        local TH2=selfRef.TH

        local SF=fr(SC,B.S1)
        SF.Size=UDim2.new(1,-2,0,0);SF.AutomaticSize=Enum.AutomaticSize.Y
        cr(SF,10);sk(SF,B.BD,1,.48)

        local SH=fr(SF,Color3.new(),1);SH.Size=UDim2.new(1,0,0,34)
        pd(SH,0,0,12,12);hl(SH,8,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

        local SBar=fr(SH,TH2.A);SBar.Size=UDim2.fromOffset(3,14);cr(SBar,2)

        local STL=lb(SH,secName,12,Enum.Font.GothamBold,B.TX);STL.Size=UDim2.new(1,-28,1,0)

        local SDv=fr(SF,B.BD,.58);SDv.Size=UDim2.new(1,-22,0,1);SDv.Position=UDim2.fromOffset(11,34)

        local SC2=fr(SF,Color3.new(),1);SC2.Size=UDim2.new(1,-22,0,0)
        SC2.Position=UDim2.fromOffset(11,42);SC2.AutomaticSize=Enum.AutomaticSize.Y;vl(SC2,5)

        local bot=Instance.new("UIPadding");bot.PaddingBottom=UDim.new(0,10);bot.Parent=SF

        local function smkF(h) local f=fr(SC2,B.S2);f.Size=UDim2.new(1,0,0,h);cr(f,7);sk(f,B.BD,1,.62);return f end

        local secAPI={}
        function secAPI:AddToggle(o2)   return _mkToggle(smkF,o2,selfRef.TH) end
        function secAPI:AddSlider(o2)   return _mkSlider(smkF,o2,selfRef.TH) end
        function secAPI:AddButton(o2)   return _mkButton(smkF,o2,selfRef.TH,selfRef._gui) end
        function secAPI:AddInput(o2)    return _mkInput(smkF,o2,selfRef.TH) end
        function secAPI:AddDropdown(o2) return _mkDropdown(SC2,o2,selfRef.TH) end
        function secAPI:AddParagraph(o2)
            o2=o2 or {}
            local PF=fr(SC2,B.S2);PF.Size=UDim2.new(1,0,0,0);PF.AutomaticSize=Enum.AutomaticSize.Y
            cr(PF,7);sk(PF,B.BD,1,.62);pd(PF,10,10,12,12)
            local PTL=lb(PF,o2.Title or "",13,Enum.Font.GothamBold,B.TX)
            PTL.Size=UDim2.new(1,0,0,o2.Title~="" and 18 or 0)
            local PCL=lb(PF,o2.Content or "",11,Enum.Font.Gotham,B.TS)
            PCL.Size=UDim2.new(1,0,0,0);PCL.AutomaticSize=Enum.AutomaticSize.Y
            PCL.Position=UDim2.fromOffset(0,o2.Title~="" and 22 or 0)
            PCL.TextWrapped=true;PCL.TextYAlignment=Enum.TextYAlignment.Top
            local p={};function p:SetTitle(v) PTL.Text=v end;function p:SetContent(v) PCL.Text=v end;return p
        end
        return secAPI
    end

    function tabAPI:AddToggle(o)   return _mkToggle(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddSlider(o)   return _mkSlider(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddButton(o)   return _mkButton(function(h) return mkF(h) end, o, selfRef.TH, selfRef._gui) end
    function tabAPI:AddInput(o)    return _mkInput(function(h) return mkF(h) end, o, selfRef.TH) end
    function tabAPI:AddDropdown(o) return _mkDropdown(SC, o, selfRef.TH) end
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
            {n="Purple",c=Color3.fromRGB(128,82,232)},{n="Red",c=Color3.fromRGB(222,62,62)},
            {n="Cyan",c=Color3.fromRGB(32,182,222)},  {n="Green",c=Color3.fromRGB(42,182,102)},
            {n="Gold",c=Color3.fromRGB(212,162,30)},   {n="Orange",c=Color3.fromRGB(222,112,30)},
            {n="Pink",c=Color3.fromRGB(202,52,162)},   {n="White",c=Color3.fromRGB(202,202,212)},
        }
        local RF=mkF(58)
        local HL=lb(RF,(o.Name or "Theme Color"):upper(),10,Enum.Font.GothamBold,B.TD)
        HL.Size=UDim2.new(1,-20,0,14);HL.Position=UDim2.fromOffset(10,6);HL.LetterSpacing=1
        local SR=fr(RF,Color3.new(),1);SR.Size=UDim2.new(1,-20,0,22);SR.Position=UDim2.fromOffset(10,29)
        hl(SR,7)
        local sw={}
        for i,c in ipairs(cols) do
            local s=Instance.new("TextButton");s.Size=UDim2.fromOffset(20,20);s.BackgroundColor3=c.c
            s.Text="";s.BorderSizePixel=0;s.ZIndex=15;s.Parent=SR;cr(s,5)
            local ss=sk(s,B.W,2,i==1 and .0 or 1.)
            table.insert(sw,{b=s,s=ss})
            s.MouseButton1Click:Connect(function()
                for _,x in ipairs(sw) do x.s.Transparency=1 end
                ss.Transparency=0;cb(c.n,c.c)
            end)
        end
    end
    function tabAPI:AddSeparator()
        local s=fr(SC,B.BD,.62);s.Size=UDim2.new(1,-2,0,1)
    end

    return tabAPI
end

function _mkToggle(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Toggle";local desc=o.Description or ""
    local def=o.Default or false;local icn=o.Icon;local cb=o.Callback or function() end
    local state=def;local H=desc~="" and 54 or 36

    local F=mkF(H)
    if icn then local i=img(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL2=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL2.Size=UDim2.new(1,-(icn and 72 or 54),0,15);TL2.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS);DL.Size=UDim2.new(1,-(icn and 72 or 54),0,13)
        DL.Position=UDim2.fromOffset(icn and 30 or 12,26);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local Tr=fr(F,state and TH.A or B.S4);Tr.Size=UDim2.fromOffset(34,18);Tr.Position=UDim2.new(1,-42,0.5,-9);cr(Tr,9)
    local TrSK=sk(Tr,state and TH.AL or B.BD,1,.5)
    local Kn=fr(Tr,B.W);Kn.Size=UDim2.fromOffset(12,12);Kn.Position=UDim2.fromOffset(state and 19 or 3,3);cr(Kn,6)
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

function _mkSlider(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Slider";local desc=o.Description or ""
    local mn=o.Min or 0;local mx=o.Max or 100;local def=o.Default or mn
    local suf=o.Suffix or "";local rnd=o.Rounding or 1;local icn=o.Icon
    local cb=o.Callback or function() end
    local val=math.clamp(def,mn,mx);local drag2=false;local H=desc~="" and 66 or 50

    local F=mkF(H)
    if icn then local i=img(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,10) end
    local TL2=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL2.Size=UDim2.new(1,-70,0,15);TL2.Position=UDim2.fromOffset(icn and 30 or 12,9)
    local VL=lb(F,tostring(val)..suf,12,Enum.Font.GothamBold,TH.AL)
    VL.Size=UDim2.new(0,52,0,15);VL.Position=UDim2.new(1,-60,0,9);VL.TextXAlignment=Enum.TextXAlignment.Right
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS);DL.Size=UDim2.new(1,-24,0,13)
        DL.Position=UDim2.fromOffset(12,26);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local tY=desc~="" and 44 or 30
    local Tr=fr(F,B.S4);Tr.Size=UDim2.new(1,-22,0,4);Tr.Position=UDim2.fromOffset(11,tY);cr(Tr,3)
    local Fi=fr(Tr,TH.A);Fi.Size=UDim2.new((val-mn)/(mx-mn),0,1,0);cr(Fi,3)
    local Kn=fr(Tr,B.W);Kn.Size=UDim2.fromOffset(13,13);Kn.Position=UDim2.new((val-mn)/(mx-mn),-6,0.5,-6);cr(Kn,7)
    sk(Kn,TH.AL,1.5,.28)

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

function _mkButton(mkF, o, TH, gui)
    o=o or {}
    local name=o.Name or "Button";local desc=o.Description or ""
    local icn=o.Icon;local conf=o.Confirm or false;local cb=o.Callback or function() end
    local H=desc~="" and 54 or 36

    local F=mkF(H)
    if icn then local i=img(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL2=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL2.Size=UDim2.new(1,-(icn and 72 or 52),0,15);TL2.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS);DL.Size=UDim2.new(1,-(icn and 72 or 52),0,13)
        DL.Position=UDim2.fromOffset(icn and 30 or 12,26);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local Ar=fr(F,TH.A,.84);Ar.Size=UDim2.fromOffset(22,22);Ar.Position=UDim2.new(1,-30,0.5,-11);cr(Ar,6)
    local ArL=lb(Ar,"›",17,Enum.Font.GothamBold,TH.AL);ArL.Size=UDim2.fromScale(1,1)
    ArL.TextXAlignment=Enum.TextXAlignment.Center;ArL.TextYAlignment=Enum.TextYAlignment.Center
    local C2=bt(F);C2.Size=UDim2.fromScale(1,1)
    C2.MouseEnter:Connect(function() tw(F,.1,{BackgroundColor3=B.S3});tw(TL2,.1,{TextColor3=TH.AL});tw(Ar,.1,{BackgroundTransparency=.65}) end)
    C2.MouseLeave:Connect(function() tw(F,.1,{BackgroundColor3=B.S2});tw(TL2,.1,{TextColor3=B.TX});tw(Ar,.1,{BackgroundTransparency=.84}) end)

    local function doConf(cb2)
        local OV=fr(gui,Color3.fromRGB(0,0,0),.56);OV.Size=UDim2.fromScale(1,1);OV.ZIndex=500
        local DF=fr(gui,B.S2);DF.Size=UDim2.fromOffset(0,0);DF.Position=UDim2.fromScale(.5,.5)
        DF.AnchorPoint=Vector2.new(.5,.5);DF.ZIndex=501;cr(DF,12);sk(DF,B.BD,1,.3)
        tw(DF,.28,{Size=UDim2.fromOffset(304,120)},Enum.EasingStyle.Back)
        local DT=lb(DF,"Confirm",15,Enum.Font.GothamBold,B.TX);DT.Size=UDim2.new(1,-28,0,20);DT.Position=UDim2.fromOffset(14,12);DT.ZIndex=502
        local DX=lb(DF,"Are you sure you want to run this?",11,Enum.Font.Gotham,B.TS);DX.Size=UDim2.new(1,-28,0,26);DX.Position=UDim2.fromOffset(14,36);DX.TextWrapped=true;DX.ZIndex=502
        local function dB(tx,co,xoff)
            local db=fr(DF,co);db.Size=UDim2.fromOffset(90,26);db.Position=UDim2.new(1,xoff,1,-36);db.ZIndex=502;cr(db,7)
            local dl=lb(db,tx,11,Enum.Font.GothamSemibold,B.W);dl.Size=UDim2.fromScale(1,1)
            dl.TextXAlignment=Enum.TextXAlignment.Center;dl.TextYAlignment=Enum.TextYAlignment.Center;dl.ZIndex=503
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
    local a={};function a:SetText(t) TL2.Text=t end;return a
end

function _mkInput(mkF, o, TH)
    o=o or {}
    local name=o.Name or "Input";local desc=o.Description or ""
    local def=o.Default or "";local ph=o.Placeholder or "Enter value..."
    local num=o.Numeric or false;local fin=o.Finished or false;local icn=o.Icon
    local cb=o.Callback or function() end
    local val=def;local H=desc~="" and 66 or 50

    local F=mkF(H);local FSK=F:FindFirstChildOfClass("UIStroke")
    if icn then local i=img(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,10) end
    local TL2=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL2.Size=UDim2.new(1,-24,0,15);TL2.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 8 or 6)
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS);DL.Size=UDim2.new(1,-24,0,13)
        DL.Position=UDim2.fromOffset(12,24);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local IB=Instance.new("TextBox");IB.BackgroundColor3=B.S3;IB.BackgroundTransparency=0;IB.BorderSizePixel=0
    IB.Size=UDim2.new(1,-22,0,24);IB.Position=UDim2.fromOffset(11,desc~="" and 42 or 24)
    IB.Text=def;IB.PlaceholderText=ph;IB.PlaceholderColor3=B.TD;IB.TextColor3=B.TX
    IB.TextSize=12;IB.Font=Enum.Font.Gotham;IB.TextXAlignment=Enum.TextXAlignment.Left;IB.ZIndex=15;IB.Parent=F
    cr(IB,6);pd(IB,0,0,9,9)
    local ibSK=sk(IB,B.BD,1,.5)
    IB.Focused:Connect(function() tw(ibSK,.12,{Color=TH.A,Transparency=.1});if FSK then tw(FSK,.12,{Color=TH.A,Transparency=.32}) end end)
    IB.FocusLost:Connect(function(e) tw(ibSK,.12,{Color=B.BD,Transparency=.5});if FSK then tw(FSK,.12,{Color=B.BD,Transparency=.6}) end
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

function _mkDropdown(parent, o, TH)
    o=o or {}
    local name=o.Name or "Dropdown";local desc=o.Description or ""
    local items=o.Items or {};local multi=o.Multi or false
    local def=o.Default or(multi and {} or(items[1] or ""))
    local icn=o.Icon;local cb=o.Callback or function() end
    local open=false;local H=desc~="" and 54 or 36
    local sel=multi and {} or def
    if multi and type(def)=="table" then for _,v in pairs(def) do sel[v]=true end end

    local F=fr(parent,B.S2);F.Size=UDim2.new(1,-2,0,H);F.ClipsDescendants=true;cr(F,8)
    local FSK=sk(F,B.BD,1,.6)
    if icn then local i=img(F,icn,14,B.TS);i.Position=UDim2.fromOffset(10,H/2-7) end
    local TL2=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
    TL2.Size=UDim2.new(1,-(icn and 62 or 44),0,15);TL2.Position=UDim2.fromOffset(icn and 30 or 12,desc~="" and 9 or 10)
    local Ar=lb(F,"⌄",13,Enum.Font.GothamBold,B.TS)
    Ar.Size=UDim2.fromOffset(16,15);Ar.Position=UDim2.new(1,-22,0,desc~="" and 9 or 10);Ar.TextXAlignment=Enum.TextXAlignment.Center
    if desc~="" then
        local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS);DL.Size=UDim2.new(1,-44,0,13)
        DL.Position=UDim2.fromOffset(12,25);DL.TextTruncate=Enum.TextTruncate.AtEnd
    end
    local VL=lb(F,"",11,Enum.Font.GothamMedium,TH.AL)
    VL.Size=UDim2.new(1,-44,0,13);VL.Position=UDim2.fromOffset(12,desc~="" and 38 or 22);VL.TextTruncate=Enum.TextTruncate.AtEnd

    local DL2=fr(F,B.S3);DL2.Size=UDim2.new(1,-6,0,0);DL2.Position=UDim2.fromOffset(3,H+3);cr(DL2,7);sk(DL2,B.BD,1,.5)
    local DSc=Instance.new("ScrollingFrame");DSc.BackgroundTransparency=1;DSc.BorderSizePixel=0
    DSc.Size=UDim2.fromScale(1,1);DSc.ScrollBarThickness=2;DSc.ScrollBarImageColor3=B.BD
    DSc.CanvasSize=UDim2.new(0,0,0,0);DSc.AutomaticCanvasSize=Enum.AutomaticSize.Y;DSc.ZIndex=16;DSc.Parent=DL2
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
        tw(FSK,.14,{Color=open and TH.A or B.BD,Transparency=open and .18 or .6})
    end
    DC.MouseButton1Click:Connect(togO)
    local function buildI()
        for _,c in ipairs(DSc:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        for i,v in ipairs(items) do
            local OF=fr(DSc,B.S2,.58);OF.Size=UDim2.new(1,0,0,24);OF.LayoutOrder=i;cr(OF,5)
            local isA=multi and sel[v] or(not multi and sel==v)
            local OL=lb(OF,v,11,Enum.Font.GothamMedium,isA and TH.AL or B.TS)
            OL.Size=UDim2.new(1,-8,1,0);OL.Position=UDim2.fromOffset(7,0);OL.ZIndex=17
            local OB=bt(OF);OB.Size=UDim2.fromScale(1,1);OB.ZIndex=18
            OB.MouseEnter:Connect(function() tw(OF,.07,{BackgroundTransparency=.28}) end)
            OB.MouseLeave:Connect(function() tw(OF,.07,{BackgroundTransparency=.58}) end)
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
