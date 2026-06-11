local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenSvc = game:GetService("TweenService")
local UIS      = game:GetService("UserInputService")
local Players  = game:GetService("Players")
local RunSvc   = game:GetService("RunService")
local LP       = Players.LocalPlayer

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

local TH_MAP = {
	Purple={A=Color3.fromRGB(120,76,220),  AL=Color3.fromRGB(178,144,255), AD=Color3.fromRGB(76,48,160)},
	Red   ={A=Color3.fromRGB(215,58,58),   AL=Color3.fromRGB(255,120,120), AD=Color3.fromRGB(155,34,34)},
	Cyan  ={A=Color3.fromRGB(28,175,215),  AL=Color3.fromRGB(100,218,255), AD=Color3.fromRGB(18,126,165)},
	Green ={A=Color3.fromRGB(38,175,96),   AL=Color3.fromRGB(100,218,152), AD=Color3.fromRGB(22,126,66)},
	Gold  ={A=Color3.fromRGB(205,156,26),  AL=Color3.fromRGB(255,208,78),  AD=Color3.fromRGB(155,114,14)},
	Orange={A=Color3.fromRGB(215,106,26),  AL=Color3.fromRGB(255,158,78),  AD=Color3.fromRGB(155,74,14)},
	Pink  ={A=Color3.fromRGB(195,46,156),  AL=Color3.fromRGB(255,100,208), AD=Color3.fromRGB(145,24,114)},
	White ={A=Color3.fromRGB(195,195,205), AL=Color3.fromRGB(238,238,252), AD=Color3.fromRGB(155,155,168)},
}

local B = {
	BG=Color3.fromRGB(10,10,16),
	S1=Color3.fromRGB(16,16,26),
	S2=Color3.fromRGB(22,22,35),
	S3=Color3.fromRGB(28,28,44),
	S4=Color3.fromRGB(34,34,52),
	BD=Color3.fromRGB(42,42,65),
	TX=Color3.fromRGB(225,218,255),
	TS=Color3.fromRGB(125,114,175),
	TD=Color3.fromRGB(65,58,105),
	W=Color3.fromRGB(255,255,255),
	CG=Color3.fromRGB(38,198,68),
	CR=Color3.fromRGB(228,60,60),
	CW=Color3.fromRGB(235,155,24),
	TDesc=Color3.fromRGB(80,76,98),
}

local MIN_W = 460
local MIN_H = 320
local MAX_W = 860
local MAX_H = 680

local function lc(a,b,t)
	return Color3.new(a.R+(b.R-a.R)*t, a.G+(b.G-a.G)*t, a.B+(b.B-a.B)*t)
end

local function tw(o,t,p,s,d)
	TweenSvc:Create(o,TweenInfo.new(t or .18,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play()
end

local function cr(f,r)
	local c=Instance.new("UICorner")
	c.CornerRadius=UDim.new(0,r or 8)
	c.Parent=f
	return c
end

local function sk(f,col,th,tr)
	local s=Instance.new("UIStroke")
	s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	s.Color=col or B.BD
	s.Thickness=th or 1
	s.Transparency=tr or 0
	s.Parent=f
	return s
end

local function pd(f,t,b,l,r)
	local p=Instance.new("UIPadding")
	p.PaddingTop=UDim.new(0,t or 0)
	p.PaddingBottom=UDim.new(0,b or 0)
	p.PaddingLeft=UDim.new(0,l or 0)
	p.PaddingRight=UDim.new(0,r or 0)
	p.Parent=f
end

local function vl(f,sp)
	local l=Instance.new("UIListLayout")
	l.FillDirection=Enum.FillDirection.Vertical
	l.HorizontalAlignment=Enum.HorizontalAlignment.Left
	l.VerticalAlignment=Enum.VerticalAlignment.Top
	l.Padding=UDim.new(0,sp or 0)
	l.SortOrder=Enum.SortOrder.LayoutOrder
	l.Parent=f
	return l
end

local function hl(f,sp,ha,va)
	local l=Instance.new("UIListLayout")
	l.FillDirection=Enum.FillDirection.Horizontal
	l.HorizontalAlignment=ha or Enum.HorizontalAlignment.Left
	l.VerticalAlignment=va or Enum.VerticalAlignment.Center
	l.Padding=UDim.new(0,sp or 0)
	l.SortOrder=Enum.SortOrder.LayoutOrder
	l.Parent=f
	return l
end

local function frS(p,bg,tr)
	local f=Instance.new("Frame")
	f.BackgroundColor3=bg or B.BG
	f.BackgroundTransparency=tr or 0
	f.BorderSizePixel=0
	f.Parent=p
	return f
end

local function frT(p)
	local f=Instance.new("Frame")
	f.BackgroundTransparency=1
	f.BorderSizePixel=0
	f.Parent=p
	return f
end

local function lb(p,tx,sz,fn,co,xt)
	local l=Instance.new("TextLabel")
	l.BackgroundTransparency=1
	l.Text=tx or ""
	l.TextSize=sz or 13
	l.Font=fn or Enum.Font.GothamMedium
	l.TextColor3=co or B.TX
	l.TextXAlignment=xt or Enum.TextXAlignment.Left
	l.BorderSizePixel=0
	l.Parent=p
	return l
end

local function bt(p)
	local b=Instance.new("TextButton")
	b.BackgroundTransparency=1
	b.Text=""
	b.BorderSizePixel=0
	b.Parent=p
	return b
end

local function ico(p,name,sz,co)
	local i=Instance.new("ImageLabel")
	i.BackgroundTransparency=1
	i.Size=UDim2.fromOffset(sz or 14,sz or 14)
	i.Image=ICO[(name or ""):lower()] or ""
	i.ImageColor3=co or B.TS
	i.ScaleType=Enum.ScaleType.Fit
	i.Parent=p
	return i
end

local function fmtT(s)
	local h=math.floor(s/3600)
	local m=math.floor((s%3600)/60)
	local sc=math.floor(s%60)
	if h>0 then return string.format("%02d:%02d:%02d",h,m,sc) end
	return string.format("%02d:%02d",m,sc)
end

local function makeDrag(win,handle)
	local d,ds,sp=false,nil,nil
	handle.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1
			or i.UserInputType==Enum.UserInputType.Touch then
			d=true
			ds=i.Position
			sp=win.Position
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if d and (i.UserInputType==Enum.UserInputType.MouseMovement
			or i.UserInputType==Enum.UserInputType.Touch) then
			local dv=i.Position-ds
			win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dv.X,sp.Y.Scale,sp.Y.Offset+dv.Y)
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1
			or i.UserInputType==Enum.UserInputType.Touch then
			d=false
		end
	end)
end

local function makeResize(win,handle,onResize)
	local r,rs,rp=false,nil,nil
	handle.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1
			or i.UserInputType==Enum.UserInputType.Touch then
			r=true
			rs=i.Position
			rp=Vector2.new(win.AbsoluteSize.X,win.AbsoluteSize.Y)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if r and (i.UserInputType==Enum.UserInputType.MouseMovement
			or i.UserInputType==Enum.UserInputType.Touch) then
			local dv=i.Position-rs
			local nw=math.clamp(rp.X+dv.X,MIN_W,MAX_W)
			local nh=math.clamp(rp.Y+dv.Y,MIN_H,MAX_H)
			win.Size=UDim2.fromOffset(nw,nh)
			if onResize then onResize(nw,nh) end
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1
			or i.UserInputType==Enum.UserInputType.Touch then
			r=false
		end
	end)
	handle.MouseEnter:Connect(function()
		tw(handle,.12,{BackgroundTransparency=.4})
	end)
	handle.MouseLeave:Connect(function()
		if not r then tw(handle,.12,{BackgroundTransparency=.82}) end
	end)
end

local _Toggle, _Slider, _Button, _Input, _Dropdown

function OrbsUI.new(cfg)
	cfg=cfg or {}
	local self=setmetatable({},OrbsUI)
	self.TH        = TH_MAP[cfg.Theme] or TH_MAP.Purple
	self.ThemeName = cfg.Theme or "Purple"
	self.Title     = cfg.Title or "Orbs"
	self.Desc      = cfg.Description or "v1.3"
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

function OrbsUI:_build()
	local TH=self.TH

	local Gui=Instance.new("ScreenGui")
	Gui.Name="OrbsUI"
	Gui.ResetOnSpawn=false
	Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
	Gui.IgnoreGuiInset=true
	if not pcall(function() Gui.Parent=game:GetService("CoreGui") end) then
		Gui.Parent=LP:WaitForChild("PlayerGui")
	end

	local NH=frT(Gui)
	NH.Size=UDim2.new(0,308,1,0)
	NH.Position=UDim2.new(1,-314,0,0)
	NH.ZIndex=900
	local nhl=vl(NH,6)
	nhl.VerticalAlignment=Enum.VerticalAlignment.Bottom
	nhl.HorizontalAlignment=Enum.HorizontalAlignment.Right
	pd(NH,0,14,0,0)

	local DEF_W  = 620
	local DEF_H  = 440
	local TB_H   = 44
	local TAB_H  = 36
	local SB_H   = 24

	local Win=frT(Gui)
	Win.Size=UDim2.fromOffset(DEF_W,DEF_H)
	Win.Position=UDim2.fromScale(.5,.5)
	Win.AnchorPoint=Vector2.new(.5,.5)
	Win.ZIndex=10
	Win.ClipsDescendants=true
	cr(Win,10)

	local WinBg=frS(Win,B.BG,.18)
	WinBg.Size=UDim2.fromScale(1,1)
	WinBg.ZIndex=10
	cr(WinBg,10)
	local winSK=sk(WinBg,lc(TH.A,B.BD,.5),1.5,.2)

	if self.BgId~="" then
		local BgImg=Instance.new("ImageLabel")
		BgImg.Size=UDim2.fromScale(1,1)
		BgImg.BackgroundTransparency=1
		BgImg.Image=self.BgId
		BgImg.ScaleType=Enum.ScaleType.Crop
		BgImg.ImageTransparency=0.82
		BgImg.ZIndex=10
		BgImg.Parent=WinBg
		cr(BgImg,10)
	end

	local TopBar=frT(Win)
	TopBar.Size=UDim2.new(1,0,0,TB_H)
	TopBar.Position=UDim2.fromOffset(0,0)
	TopBar.ZIndex=20

	local TopBg=frS(TopBar,lc(TH.A,B.S1,.92),.14)
	TopBg.Size=UDim2.fromScale(1,1)
	TopBg.ZIndex=20
	cr(TopBg,10)

	local TopBgFix=frS(TopBar,lc(TH.A,B.S1,.92),.14)
	TopBgFix.Size=UDim2.new(1,0,0,12)
	TopBgFix.Position=UDim2.new(0,0,1,-12)
	TopBgFix.ZIndex=21

	local TopLine=frS(Win,lc(TH.A,B.BD,.55),.35)
	TopLine.Size=UDim2.new(1,0,0,1)
	TopLine.Position=UDim2.fromOffset(0,TB_H)
	TopLine.ZIndex=22

	local DotsF=frT(TopBar)
	DotsF.Size=UDim2.fromOffset(52,12)
	DotsF.Position=UDim2.new(0,14,0.5,-6)
	DotsF.ZIndex=22
	hl(DotsF,6)

	local function wBtn(col)
		local b=Instance.new("TextButton")
		b.Size=UDim2.fromOffset(12,12)
		b.BackgroundColor3=col
		b.Text=""
		b.BorderSizePixel=0
		b.ZIndex=23
		b.Parent=DotsF
		cr(b,6)
		return b
	end

	local CloseB=wBtn(Color3.fromRGB(255,95,87))
	wBtn(Color3.fromRGB(254,188,46))
	wBtn(Color3.fromRGB(40,200,64))

	local TitleRow=frT(TopBar)
	TitleRow.Size=UDim2.new(1,-80,1,0)
	TitleRow.Position=UDim2.new(0,0,0,0)
	TitleRow.ZIndex=22
	hl(TitleRow,0,Enum.HorizontalAlignment.Center,Enum.VerticalAlignment.Center)

	local TitleInner=frT(TitleRow)
	TitleInner.Size=UDim2.new(0,0,1,0)
	TitleInner.AutomaticSize=Enum.AutomaticSize.X
	hl(TitleInner,6,Enum.HorizontalAlignment.Center,Enum.VerticalAlignment.Center)

	local TitleL=lb(TitleInner,self.Title,15,Enum.Font.GothamBold,TH.AL)
	TitleL.Size=UDim2.new(0,0,0,20)
	TitleL.AutomaticSize=Enum.AutomaticSize.X
	TitleL.ZIndex=23

	local DescL=lb(TitleInner,self.Desc,10,Enum.Font.Gotham,B.TDesc)
	DescL.Size=UDim2.new(0,0,0,13)
	DescL.AutomaticSize=Enum.AutomaticSize.X
	DescL.ZIndex=23

	local IconImg=nil
	if self.IconId~="" then
		IconImg=Instance.new("ImageLabel")
		IconImg.BackgroundTransparency=1
		IconImg.Size=UDim2.fromOffset(20,20)
		IconImg.Image=self.IconId
		IconImg.ImageColor3=TH.AL
		IconImg.ScaleType=Enum.ScaleType.Fit
		IconImg.ZIndex=23
		IconImg.Parent=TitleInner
		IconImg.LayoutOrder=0
		TitleL.LayoutOrder=1
		DescL.LayoutOrder=2
	end

	local TabBarY = TB_H + 1

	local TabOuter=frS(Win,B.S1,.08)
	TabOuter.Size=UDim2.new(1,0,0,TAB_H)
	TabOuter.Position=UDim2.fromOffset(0,TabBarY)
	TabOuter.ClipsDescendants=true
	TabOuter.ZIndex=20

	local TBF=frT(TabOuter)
	TBF.Size=UDim2.fromScale(1,1)
	TBF.ZIndex=20
	pd(TBF,0,0,12,12)
	hl(TBF,2,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

	local TabLine=frS(Win,lc(TH.A,B.BD,.55),.35)
	TabLine.Size=UDim2.new(1,0,0,1)
	TabLine.Position=UDim2.fromOffset(0,TabBarY+TAB_H)
	TabLine.ZIndex=22

	local BodyY  = TabBarY + TAB_H + 1
	local BodyH  = DEF_H - BodyY - SB_H

	local Body=frT(Win)
	Body.Size=UDim2.new(1,0,1,-(BodyY+SB_H))
	Body.Position=UDim2.fromOffset(0,BodyY)
	Body.ClipsDescendants=true
	Body.ZIndex=15

	local MP=frT(Body)
	MP.Size=UDim2.fromScale(1,1)
	MP.ClipsDescendants=true
	MP.ZIndex=15

	local SBar=frT(Win)
	SBar.Size=UDim2.new(1,0,0,SB_H)
	SBar.Position=UDim2.new(0,0,1,-SB_H)
	SBar.ZIndex=20

	local SBg=frS(SBar,B.S1,.12)
	SBg.Size=UDim2.fromScale(1,1)
	SBg.ZIndex=20
	cr(SBg,10)

	local SBgFix=frS(SBar,B.S1,.12)
	SBgFix.Size=UDim2.new(1,0,.55,0)
	SBgFix.ZIndex=20

	local STopLine=frS(Win,B.BD,.5)
	STopLine.Size=UDim2.new(1,0,0,1)
	STopLine.Position=UDim2.new(0,0,1,-(SB_H+1))
	STopLine.ZIndex=21

	local SSDot=frS(SBar,B.CG)
	SSDot.Size=UDim2.fromOffset(6,6)
	SSDot.Position=UDim2.new(0,12,0.5,-3)
	SSDot.ZIndex=22
	cr(SSDot,4)

	local UptL=lb(SBar,"00:00",10,Enum.Font.GothamMedium,lc(TH.A,B.TD,.45))
	UptL.Size=UDim2.new(0,60,1,0)
	UptL.Position=UDim2.fromOffset(22,0)
	UptL.ZIndex=22

	local StTxt=lb(SBar,"Connected — Orbs v1.3",10,Enum.Font.Gotham,B.TD)
	StTxt.Size=UDim2.new(1,-200,1,0)
	StTxt.Position=UDim2.fromOffset(90,0)
	StTxt.ZIndex=22

	local RszHandle=frS(Win,B.BD,.82)
	RszHandle.Size=UDim2.fromOffset(14,14)
	RszHandle.Position=UDim2.new(1,-14,1,-14)
	RszHandle.ZIndex=25
	cr(RszHandle,4)

	local RszIcon=lb(RszHandle,"⌟",11,Enum.Font.GothamBold,B.TS,Enum.TextXAlignment.Center)
	RszIcon.Size=UDim2.fromScale(1,1)
	RszIcon.TextYAlignment=Enum.TextYAlignment.Center
	RszIcon.ZIndex=26

	local RszBtn=bt(RszHandle)
	RszBtn.Size=UDim2.fromScale(1,1)
	RszBtn.ZIndex=27

	local FB=frS(Gui,TH.A)
	FB.Size=UDim2.fromOffset(44,44)
	FB.Position=UDim2.fromOffset(16,16)
	FB.Visible=false
	FB.ZIndex=100
	cr(FB,22)
	local fbSK=sk(FB,TH.AL,2,.35)
	local FBL=lb(FB,"◈",20,Enum.Font.GothamBold,B.W,Enum.TextXAlignment.Center)
	FBL.Size=UDim2.fromScale(1,1)
	FBL.TextYAlignment=Enum.TextYAlignment.Center
	FBL.ZIndex=101
	local FBC=bt(FB)
	FBC.Size=UDim2.fromScale(1,1)
	FBC.ZIndex=102

	makeDrag(Win,TopBar)
	makeDrag(FB,FB)

	makeResize(Win,RszBtn,function(nw,nh)
		TopLine.Size=UDim2.new(1,0,0,1)
		TabLine.Size=UDim2.new(1,0,0,1)
	end)

	local function hideWin()
		tw(Win,.2,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
		task.wait(.21)
		Win.Visible=false
		FB.Visible=true
	end

	local function showWin()
		local cs=Win.AbsoluteSize
		local sw=cs.X>10 and cs.X or DEF_W
		local sh=cs.Y>10 and cs.Y or DEF_H
		Win.Visible=true
		FB.Visible=false
		Win.Size=UDim2.fromOffset(0,0)
		tw(Win,.36,{Size=UDim2.fromOffset(sw,sh)},Enum.EasingStyle.Back)
	end

	CloseB.MouseButton1Click:Connect(function()
		tw(Win,.18,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quint)
		task.wait(.2)
		Gui:Destroy()
	end)

	UIS.InputBegan:Connect(function(i,gp)
		if not gp and i.KeyCode==self.MinKey then
			if Win.Visible then task.spawn(hideWin) else task.spawn(showWin) end
		end
	end)

	FBC.MouseButton1Click:Connect(function() task.spawn(showWin) end)

	local tc=RunSvc.Heartbeat:Connect(function()
		UptL.Text=fmtT(tick()-self._t0)
	end)

	self._gui    = Gui
	self._win    = Win
	self._MP     = MP
	self._TBF    = TBF
	self._StTxt  = StTxt
	self._SSDot  = SSDot
	self._NH     = NH
	self._tc     = tc
	self._DEF_W  = DEF_W
	self._DEF_H  = DEF_H
	self._refs   = {
		winSK=winSK, WinBg=WinBg,
		TopBg=TopBg, TopBgFix=TopBgFix,
		TopLine=TopLine, TabLine=TabLine,
		TitleL=TitleL, DescL=DescL, IconImg=IconImg,
		FB=FB, fbSK=fbSK, UptL=UptL,
		RszHandle=RszHandle, RszIcon=RszIcon,
	}
end

function OrbsUI:SetTheme(name)
	local TH=TH_MAP[name]
	if not TH then return end
	self.TH=TH
	self.ThemeName=name
	local r=self._refs
	local topCol=lc(TH.A,B.S1,.92)
	tw(r.winSK,       .25,{Color=lc(TH.A,B.BD,.5)})
	tw(r.TopBg,       .25,{BackgroundColor3=topCol})
	tw(r.TopBgFix,    .25,{BackgroundColor3=topCol})
	tw(r.TopLine,     .25,{BackgroundColor3=lc(TH.A,B.BD,.55)})
	tw(r.TabLine,     .25,{BackgroundColor3=lc(TH.A,B.BD,.55)})
	tw(r.TitleL,      .25,{TextColor3=TH.AL})
	tw(r.FB,          .25,{BackgroundColor3=TH.A})
	tw(r.fbSK,        .25,{Color=TH.AL})
	tw(r.UptL,        .25,{TextColor3=lc(TH.A,B.TD,.45)})
	if r.IconImg then tw(r.IconImg,.25,{ImageColor3=TH.AL}) end
	for _,t in ipairs(self.Tabs) do
		if t._dline then tw(t._dline,.25,{BackgroundColor3=TH.A}) end
		if t==self.ActiveTab then
			tw(t._btn,.25,{BackgroundColor3=lc(TH.A,B.S2,.8)})
			if t._tl   then tw(t._tl,  .25,{TextColor3=TH.AL}) end
			if t._ic   then tw(t._ic,  .25,{ImageColor3=TH.AL}) end
			if t._dline then tw(t._dline,.25,{BackgroundTransparency=0}) end
		end
		if t._acBar then tw(t._acBar,.25,{BackgroundColor3=TH.A}) end
	end
end

function OrbsUI:SetStatus(text,kind)
	self._StTxt.Text=text or "Ready"
	tw(self._SSDot,.2,{BackgroundColor3=kind=="error" and B.CR or kind=="warn" and B.CW or B.CG})
end

function OrbsUI:Notify(cfg)
	cfg=cfg or {}
	local title=cfg.Title or "Notification"
	local body =cfg.Content or ""
	local dur  =cfg.Duration or 4
	local col  =cfg.Color or self.TH.A
	self._nN=self._nN+1

	local NF=frS(self._NH,B.S2)
	NF.BackgroundTransparency=.06
	NF.Size=UDim2.new(1,0,0,60)
	NF.Position=UDim2.new(1,8,0,0)
	NF.LayoutOrder=self._nN
	NF.ZIndex=901
	cr(NF,8)
	sk(NF,B.BD,1,.42)

	local NAccent=frS(NF,col)
	NAccent.Size=UDim2.fromOffset(3,34)
	NAccent.Position=UDim2.fromOffset(10,13)
	NAccent.ZIndex=902
	cr(NAccent,2)

	local NT=lb(NF,title,13,Enum.Font.GothamBold,B.TX)
	NT.Size=UDim2.new(1,-52,0,17)
	NT.Position=UDim2.fromOffset(18,10)
	NT.ZIndex=902

	local NC=lb(NF,body,11,Enum.Font.Gotham,B.TS)
	NC.Size=UDim2.new(1,-52,0,24)
	NC.Position=UDim2.fromOffset(18,28)
	NC.TextWrapped=true
	NC.TextTruncate=Enum.TextTruncate.AtEnd
	NC.ZIndex=902

	local NX=frS(NF,B.S3)
	NX.BackgroundTransparency=.3
	NX.Size=UDim2.fromOffset(18,18)
	NX.Position=UDim2.new(1,-26,0,8)
	NX.ZIndex=902
	cr(NX,6)

	local NXL=lb(NX,"✕",9,Enum.Font.GothamBold,B.TS,Enum.TextXAlignment.Center)
	NXL.Size=UDim2.fromScale(1,1)
	NXL.TextYAlignment=Enum.TextYAlignment.Center
	NXL.ZIndex=903

	local NXB=bt(NX)
	NXB.Size=UDim2.fromScale(1,1)
	NXB.ZIndex=904

	NXB.MouseEnter:Connect(function()
		tw(NX,.1,{BackgroundColor3=B.CR,BackgroundTransparency=0})
		tw(NXL,.1,{TextColor3=B.W})
	end)
	NXB.MouseLeave:Connect(function()
		tw(NX,.1,{BackgroundColor3=B.S3,BackgroundTransparency=.3})
		tw(NXL,.1,{TextColor3=B.TS})
	end)

	tw(NF,.28,{Position=UDim2.new(0,0,0,0)},Enum.EasingStyle.Back)

	local gone=false
	local function dismiss()
		if gone then return end
		gone=true
		tw(NF,.18,{Position=UDim2.new(1,8,0,0),BackgroundTransparency=1})
		task.wait(.2)
		if NF.Parent then NF:Destroy() end
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
	for _,t in ipairs(self.Tabs) do
		if t._tl   then tw(t._tl,  .14,{TextColor3=B.TS}) end
		if t._ic   then tw(t._ic,  .14,{ImageColor3=B.TD}) end
		if t._dline then tw(t._dline,.14,{BackgroundTransparency=1}) end
		tw(t._btn,.14,{BackgroundTransparency=1,BackgroundColor3=B.S2})
	end
	tw(td._btn,.14,{BackgroundColor3=lc(TH.A,B.S2,.8),BackgroundTransparency=.22})
	if td._tl   then tw(td._tl,  .14,{TextColor3=TH.AL}) end
	if td._ic   then tw(td._ic,  .14,{ImageColor3=TH.AL}) end
	if td._dline then tw(td._dline,.14,{BackgroundTransparency=0}) end
	if prev and prev._sc then
		tw(prev._sc,.15,{Position=UDim2.new(-.05,0,0,0)},Enum.EasingStyle.Quint)
		task.delay(.16,function()
			if prev._sc then
				prev._sc.Visible=false
				prev._sc.Position=UDim2.fromScale(0,0)
			end
		end)
	end
	td._sc.Position=UDim2.new(.05,0,0,0)
	td._sc.Visible=true
	tw(td._sc,.18,{Position=UDim2.fromScale(0,0)},Enum.EasingStyle.Quint)
	self.ActiveTab=td
	task.delay(.2,function() self._busy=false end)
end

function OrbsUI:AddTab(cfg)
	cfg=cfg or {}
	local name=cfg.Name or "Tab"
	local icn =cfg.Icon
	local TH  =self.TH

	local Btn=Instance.new("TextButton")
	Btn.AutomaticSize=Enum.AutomaticSize.X
	Btn.Size=UDim2.new(0,0,1,-6)
	Btn.BackgroundColor3=B.S2
	Btn.BackgroundTransparency=1
	Btn.Text=""
	Btn.BorderSizePixel=0
	Btn.ZIndex=22
	Btn.Parent=self._TBF
	cr(Btn,6)
	pd(Btn,0,0,icn and 10 or 12,12)
	hl(Btn,5,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

	local bIc=nil
	if icn then
		bIc=ico(Btn,icn,12,B.TD)
		bIc.ZIndex=23
	end

	local bTl=lb(Btn,name,12,Enum.Font.GothamSemibold,B.TS)
	bTl.AutomaticSize=Enum.AutomaticSize.X
	bTl.Size=UDim2.new(0,0,1,0)
	bTl.ZIndex=23

	local dline=frS(Btn,TH.A)
	dline.BackgroundTransparency=1
	dline.Size=UDim2.new(1,-6,0,2)
	dline.Position=UDim2.new(0,3,1,-2)
	dline.ZIndex=24
	cr(dline,1)

	local SC=Instance.new("ScrollingFrame")
	SC.BackgroundTransparency=1
	SC.BorderSizePixel=0
	SC.Size=UDim2.fromScale(1,1)
	SC.ScrollBarThickness=3
	SC.ScrollBarImageColor3=B.BD
	SC.ScrollBarImageTransparency=.42
	SC.CanvasSize=UDim2.new(0,0,0,0)
	SC.AutomaticCanvasSize=Enum.AutomaticSize.Y
	SC.Visible=false
	SC.ZIndex=16
	SC.Parent=self._MP
	vl(SC,6)
	pd(SC,8,14,8,8)

	local td={Name=name,_btn=Btn,_tl=bTl,_ic=bIc,_dline=dline,_sc=SC,_acBar=nil}
	table.insert(self.Tabs,td)

	Btn.MouseButton1Click:Connect(function() self:_selectTab(td) end)
	Btn.MouseEnter:Connect(function()
		if self.ActiveTab~=td then
			tw(Btn,.1,{BackgroundTransparency=.72,BackgroundColor3=B.S3})
		end
	end)
	Btn.MouseLeave:Connect(function()
		if self.ActiveTab~=td then tw(Btn,.1,{BackgroundTransparency=1}) end
	end)

	if #self.Tabs==1 then
		Btn.BackgroundColor3=lc(TH.A,B.S2,.8)
		Btn.BackgroundTransparency=.22
		bTl.TextColor3=TH.AL
		if bIc then bIc.ImageColor3=TH.AL end
		dline.BackgroundTransparency=0
		SC.Visible=true
		self.ActiveTab=td
	end

	local selfRef=self

	local function mkF(h,parent)
		local f=frS(parent or SC,B.S2,.18)
		f.Size=UDim2.new(1,0,0,h)
		cr(f,7)
		sk(f,B.BD,1,.58)
		return f
	end

	local tabAPI={}

	function tabAPI:AddSection(o)
		o=o or {}
		local secName=o.Name or "Section"

		local SF=frS(SC,B.S1,.1)
		SF.Size=UDim2.new(1,0,0,0)
		SF.AutomaticSize=Enum.AutomaticSize.Y
		cr(SF,8)
		sk(SF,B.BD,1,.52)

		local SH=frT(SF)
		SH.Size=UDim2.new(1,0,0,32)
		pd(SH,0,0,12,12)
		hl(SH,7,Enum.HorizontalAlignment.Left,Enum.VerticalAlignment.Center)

		local SAccent=frS(SH,selfRef.TH.A)
		SAccent.Size=UDim2.fromOffset(3,13)
		cr(SAccent,2)
		td._acBar=SAccent

		local STL=lb(SH,secName,12,Enum.Font.GothamBold,B.TX)
		STL.Size=UDim2.new(1,-26,1,0)

		local SDv=frS(SF,B.BD,.62)
		SDv.Size=UDim2.new(1,-20,0,1)
		SDv.Position=UDim2.fromOffset(10,32)

		local SC2=frT(SF)
		SC2.Size=UDim2.new(1,-16,0,0)
		SC2.Position=UDim2.fromOffset(8,40)
		SC2.AutomaticSize=Enum.AutomaticSize.Y
		vl(SC2,4)

		local bot=Instance.new("UIPadding")
		bot.PaddingBottom=UDim.new(0,8)
		bot.Parent=SF

		local function smk(h2)
			local f=frS(SC2,B.S2,.22)
			f.Size=UDim2.new(1,0,0,h2)
			cr(f,6)
			sk(f,B.BD,1,.62)
			return f
		end

		local secAPI={}
		function secAPI:AddToggle(o2)   return _Toggle(smk,o2,selfRef.TH) end
		function secAPI:AddSlider(o2)   return _Slider(smk,o2,selfRef.TH) end
		function secAPI:AddButton(o2)   return _Button(smk,o2,selfRef.TH,selfRef._gui) end
		function secAPI:AddInput(o2)    return _Input(smk,o2,selfRef.TH) end
		function secAPI:AddDropdown(o2) return _Dropdown(SC2,o2,selfRef.TH) end
		function secAPI:AddParagraph(o2)
			o2=o2 or {}
			local PF=frS(SC2,B.S2,.22)
			PF.Size=UDim2.new(1,0,0,0)
			PF.AutomaticSize=Enum.AutomaticSize.Y
			cr(PF,6)
			sk(PF,B.BD,1,.62)
			pd(PF,9,9,11,11)
			local PT=lb(PF,o2.Title or "",13,Enum.Font.GothamBold,B.TX)
			PT.Size=UDim2.new(1,0,0,o2.Title~="" and 17 or 0)
			local PC2=lb(PF,o2.Content or "",11,Enum.Font.Gotham,B.TS)
			PC2.Size=UDim2.new(1,0,0,0)
			PC2.AutomaticSize=Enum.AutomaticSize.Y
			PC2.Position=UDim2.fromOffset(0,o2.Title~="" and 20 or 0)
			PC2.TextWrapped=true
			PC2.TextYAlignment=Enum.TextYAlignment.Top
			local p={}
			function p:SetTitle(v) PT.Text=v end
			function p:SetContent(v) PC2.Text=v end
			return p
		end
		return secAPI
	end

	function tabAPI:AddToggle(o)   return _Toggle(function(h) return mkF(h) end,o,selfRef.TH) end
	function tabAPI:AddSlider(o)   return _Slider(function(h) return mkF(h) end,o,selfRef.TH) end
	function tabAPI:AddButton(o)   return _Button(function(h) return mkF(h) end,o,selfRef.TH,selfRef._gui) end
	function tabAPI:AddInput(o)    return _Input(function(h) return mkF(h) end,o,selfRef.TH) end
	function tabAPI:AddDropdown(o) return _Dropdown(SC,o,selfRef.TH) end

	function tabAPI:AddColorPicker(o)
		o=o or {}
		local cb=o.Callback or function() end
		local cols={
			{n="Purple",c=Color3.fromRGB(120,76,220)},
			{n="Red",   c=Color3.fromRGB(215,58,58)},
			{n="Cyan",  c=Color3.fromRGB(28,175,215)},
			{n="Green", c=Color3.fromRGB(38,175,96)},
			{n="Gold",  c=Color3.fromRGB(205,156,26)},
			{n="Orange",c=Color3.fromRGB(215,106,26)},
			{n="Pink",  c=Color3.fromRGB(195,46,156)},
			{n="White", c=Color3.fromRGB(195,195,205)},
		}
		local RF=mkF(56)
		local HL=lb(RF,(o.Name or "Color"):upper(),9,Enum.Font.GothamBold,B.TD)
		HL.Size=UDim2.new(1,-18,0,13)
		HL.Position=UDim2.fromOffset(10,6)
		HL.LetterSpacing=1
		local SR=frT(RF)
		SR.Size=UDim2.new(1,-18,0,22)
		SR.Position=UDim2.fromOffset(9,26)
		hl(SR,6)
		local sw={}
		local curTheme=selfRef.ThemeName
		for _,c in ipairs(cols) do
			local s=Instance.new("TextButton")
			s.Size=UDim2.fromOffset(22,22)
			s.BackgroundColor3=c.c
			s.Text=""
			s.BorderSizePixel=0
			s.ZIndex=17
			s.Parent=SR
			cr(s,6)
			local ss=sk(s,B.W,2,c.n==curTheme and 0 or 1)
			table.insert(sw,{b=s,s=ss,n=c.n})
			s.MouseButton1Click:Connect(function()
				for _,x in ipairs(sw) do x.s.Transparency=1 end
				ss.Transparency=0
				cb(c.n,c.c)
			end)
		end
	end

	function tabAPI:AddSeparator()
		local s=frT(SC)
		s.Size=UDim2.new(1,0,0,1)
		local si=frS(s,B.BD,.68)
		si.Size=UDim2.fromScale(1,1)
	end

	return tabAPI
end

_Toggle = function(mkF,o,TH)
	o=o or {}
	local name=o.Name or "Toggle"
	local desc=o.Description or ""
	local def=o.Default or false
	local icn=o.Icon
	local cb=o.Callback or function() end
	local state=def
	local H=desc~="" and 52 or 34

	local F=mkF(H)
	if icn then
		local i=ico(F,icn,13,B.TS)
		i.Position=UDim2.fromOffset(10,H/2-6)
	end
	local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
	TL.Size=UDim2.new(1,-(icn and 68 or 50),0,15)
	TL.Position=UDim2.fromOffset(icn and 28 or 11,desc~="" and 8 or 10)
	if desc~="" then
		local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
		DL.Size=UDim2.new(1,-(icn and 68 or 50),0,13)
		DL.Position=UDim2.fromOffset(icn and 28 or 11,25)
		DL.TextTruncate=Enum.TextTruncate.AtEnd
	end

	local Tr=frS(F,state and TH.A or B.S4)
	Tr.Size=UDim2.fromOffset(32,17)
	Tr.Position=UDim2.new(1,-40,0.5,-8)
	cr(Tr,9)
	local TrSK=sk(Tr,state and TH.AL or B.BD,1,.52)
	local Kn=frS(Tr,B.W)
	Kn.Size=UDim2.fromOffset(11,11)
	Kn.Position=UDim2.fromOffset(state and 18 or 3,3)
	cr(Kn,6)
	local C2=bt(F)
	C2.Size=UDim2.fromScale(1,1)

	local function set(v)
		state=v
		tw(Tr,.16,{BackgroundColor3=v and TH.A or B.S4})
		tw(TrSK,.16,{Color=v and TH.AL or B.BD})
		tw(Kn,.16,{Position=UDim2.fromOffset(v and 18 or 3,3)},Enum.EasingStyle.Back)
		task.spawn(cb,v)
	end

	C2.MouseEnter:Connect(function() tw(F,.08,{BackgroundColor3=B.S3,BackgroundTransparency=.08}) end)
	C2.MouseLeave:Connect(function() tw(F,.08,{BackgroundColor3=B.S2,BackgroundTransparency=.18}) end)
	C2.MouseButton1Click:Connect(function() set(not state) end)
	if state then task.spawn(cb,state) end

	local a={}
	function a:Set(v) set(v) end
	function a:Get() return state end
	return a
end

_Slider = function(mkF,o,TH)
	o=o or {}
	local name=o.Name or "Slider"
	local desc=o.Description or ""
	local mn=o.Min or 0
	local mx=o.Max or 100
	local def=o.Default or mn
	local suf=o.Suffix or ""
	local rnd=o.Rounding or 1
	local icn=o.Icon
	local cb=o.Callback or function() end
	local val=math.clamp(def,mn,mx)
	local drag2=false
	local H=desc~="" and 62 or 48

	local F=mkF(H)
	if icn then
		local i=ico(F,icn,13,B.TS)
		i.Position=UDim2.fromOffset(10,9)
	end
	local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
	TL.Size=UDim2.new(1,-68,0,15)
	TL.Position=UDim2.fromOffset(icn and 28 or 11,8)
	local VL=lb(F,tostring(val)..suf,12,Enum.Font.GothamBold,TH.AL,Enum.TextXAlignment.Right)
	VL.Size=UDim2.new(0,50,0,15)
	VL.Position=UDim2.new(1,-58,0,8)
	if desc~="" then
		local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
		DL.Size=UDim2.new(1,-22,0,13)
		DL.Position=UDim2.fromOffset(11,24)
		DL.TextTruncate=Enum.TextTruncate.AtEnd
	end
	local tY=desc~="" and 42 or 28
	local TrackBg=frS(F,B.S4,.1)
	TrackBg.Size=UDim2.new(1,-20,0,4)
	TrackBg.Position=UDim2.fromOffset(10,tY)
	cr(TrackBg,3)

	local Tr=frS(TrackBg,B.S4)
	Tr.Size=UDim2.fromScale(1,1)
	cr(Tr,3)

	local Fi=frS(Tr,TH.A)
	Fi.Size=UDim2.new((val-mn)/(mx-mn),0,1,0)
	cr(Fi,3)

	local Kn=frS(Tr,B.W)
	Kn.Size=UDim2.fromOffset(13,13)
	Kn.Position=UDim2.new((val-mn)/(mx-mn),-6,0.5,-6)
	cr(Kn,7)
	sk(Kn,TH.AL,1.5,.32)

	local function set(v)
		v=math.clamp(v,mn,mx)
		if rnd>0 then v=math.round(v/rnd)*rnd end
		val=v
		local p=(v-mn)/(mx-mn)
		tw(Fi,.05,{Size=UDim2.new(p,0,1,0)})
		tw(Kn,.05,{Position=UDim2.new(p,-6,0.5,-6)})
		VL.Text=tostring(v)..suf
		task.spawn(cb,v)
	end

	local function gp(x)
		return math.clamp((x-Tr.AbsolutePosition.X)/Tr.AbsoluteSize.X,0,1)
	end

	Tr.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			drag2=true
			tw(Kn,.1,{Size=UDim2.fromOffset(17,17)},Enum.EasingStyle.Back)
			set(mn+(mx-mn)*gp(i.Position.X))
		end
	end)
	Kn.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			drag2=true
			tw(Kn,.1,{Size=UDim2.fromOffset(17,17)},Enum.EasingStyle.Back)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag2 and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			set(mn+(mx-mn)*gp(i.Position.X))
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if drag2 and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
			drag2=false
			tw(Kn,.1,{Size=UDim2.fromOffset(13,13)})
		end
	end)
	set(val)

	local a={}
	function a:Set(v) set(v) end
	function a:Get() return val end
	return a
end

_Button = function(mkF,o,TH,gui)
	o=o or {}
	local name=o.Name or "Button"
	local desc=o.Description or ""
	local icn=o.Icon
	local conf=o.Confirm or false
	local cb=o.Callback or function() end
	local H=desc~="" and 52 or 34

	local F=mkF(H)
	if icn then
		local i=ico(F,icn,13,B.TS)
		i.Position=UDim2.fromOffset(10,H/2-6)
	end
	local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
	TL.Size=UDim2.new(1,-(icn and 68 or 50),0,15)
	TL.Position=UDim2.fromOffset(icn and 28 or 11,desc~="" and 8 or 10)
	if desc~="" then
		local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
		DL.Size=UDim2.new(1,-(icn and 68 or 50),0,13)
		DL.Position=UDim2.fromOffset(icn and 28 or 11,24)
		DL.TextTruncate=Enum.TextTruncate.AtEnd
	end
	local Ar=frS(F,TH.A,.78)
	Ar.Size=UDim2.fromOffset(20,20)
	Ar.Position=UDim2.new(1,-28,0.5,-10)
	cr(Ar,6)
	local ArL=lb(Ar,"›",16,Enum.Font.GothamBold,TH.AL,Enum.TextXAlignment.Center)
	ArL.Size=UDim2.fromScale(1,1)
	ArL.TextYAlignment=Enum.TextYAlignment.Center
	local C2=bt(F)
	C2.Size=UDim2.fromScale(1,1)

	C2.MouseEnter:Connect(function()
		tw(F,.1,{BackgroundColor3=B.S3,BackgroundTransparency=.08})
		tw(TL,.1,{TextColor3=TH.AL})
		tw(Ar,.1,{BackgroundTransparency=.55})
	end)
	C2.MouseLeave:Connect(function()
		tw(F,.1,{BackgroundColor3=B.S2,BackgroundTransparency=.18})
		tw(TL,.1,{TextColor3=B.TX})
		tw(Ar,.1,{BackgroundTransparency=.78})
	end)

	local function doConf(cb2)
		local OV=Instance.new("Frame")
		OV.BackgroundColor3=Color3.new()
		OV.BackgroundTransparency=.52
		OV.Size=UDim2.fromScale(1,1)
		OV.BorderSizePixel=0
		OV.ZIndex=500
		OV.Parent=gui

		local DF=frS(gui,B.S2)
		DF.BackgroundTransparency=.06
		DF.Size=UDim2.fromOffset(0,0)
		DF.Position=UDim2.fromScale(.5,.5)
		DF.AnchorPoint=Vector2.new(.5,.5)
		DF.ZIndex=501
		cr(DF,10)
		sk(DF,B.BD,1,.3)
		tw(DF,.26,{Size=UDim2.fromOffset(296,114)},Enum.EasingStyle.Back)

		local DT=lb(DF,"Confirm",14,Enum.Font.GothamBold,B.TX)
		DT.Size=UDim2.new(1,-24,0,18)
		DT.Position=UDim2.fromOffset(12,12)
		DT.ZIndex=502

		local DX=lb(DF,"Are you sure?",11,Enum.Font.Gotham,B.TS)
		DX.Size=UDim2.new(1,-24,0,24)
		DX.Position=UDim2.fromOffset(12,32)
		DX.TextWrapped=true
		DX.ZIndex=502

		local function dB(tx,co,xoff)
			local db=frS(DF,co)
			db.Size=UDim2.fromOffset(86,24)
			db.Position=UDim2.new(1,xoff,1,-34)
			db.ZIndex=502
			cr(db,6)
			local dl=lb(db,tx,11,Enum.Font.GothamSemibold,B.W,Enum.TextXAlignment.Center)
			dl.Size=UDim2.fromScale(1,1)
			dl.TextYAlignment=Enum.TextYAlignment.Center
			dl.ZIndex=503
			local dbb=bt(db)
			dbb.Size=UDim2.fromScale(1,1)
			dbb.ZIndex=504
			return dbb
		end

		local closed=false
		local function cD()
			if closed then return end
			closed=true
			tw(DF,.14,{Size=UDim2.fromOffset(0,0)})
			task.wait(.15)
			OV:Destroy()
			DF:Destroy()
		end

		dB("Cancel",B.S4,-190).MouseButton1Click:Connect(cD)
		dB("Confirm",TH.A,-96).MouseButton1Click:Connect(function() cD();task.spawn(cb2) end)
		OV.InputBegan:Connect(function(i)
			if i.UserInputType==Enum.UserInputType.MouseButton1 then cD() end
		end)
	end

	C2.MouseButton1Click:Connect(function()
		tw(F,.06,{Size=UDim2.new(1,0,0,H-2)})
		task.wait(.06)
		tw(F,.1,{Size=UDim2.new(1,0,0,H)},Enum.EasingStyle.Back)
		if conf then doConf(cb) else task.spawn(cb) end
	end)

	local a={}
	function a:SetText(t) TL.Text=t end
	return a
end

_Input = function(mkF,o,TH)
	o=o or {}
	local name=o.Name or "Input"
	local desc=o.Description or ""
	local def=o.Default or ""
	local ph=o.Placeholder or "Enter value..."
	local num=o.Numeric or false
	local fin=o.Finished or false
	local icn=o.Icon
	local cb=o.Callback or function() end
	local val=def
	local H=desc~="" and 64 or 48

	local F=mkF(H)
	local FSK=F:FindFirstChildOfClass("UIStroke")
	if icn then
		local i=ico(F,icn,13,B.TS)
		i.Position=UDim2.fromOffset(10,9)
	end
	local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
	TL.Size=UDim2.new(1,-22,0,15)
	TL.Position=UDim2.fromOffset(icn and 28 or 11,desc~="" and 7 or 5)
	if desc~="" then
		local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
		DL.Size=UDim2.new(1,-22,0,13)
		DL.Position=UDim2.fromOffset(11,22)
		DL.TextTruncate=Enum.TextTruncate.AtEnd
	end
	local IB=Instance.new("TextBox")
	IB.BackgroundColor3=B.S3
	IB.BackgroundTransparency=.12
	IB.BorderSizePixel=0
	IB.Size=UDim2.new(1,-18,0,22)
	IB.Position=UDim2.fromOffset(9,desc~="" and 40 or 22)
	IB.Text=def
	IB.PlaceholderText=ph
	IB.PlaceholderColor3=B.TD
	IB.TextColor3=B.TX
	IB.TextSize=11
	IB.Font=Enum.Font.Gotham
	IB.TextXAlignment=Enum.TextXAlignment.Left
	IB.ZIndex=17
	IB.Parent=F
	cr(IB,5)
	pd(IB,0,0,8,8)
	local ibSK=sk(IB,B.BD,1,.52)

	IB.Focused:Connect(function()
		tw(ibSK,.12,{Color=TH.A,Transparency=.12})
		if FSK then tw(FSK,.12,{Color=TH.A,Transparency=.3}) end
	end)
	IB.FocusLost:Connect(function(e)
		tw(ibSK,.12,{Color=B.BD,Transparency=.52})
		if FSK then tw(FSK,.12,{Color=B.BD,Transparency=.58}) end
		if fin and e then val=IB.Text;task.spawn(cb,val) end
	end)
	if not fin then
		IB:GetPropertyChangedSignal("Text"):Connect(function()
			if num then
				local cl=IB.Text:gsub("[^%d%.%-]","")
				if cl~=IB.Text then IB.Text=cl end
			end
			val=IB.Text
			task.spawn(cb,val)
		end)
	end

	local a={}
	function a:Set(v) IB.Text=tostring(v);val=tostring(v) end
	function a:Get() return val end
	return a
end

_Dropdown = function(parent,o,TH)
	o=o or {}
	local name=o.Name or "Dropdown"
	local desc=o.Description or ""
	local items=o.Items or {}
	local multi=o.Multi or false
	local def=o.Default or (multi and {} or (items[1] or ""))
	local icn=o.Icon
	local cb=o.Callback or function() end
	local open=false
	local H=desc~="" and 52 or 34
	local sel=multi and {} or def
	if multi and type(def)=="table" then
		for _,v in pairs(def) do sel[v]=true end
	end

	local F=frS(parent,B.S2,.18)
	F.Size=UDim2.new(1,0,0,H)
	F.ClipsDescendants=true
	cr(F,7)
	local FSK=sk(F,B.BD,1,.58)

	if icn then
		local i=ico(F,icn,13,B.TS)
		i.Position=UDim2.fromOffset(10,H/2-6)
	end

	local TL=lb(F,name,12,Enum.Font.GothamSemibold,B.TX)
	TL.Size=UDim2.new(1,-(icn and 58 or 40),0,15)
	TL.Position=UDim2.fromOffset(icn and 28 or 11,desc~="" and 8 or 10)

	local Ar=lb(F,"⌄",12,Enum.Font.GothamBold,B.TS,Enum.TextXAlignment.Center)
	Ar.Size=UDim2.fromOffset(14,14)
	Ar.Position=UDim2.new(1,-20,0,desc~="" and 8 or 10)

	if desc~="" then
		local DL=lb(F,desc,10,Enum.Font.Gotham,B.TS)
		DL.Size=UDim2.new(1,-40,0,13)
		DL.Position=UDim2.fromOffset(11,24)
		DL.TextTruncate=Enum.TextTruncate.AtEnd
	end

	local VL=lb(F,"",11,Enum.Font.GothamMedium,TH.AL)
	VL.Size=UDim2.new(1,-40,0,12)
	VL.Position=UDim2.fromOffset(11,desc~="" and 37 or 20)
	VL.TextTruncate=Enum.TextTruncate.AtEnd

	local DL2=frS(F,B.S3,.16)
	DL2.Size=UDim2.new(1,-8,0,0)
	DL2.Position=UDim2.fromOffset(4,H+3)
	cr(DL2,6)
	sk(DL2,B.BD,1,.5)

	local DSc=Instance.new("ScrollingFrame")
	DSc.BackgroundTransparency=1
	DSc.BorderSizePixel=0
	DSc.Size=UDim2.fromScale(1,1)
	DSc.ScrollBarThickness=2
	DSc.ScrollBarImageColor3=B.BD
	DSc.CanvasSize=UDim2.new(0,0,0,0)
	DSc.AutomaticCanvasSize=Enum.AutomaticSize.Y
	DSc.ZIndex=18
	DSc.Parent=DL2
	pd(DSc,3,3,4,4)
	vl(DSc,2)

	local DC=bt(F)
	DC.Size=UDim2.new(1,0,0,H)

	local function updL()
		if multi then
			local s={}
			for v,on in pairs(sel) do if on then table.insert(s,v) end end
			VL.Text=#s==0 and "None" or (#s==1 and s[1] or s[1].." +"..#s-1)
		else
			VL.Text=sel~="" and sel or "None"
		end
	end

	local function togO()
		open=not open
		local lh=open and math.min(#items*24+6,120) or 0
		tw(F,.18,{Size=UDim2.new(1,0,0,H+(open and lh+6 or 0))})
		tw(DL2,.18,{Size=UDim2.new(1,-8,0,lh)})
		tw(Ar,.14,{Rotation=open and 180 or 0})
		tw(FSK,.12,{Color=open and TH.A or B.BD,Transparency=open and .16 or .58})
	end

	DC.MouseButton1Click:Connect(togO)

	local function buildI()
		for _,c in ipairs(DSc:GetChildren()) do
			if c:IsA("Frame") then c:Destroy() end
		end
		for i,v in ipairs(items) do
			local OF=frS(DSc,B.S2,.55)
			OF.Size=UDim2.new(1,0,0,22)
			OF.LayoutOrder=i
			cr(OF,5)
			local isA=multi and sel[v] or (not multi and sel==v)
			local OL=lb(OF,v,11,Enum.Font.GothamMedium,isA and TH.AL or B.TS)
			OL.Size=UDim2.new(1,-8,1,0)
			OL.Position=UDim2.fromOffset(7,0)
			OL.ZIndex=19
			local OB=bt(OF)
			OB.Size=UDim2.fromScale(1,1)
			OB.ZIndex=20
			OB.MouseEnter:Connect(function() tw(OF,.06,{BackgroundTransparency=.22}) end)
			OB.MouseLeave:Connect(function() tw(OF,.06,{BackgroundTransparency=.55}) end)
			OB.MouseButton1Click:Connect(function()
				if multi then
					sel[v]=not sel[v]
					tw(OL,.1,{TextColor3=sel[v] and TH.AL or B.TS})
					updL()
					local s={}
					for sv,on in pairs(sel) do if on then table.insert(s,sv) end end
					task.spawn(cb,s)
				else
					sel=v
					for _,c2 in ipairs(DSc:GetChildren()) do
						if c2:IsA("Frame") then
							local l2=c2:FindFirstChildOfClass("TextLabel")
							if l2 then l2.TextColor3=B.TS end
						end
					end
					tw(OL,.1,{TextColor3=TH.AL})
					updL()
					togO()
					task.spawn(cb,v)
				end
			end)
		end
	end

	buildI()
	updL()

	local a={}
	function a:Set(v)
		if multi then
			sel={}
			if type(v)=="table" then for _,sv in pairs(v) do sel[sv]=true end end
		else
			sel=v
		end
		buildI()
		updL()
	end
	function a:SetItems(vals) items=vals;buildI();updL() end
	function a:Get()
		if multi then
			local s={}
			for sv,on in pairs(sel) do if on then table.insert(s,sv) end end
			return s
		end
		return sel
	end
	return a
end

function OrbsUI:Toggle()
	self.Visible=not self.Visible
	self._win.Visible=self.Visible
end

function OrbsUI:Destroy()
	if self._tc then self._tc:Disconnect() end
	self._gui:Destroy()
end

return OrbsUI
