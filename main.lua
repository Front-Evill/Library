local OrbsUI = {}
OrbsUI.__index = OrbsUI

local TweenSvc = game:GetService("TweenService")
local UIS      = game:GetService("UserInputService")
local Players  = game:GetService("Players")
local RunSvc   = game:GetService("RunService")
local LP       = Players.LocalPlayer

local ICO = {
	home="rbxassetid://7733960981",       settings="rbxassetid://7734053495",
	user="rbxassetid://7733974796",       sword="rbxassetid://7734014785",
	eye="rbxassetid://7734053476",        zap="rbxassetid://7734014757",
	shield="rbxassetid://7733942387",     star="rbxassetid://7734053548",
	target="rbxassetid://7734014807",     map="rbxassetid://7733960985",
	lock="rbxassetid://7733960971",       unlock="rbxassetid://7733960987",
	bell="rbxassetid://7733942307",       trash="rbxassetid://7734014815",
	edit="rbxassetid://7733942363",       check="rbxassetid://7733942335",
	close="rbxassetid://7733942347",      plus="rbxassetid://7734014799",
	minus="rbxassetid://7733960983",      arrow_right="rbxassetid://7733942295",
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
	Purple = { A=Color3.fromRGB(120,76,220),  AL=Color3.fromRGB(178,144,255), AD=Color3.fromRGB(76,48,160)  },
	Red    = { A=Color3.fromRGB(215,58,58),   AL=Color3.fromRGB(255,120,120), AD=Color3.fromRGB(155,34,34)  },
	Cyan   = { A=Color3.fromRGB(28,175,215),  AL=Color3.fromRGB(100,218,255), AD=Color3.fromRGB(18,126,165) },
	Green  = { A=Color3.fromRGB(38,175,96),   AL=Color3.fromRGB(100,218,152), AD=Color3.fromRGB(22,126,66)  },
	Gold   = { A=Color3.fromRGB(205,156,26),  AL=Color3.fromRGB(255,208,78),  AD=Color3.fromRGB(155,114,14) },
	Orange = { A=Color3.fromRGB(215,106,26),  AL=Color3.fromRGB(255,158,78),  AD=Color3.fromRGB(155,74,14)  },
	Pink   = { A=Color3.fromRGB(195,46,156),  AL=Color3.fromRGB(255,100,208), AD=Color3.fromRGB(145,24,114) },
	White  = { A=Color3.fromRGB(195,195,205), AL=Color3.fromRGB(238,238,252), AD=Color3.fromRGB(155,155,168)},
}

local B = {
	BG  = Color3.fromRGB(10,10,16),
	S1  = Color3.fromRGB(15,15,24),
	S2  = Color3.fromRGB(20,20,32),
	S3  = Color3.fromRGB(26,26,40),
	S4  = Color3.fromRGB(32,32,50),
	S5  = Color3.fromRGB(38,38,58),
	BD  = Color3.fromRGB(44,44,68),
	TX  = Color3.fromRGB(225,218,255),
	TS  = Color3.fromRGB(120,110,170),
	TD  = Color3.fromRGB(62,56,100),
	W   = Color3.fromRGB(255,255,255),
	CG  = Color3.fromRGB(38,198,68),
	CR  = Color3.fromRGB(228,60,60),
	CW  = Color3.fromRGB(235,155,24),
	DSC = Color3.fromRGB(80,74,98),
}

local WIN_W  = 620
local WIN_H  = 440
local TB_H   = 42
local SB_W   = 110
local SB_H   = 22
local MIN_W  = 480
local MIN_H  = 340
local MAX_W  = 900
local MAX_H  = 700

local function lc(a,b,t)
	return Color3.new(
		a.R + (b.R-a.R)*t,
		a.G + (b.G-a.G)*t,
		a.B + (b.B-a.B)*t
	)
end

local function tw(obj, dur, props, style, dir)
	TweenSvc:Create(
		obj,
		TweenInfo.new(dur or 0.18, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out),
		props
	):Play()
end

local function newCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 8)
	c.Parent = parent
	return c
end

local function newStroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Color = color or B.BD
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.Parent = parent
	return s
end

local function newPadding(parent, top, bottom, left, right)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, top    or 0)
	p.PaddingBottom = UDim.new(0, bottom or 0)
	p.PaddingLeft   = UDim.new(0, left   or 0)
	p.PaddingRight  = UDim.new(0, right  or 0)
	p.Parent = parent
end

local function newVList(parent, spacing)
	local l = Instance.new("UIListLayout")
	l.FillDirection        = Enum.FillDirection.Vertical
	l.HorizontalAlignment  = Enum.HorizontalAlignment.Left
	l.VerticalAlignment    = Enum.VerticalAlignment.Top
	l.Padding              = UDim.new(0, spacing or 0)
	l.SortOrder            = Enum.SortOrder.LayoutOrder
	l.Parent               = parent
	return l
end

local function newHList(parent, spacing, halign, valign)
	local l = Instance.new("UIListLayout")
	l.FillDirection       = Enum.FillDirection.Horizontal
	l.HorizontalAlignment = halign or Enum.HorizontalAlignment.Left
	l.VerticalAlignment   = valign or Enum.VerticalAlignment.Center
	l.Padding             = UDim.new(0, spacing or 0)
	l.SortOrder           = Enum.SortOrder.LayoutOrder
	l.Parent              = parent
	return l
end

local function newFrame(parent, color, transparency)
	local f = Instance.new("Frame")
	f.BackgroundColor3    = color or B.BG
	f.BackgroundTransparency = transparency or 0
	f.BorderSizePixel     = 0
	f.Parent              = parent
	return f
end

local function newTransparentFrame(parent)
	local f = Instance.new("Frame")
	f.BackgroundTransparency = 1
	f.BorderSizePixel        = 0
	f.Parent                 = parent
	return f
end

local function newLabel(parent, text, size, font, color, xalign)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text          = text  or ""
	l.TextSize      = size  or 13
	l.Font          = font  or Enum.Font.GothamMedium
	l.TextColor3    = color or B.TX
	l.TextXAlignment= xalign or Enum.TextXAlignment.Left
	l.BorderSizePixel = 0
	l.Parent        = parent
	return l
end

local function newButton(parent)
	local b = Instance.new("TextButton")
	b.BackgroundTransparency = 1
	b.Text            = ""
	b.BorderSizePixel = 0
	b.Parent          = parent
	return b
end

local function newImage(parent, name, size, color)
	local i = Instance.new("ImageLabel")
	i.BackgroundTransparency = 1
	i.Size       = UDim2.fromOffset(size or 14, size or 14)
	i.Image      = ICO[(name or ""):lower()] or ""
	i.ImageColor3= color or B.TS
	i.ScaleType  = Enum.ScaleType.Fit
	i.Parent     = parent
	return i
end

local function fmtUptime(s)
	local h  = math.floor(s / 3600)
	local m  = math.floor((s % 3600) / 60)
	local sc = math.floor(s % 60)
	if h > 0 then
		return string.format("%02d:%02d:%02d", h, m, sc)
	end
	return string.format("%02d:%02d", m, sc)
end

local function setupDrag(win, handle)
	local dragging, dragStart, startPos = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			dragStart = input.Position
			startPos  = win.Position
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement or
			input.UserInputType == Enum.UserInputType.Touch
		) then
			local delta = input.Position - dragStart
			win.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

local function setupResize(win, handle)
	local resizing, resizeStart, startSize = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			resizing    = true
			resizeStart = input.Position
			startSize   = Vector2.new(win.AbsoluteSize.X, win.AbsoluteSize.Y)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if resizing and (
			input.UserInputType == Enum.UserInputType.MouseMovement or
			input.UserInputType == Enum.UserInputType.Touch
		) then
			local delta = input.Position - resizeStart
			local nw = math.clamp(startSize.X + delta.X, MIN_W, MAX_W)
			local nh = math.clamp(startSize.Y + delta.Y, MIN_H, MAX_H)
			win.Size = UDim2.fromOffset(nw, nh)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			resizing = false
		end
	end)
	handle.MouseEnter:Connect(function()
		tw(handle, 0.1, { BackgroundTransparency = 0.3 })
	end)
	handle.MouseLeave:Connect(function()
		tw(handle, 0.1, { BackgroundTransparency = 0.65 })
	end)
end

local _Toggle, _Slider, _Button, _Input, _Dropdown

function OrbsUI.new(cfg)
	cfg = cfg or {}
	local self = setmetatable({}, OrbsUI)
	self.TH        = TH_MAP[cfg.Theme] or TH_MAP.Purple
	self.ThemeName = cfg.Theme or "Purple"
	self.Title     = cfg.Title or "Orbs"
	self.Desc      = cfg.Description or "v1.3"
	self.IconId    = cfg.Icon or ""
	self.MinKey    = cfg.MinimizeKey or Enum.KeyCode.RightShift
	self.Tabs      = {}
	self.ActiveTab = nil
	self._t0       = tick()
	self._notifN   = 0
	self._busy     = false
	self:_build()
	return self
end

function OrbsUI:_build()
	local TH = self.TH

	local Gui = Instance.new("ScreenGui")
	Gui.Name           = "OrbsUI"
	Gui.ResetOnSpawn   = false
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Gui.IgnoreGuiInset = true
	if not pcall(function() Gui.Parent = game:GetService("CoreGui") end) then
		Gui.Parent = LP:WaitForChild("PlayerGui")
	end

	local NotifHolder = newTransparentFrame(Gui)
	NotifHolder.Size     = UDim2.new(0, 300, 1, 0)
	NotifHolder.Position = UDim2.new(1, -306, 0, 0)
	NotifHolder.ZIndex   = 900
	local nList = newVList(NotifHolder, 6)
	nList.VerticalAlignment  = Enum.VerticalAlignment.Bottom
	nList.HorizontalAlignment= Enum.HorizontalAlignment.Right
	newPadding(NotifHolder, 0, 14, 0, 0)

	local Win = newTransparentFrame(Gui)
	Win.Size            = UDim2.fromOffset(WIN_W, WIN_H)
	Win.Position        = UDim2.fromScale(0.5, 0.5)
	Win.AnchorPoint     = Vector2.new(0.5, 0.5)
	Win.ZIndex          = 10
	Win.ClipsDescendants= true
	newCorner(Win, 10)

	local WinBg = newFrame(Win, B.BG, 0.10)
	WinBg.Size   = UDim2.fromScale(1, 1)
	WinBg.ZIndex = 10
	newCorner(WinBg, 10)
	local winStroke = newStroke(WinBg, lc(TH.A, B.BD, 0.5), 1.5, 0.18)

	local TopBar = newTransparentFrame(Win)
	TopBar.Size     = UDim2.new(1, 0, 0, TB_H)
	TopBar.Position = UDim2.fromOffset(0, 0)
	TopBar.ZIndex   = 20

	local topBgColor = lc(TH.A, B.S1, 0.90)
	local TopBg = newFrame(TopBar, topBgColor, 0.08)
	TopBg.Size   = UDim2.fromScale(1, 1)
	TopBg.ZIndex = 20
	newCorner(TopBg, 10)

	local TopBgFix = newFrame(TopBar, topBgColor, 0.08)
	TopBgFix.Size     = UDim2.new(1, 0, 0, 12)
	TopBgFix.Position = UDim2.new(0, 0, 1, -12)
	TopBgFix.ZIndex   = 21

	local TopDivider = newFrame(Win, lc(TH.A, B.BD, 0.55), 0.32)
	TopDivider.Size     = UDim2.new(1, 0, 0, 1)
	TopDivider.Position = UDim2.fromOffset(0, TB_H)
	TopDivider.ZIndex   = 22

	local DotsRow = newTransparentFrame(TopBar)
	DotsRow.Size     = UDim2.fromOffset(50, 12)
	DotsRow.Position = UDim2.new(0, 13, 0.5, -6)
	DotsRow.ZIndex   = 22
	newHList(DotsRow, 6)

	local function makeTrafficBtn(color)
		local b = Instance.new("TextButton")
		b.Size             = UDim2.fromOffset(12, 12)
		b.BackgroundColor3 = color
		b.Text             = ""
		b.BorderSizePixel  = 0
		b.ZIndex           = 23
		b.Parent           = DotsRow
		newCorner(b, 6)
		return b
	end

	local CloseBtn = makeTrafficBtn(Color3.fromRGB(255, 95, 87))
	makeTrafficBtn(Color3.fromRGB(254, 188, 46))
	makeTrafficBtn(Color3.fromRGB(40, 200, 64))

	local TitleArea = newTransparentFrame(TopBar)
	TitleArea.Size     = UDim2.new(1, -80, 1, 0)
	TitleArea.Position = UDim2.new(0, 0, 0, 0)
	TitleArea.ZIndex   = 22

	local TitleCenter = newTransparentFrame(TitleArea)
	TitleCenter.Size        = UDim2.new(0, 0, 1, 0)
	TitleCenter.AutomaticSize = Enum.AutomaticSize.X
	TitleCenter.Position    = UDim2.fromScale(0.5, 0)
	TitleCenter.AnchorPoint = Vector2.new(0.5, 0)
	newHList(TitleCenter, 7, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

	local IconImg = nil
	if self.IconId ~= "" then
		IconImg = Instance.new("ImageLabel")
		IconImg.BackgroundTransparency = 1
		IconImg.Size         = UDim2.fromOffset(18, 18)
		IconImg.Image        = self.IconId
		IconImg.ImageColor3  = TH.AL
		IconImg.ScaleType    = Enum.ScaleType.Fit
		IconImg.ZIndex       = 23
		IconImg.LayoutOrder  = 0
		IconImg.Parent       = TitleCenter
	end

	local TitleLabel = newLabel(TitleCenter, self.Title, 14, Enum.Font.GothamBold, TH.AL)
	TitleLabel.Size         = UDim2.new(0, 0, 0, 18)
	TitleLabel.AutomaticSize= Enum.AutomaticSize.X
	TitleLabel.ZIndex       = 23
	TitleLabel.LayoutOrder  = 1

	local DescLabel = newLabel(TitleCenter, self.Desc, 10, Enum.Font.Gotham, B.DSC)
	DescLabel.Size         = UDim2.new(0, 0, 0, 13)
	DescLabel.AutomaticSize= Enum.AutomaticSize.X
	DescLabel.ZIndex       = 23
	DescLabel.LayoutOrder  = 2

	local ContentY = TB_H + 1

	local ContentArea = newTransparentFrame(Win)
	ContentArea.Size     = UDim2.new(1, 0, 1, -(ContentY + SB_H + 1))
	ContentArea.Position = UDim2.fromOffset(0, ContentY)
	ContentArea.ZIndex   = 15

	local SideBar = newFrame(ContentArea, B.S1, 0.06)
	SideBar.Size   = UDim2.new(0, SB_W, 1, 0)
	SideBar.ZIndex = 16

	local SideDivider = newFrame(ContentArea, B.BD, 0.55)
	SideDivider.Size     = UDim2.new(0, 1, 1, -8)
	SideDivider.Position = UDim2.fromOffset(SB_W, 4)
	SideDivider.ZIndex   = 17

	local TabList = newTransparentFrame(SideBar)
	TabList.Size   = UDim2.new(1, 0, 1, 0)
	TabList.ZIndex = 17
	newVList(TabList, 2)
	newPadding(TabList, 6, 6, 6, 6)

	local MainPanel = newTransparentFrame(ContentArea)
	MainPanel.Size            = UDim2.new(1, -(SB_W + 2), 1, 0)
	MainPanel.Position        = UDim2.fromOffset(SB_W + 2, 0)
	MainPanel.ClipsDescendants= true
	MainPanel.ZIndex          = 15

	local BottomDivider = newFrame(Win, B.BD, 0.55)
	BottomDivider.Size     = UDim2.new(1, 0, 0, 1)
	BottomDivider.Position = UDim2.new(0, 0, 1, -(SB_H + 1))
	BottomDivider.ZIndex   = 22

	local StatusBar = newTransparentFrame(Win)
	StatusBar.Size     = UDim2.new(1, 0, 0, SB_H)
	StatusBar.Position = UDim2.new(0, 0, 1, -SB_H)
	StatusBar.ZIndex   = 20

	local StatusBg = newFrame(StatusBar, B.S1, 0.08)
	StatusBg.Size   = UDim2.fromScale(1, 1)
	StatusBg.ZIndex = 20
	newCorner(StatusBg, 10)

	local StatusBgFix = newFrame(StatusBar, B.S1, 0.08)
	StatusBgFix.Size   = UDim2.new(1, 0, 0.55, 0)
	StatusBgFix.ZIndex = 20

	local StatusDot = newFrame(StatusBar, B.CG)
	StatusDot.Size     = UDim2.fromOffset(6, 6)
	StatusDot.Position = UDim2.new(0, 11, 0.5, -3)
	StatusDot.ZIndex   = 22
	newCorner(StatusDot, 4)

	local UptimeLabel = newLabel(StatusBar, "00:00", 10, Enum.Font.GothamMedium, lc(TH.A, B.TD, 0.45))
	UptimeLabel.Size     = UDim2.new(0, 56, 1, 0)
	UptimeLabel.Position = UDim2.fromOffset(21, 0)
	UptimeLabel.ZIndex   = 22

	local StatusText = newLabel(StatusBar, "Connected — Orbs v1.3", 10, Enum.Font.Gotham, B.TD)
	StatusText.Size     = UDim2.new(1, -200, 1, 0)
	StatusText.Position = UDim2.fromOffset(84, 0)
	StatusText.ZIndex   = 22

	local RszHandle = newFrame(Win, B.BD, 0.65)
	RszHandle.Size     = UDim2.fromOffset(14, 14)
	RszHandle.Position = UDim2.new(1, -14, 1, -14)
	RszHandle.ZIndex   = 30
	newCorner(RszHandle, 3)

	local RszLabel = newLabel(RszHandle, "⌟", 11, Enum.Font.GothamBold, B.TS, Enum.TextXAlignment.Center)
	RszLabel.Size            = UDim2.fromScale(1, 1)
	RszLabel.TextYAlignment  = Enum.TextYAlignment.Center
	RszLabel.ZIndex          = 31

	local RszBtn = newButton(RszHandle)
	RszBtn.Size   = UDim2.fromScale(1, 1)
	RszBtn.ZIndex = 32

	local FloatBtn = newFrame(Gui, TH.A)
	FloatBtn.Size    = UDim2.fromOffset(42, 42)
	FloatBtn.Position= UDim2.fromOffset(16, 16)
	FloatBtn.Visible = false
	FloatBtn.ZIndex  = 100
	newCorner(FloatBtn, 21)
	local floatStroke = newStroke(FloatBtn, TH.AL, 2, 0.35)
	local FloatLabel  = newLabel(FloatBtn, "◈", 19, Enum.Font.GothamBold, B.W, Enum.TextXAlignment.Center)
	FloatLabel.Size           = UDim2.fromScale(1, 1)
	FloatLabel.TextYAlignment = Enum.TextYAlignment.Center
	FloatLabel.ZIndex         = 101
	local FloatClickBtn = newButton(FloatBtn)
	FloatClickBtn.Size   = UDim2.fromScale(1, 1)
	FloatClickBtn.ZIndex = 102

	setupDrag(Win, TopBar)
	setupDrag(FloatBtn, FloatBtn)
	setupResize(Win, RszBtn)

	local function hideWindow()
		tw(Win, 0.20, { Size = UDim2.fromOffset(0, 0) }, Enum.EasingStyle.Quint)
		task.wait(0.21)
		Win.Visible    = false
		FloatBtn.Visible = true
	end

	local function showWindow()
		local cw = Win.AbsoluteSize.X > 10 and Win.AbsoluteSize.X or WIN_W
		local ch = Win.AbsoluteSize.Y > 10 and Win.AbsoluteSize.Y or WIN_H
		Win.Visible      = true
		FloatBtn.Visible = false
		Win.Size         = UDim2.fromOffset(0, 0)
		tw(Win, 0.34, { Size = UDim2.fromOffset(cw, ch) }, Enum.EasingStyle.Back)
	end

	CloseBtn.MouseButton1Click:Connect(function()
		tw(Win, 0.18, { Size = UDim2.fromOffset(0, 0) }, Enum.EasingStyle.Quint)
		task.wait(0.19)
		Gui:Destroy()
	end)

	UIS.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == self.MinKey then
			if Win.Visible then
				task.spawn(hideWindow)
			else
				task.spawn(showWindow)
			end
		end
	end)

	FloatClickBtn.MouseButton1Click:Connect(function()
		task.spawn(showWindow)
	end)

	local heartbeat = RunSvc.Heartbeat:Connect(function()
		UptimeLabel.Text = fmtUptime(tick() - self._t0)
	end)

	self._gui        = Gui
	self._win        = Win
	self._MainPanel  = MainPanel
	self._TabList    = TabList
	self._StatusText = StatusText
	self._StatusDot  = StatusDot
	self._NotifHolder= NotifHolder
	self._heartbeat  = heartbeat
	self._refs = {
		winStroke   = winStroke,
		WinBg       = WinBg,
		TopBg       = TopBg,
		TopBgFix    = TopBgFix,
		TopDivider  = TopDivider,
		TitleLabel  = TitleLabel,
		IconImg     = IconImg,
		FloatBtn    = FloatBtn,
		floatStroke = floatStroke,
		UptimeLabel = UptimeLabel,
		SideBar     = SideBar,
		RszHandle   = RszHandle,
	}
end

function OrbsUI:SetTheme(name)
	local TH = TH_MAP[name]
	if not TH then return end
	self.TH        = TH
	self.ThemeName = name
	local r        = self._refs
	local topCol   = lc(TH.A, B.S1, 0.90)
	tw(r.winStroke,  0.25, { Color = lc(TH.A, B.BD, 0.5)  })
	tw(r.TopBg,      0.25, { BackgroundColor3 = topCol     })
	tw(r.TopBgFix,   0.25, { BackgroundColor3 = topCol     })
	tw(r.TopDivider, 0.25, { BackgroundColor3 = lc(TH.A, B.BD, 0.55) })
	tw(r.TitleLabel, 0.25, { TextColor3 = TH.AL            })
	tw(r.FloatBtn,   0.25, { BackgroundColor3 = TH.A       })
	tw(r.floatStroke,0.25, { Color = TH.AL                 })
	tw(r.UptimeLabel,0.25, { TextColor3 = lc(TH.A, B.TD, 0.45) })
	if r.IconImg then
		tw(r.IconImg, 0.25, { ImageColor3 = TH.AL })
	end
	for _, t in ipairs(self.Tabs) do
		if t._indicator then
			tw(t._indicator, 0.25, { BackgroundColor3 = TH.A })
		end
		if t._acBar then
			tw(t._acBar, 0.25, { BackgroundColor3 = TH.A })
		end
		if t == self.ActiveTab then
			tw(t._btn, 0.25, { BackgroundColor3 = lc(TH.A, B.S3, 0.78) })
			if t._tl then tw(t._tl, 0.25, { TextColor3 = TH.AL }) end
			if t._ic then tw(t._ic, 0.25, { ImageColor3 = TH.AL }) end
		end
	end
end

function OrbsUI:SetStatus(text, kind)
	self._StatusText.Text = text or "Ready"
	local dotColor = B.CG
	if kind == "error" then dotColor = B.CR
	elseif kind == "warn" then dotColor = B.CW
	end
	tw(self._StatusDot, 0.18, { BackgroundColor3 = dotColor })
end

function OrbsUI:Notify(cfg)
	cfg = cfg or {}
	local title   = cfg.Title    or "Notification"
	local content = cfg.Content  or ""
	local dur     = cfg.Duration or 4
	local color   = cfg.Color    or self.TH.A
	self._notifN  = self._notifN + 1

	local NFrame = newFrame(self._NotifHolder, B.S2, 0.05)
	NFrame.Size        = UDim2.new(1, 0, 0, 58)
	NFrame.Position    = UDim2.new(1, 8, 0, 0)
	NFrame.LayoutOrder = self._notifN
	NFrame.ZIndex      = 901
	newCorner(NFrame, 8)
	newStroke(NFrame, B.BD, 1, 0.42)

	local NAccent = newFrame(NFrame, color)
	NAccent.Size     = UDim2.fromOffset(3, 32)
	NAccent.Position = UDim2.fromOffset(10, 13)
	NAccent.ZIndex   = 902
	newCorner(NAccent, 2)

	local NTitle = newLabel(NFrame, title, 12, Enum.Font.GothamBold, B.TX)
	NTitle.Size     = UDim2.new(1, -52, 0, 16)
	NTitle.Position = UDim2.fromOffset(18, 10)
	NTitle.ZIndex   = 902

	local NBody = newLabel(NFrame, content, 10, Enum.Font.Gotham, B.TS)
	NBody.Size        = UDim2.new(1, -52, 0, 24)
	NBody.Position    = UDim2.fromOffset(18, 27)
	NBody.TextWrapped = true
	NBody.TextTruncate= Enum.TextTruncate.AtEnd
	NBody.ZIndex      = 902

	local NClose = newFrame(NFrame, B.S3, 0.28)
	NClose.Size     = UDim2.fromOffset(18, 18)
	NClose.Position = UDim2.new(1, -26, 0, 8)
	NClose.ZIndex   = 902
	newCorner(NClose, 5)

	local NCloseLabel = newLabel(NClose, "✕", 9, Enum.Font.GothamBold, B.TS, Enum.TextXAlignment.Center)
	NCloseLabel.Size           = UDim2.fromScale(1, 1)
	NCloseLabel.TextYAlignment = Enum.TextYAlignment.Center
	NCloseLabel.ZIndex         = 903

	local NCloseBtn = newButton(NClose)
	NCloseBtn.Size   = UDim2.fromScale(1, 1)
	NCloseBtn.ZIndex = 904

	NCloseBtn.MouseEnter:Connect(function()
		tw(NClose, 0.1, { BackgroundColor3 = B.CR, BackgroundTransparency = 0 })
		tw(NCloseLabel, 0.1, { TextColor3 = B.W })
	end)
	NCloseBtn.MouseLeave:Connect(function()
		tw(NClose, 0.1, { BackgroundColor3 = B.S3, BackgroundTransparency = 0.28 })
		tw(NCloseLabel, 0.1, { TextColor3 = B.TS })
	end)

	tw(NFrame, 0.26, { Position = UDim2.new(0, 0, 0, 0) }, Enum.EasingStyle.Back)

	local dismissed = false
	local function dismiss()
		if dismissed then return end
		dismissed = true
		tw(NFrame, 0.16, { Position = UDim2.new(1, 8, 0, 0), BackgroundTransparency = 1 })
		task.wait(0.18)
		if NFrame and NFrame.Parent then NFrame:Destroy() end
	end

	NCloseBtn.MouseButton1Click:Connect(function() task.spawn(dismiss) end)
	NFrame.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then task.spawn(dismiss) end
	end)
	if dur > 0 then
		task.spawn(function()
			task.wait(dur + 0.26)
			dismiss()
		end)
	end
end

function OrbsUI:_selectTab(target)
	if self._busy or self.ActiveTab == target then return end
	self._busy = true
	local TH   = self.TH
	local prev = self.ActiveTab

	for _, t in ipairs(self.Tabs) do
		tw(t._btn, 0.14, { BackgroundColor3 = B.S2, BackgroundTransparency = 1 })
		if t._tl        then tw(t._tl,        0.14, { TextColor3  = B.TS  }) end
		if t._ic        then tw(t._ic,        0.14, { ImageColor3 = B.TD  }) end
		if t._indicator then tw(t._indicator, 0.14, { BackgroundTransparency = 1 }) end
	end

	tw(target._btn, 0.14, { BackgroundColor3 = lc(TH.A, B.S3, 0.78), BackgroundTransparency = 0.14 })
	if target._tl        then tw(target._tl,        0.14, { TextColor3  = TH.AL }) end
	if target._ic        then tw(target._ic,        0.14, { ImageColor3 = TH.AL }) end
	if target._indicator then tw(target._indicator, 0.14, { BackgroundTransparency = 0 }) end

	if prev and prev._sc then
		tw(prev._sc, 0.15, { Position = UDim2.new(-0.04, 0, 0, 0) }, Enum.EasingStyle.Quint)
		task.delay(0.16, function()
			if prev._sc then
				prev._sc.Visible  = false
				prev._sc.Position = UDim2.fromScale(0, 0)
			end
		end)
	end

	target._sc.Position = UDim2.new(0.04, 0, 0, 0)
	target._sc.Visible  = true
	tw(target._sc, 0.18, { Position = UDim2.fromScale(0, 0) }, Enum.EasingStyle.Quint)

	self.ActiveTab = target
	task.delay(0.19, function() self._busy = false end)
end

function OrbsUI:AddTab(cfg)
	cfg = cfg or {}
	local name = cfg.Name or "Tab"
	local icn  = cfg.Icon
	local TH   = self.TH

	local Btn = Instance.new("TextButton")
	Btn.Size                = UDim2.new(1, 0, 0, 30)
	Btn.BackgroundColor3    = B.S2
	Btn.BackgroundTransparency = 1
	Btn.Text                = ""
	Btn.BorderSizePixel     = 0
	Btn.ZIndex              = 18
	Btn.Parent              = self._TabList
	newCorner(Btn, 6)

	local BtnInner = newTransparentFrame(Btn)
	BtnInner.Size   = UDim2.fromScale(1, 1)
	BtnInner.ZIndex = 19
	newHList(BtnInner, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
	newPadding(BtnInner, 0, 0, 9, 9)

	local bIc = nil
	if icn then
		bIc         = newImage(BtnInner, icn, 12, B.TD)
		bIc.ZIndex  = 20
	end

	local bTl = newLabel(BtnInner, name, 11, Enum.Font.GothamSemibold, B.TS)
	bTl.Size        = UDim2.new(1, -(icn and 20 or 0), 1, 0)
	bTl.ZIndex      = 20
	bTl.AutomaticSize = Enum.AutomaticSize.None
	bTl.TextTruncate  = Enum.TextTruncate.AtEnd

	local Indicator = newFrame(Btn, TH.A, 1)
	Indicator.Size     = UDim2.new(0, 2, 0.6, 0)
	Indicator.Position = UDim2.new(0, 0, 0.2, 0)
	Indicator.ZIndex   = 21
	newCorner(Indicator, 2)
	Indicator.BackgroundTransparency = 1

	local ScrollFrame = Instance.new("ScrollingFrame")
	ScrollFrame.BackgroundTransparency  = 1
	ScrollFrame.BorderSizePixel         = 0
	ScrollFrame.Size                    = UDim2.fromScale(1, 1)
	ScrollFrame.ScrollBarThickness      = 3
	ScrollFrame.ScrollBarImageColor3    = B.BD
	ScrollFrame.ScrollBarImageTransparency = 0.40
	ScrollFrame.CanvasSize              = UDim2.new(0, 0, 0, 0)
	ScrollFrame.AutomaticCanvasSize     = Enum.AutomaticSize.Y
	ScrollFrame.Visible                 = false
	ScrollFrame.ZIndex                  = 16
	ScrollFrame.Parent                  = self._MainPanel
	newVList(ScrollFrame, 6)
	newPadding(ScrollFrame, 8, 14, 8, 8)

	local td = {
		Name       = name,
		_btn       = Btn,
		_tl        = bTl,
		_ic        = bIc,
		_indicator = Indicator,
		_sc        = ScrollFrame,
		_acBar     = nil,
	}
	table.insert(self.Tabs, td)

	Btn.MouseButton1Click:Connect(function() self:_selectTab(td) end)
	Btn.MouseEnter:Connect(function()
		if self.ActiveTab ~= td then
			tw(Btn, 0.1, { BackgroundTransparency = 0.72, BackgroundColor3 = B.S3 })
		end
	end)
	Btn.MouseLeave:Connect(function()
		if self.ActiveTab ~= td then
			tw(Btn, 0.1, { BackgroundTransparency = 1 })
		end
	end)

	if #self.Tabs == 1 then
		Btn.BackgroundColor3         = lc(TH.A, B.S3, 0.78)
		Btn.BackgroundTransparency   = 0.14
		bTl.TextColor3               = TH.AL
		if bIc then bIc.ImageColor3  = TH.AL end
		Indicator.BackgroundTransparency = 0
		ScrollFrame.Visible          = true
		self.ActiveTab               = td
	end

	local selfRef = self

	local function makeElement(height, parentOverride)
		local f = newFrame(parentOverride or ScrollFrame, B.S2, 0.16)
		f.Size = UDim2.new(1, 0, 0, height)
		newCorner(f, 6)
		newStroke(f, B.BD, 1, 0.58)
		return f
	end

	local tabAPI = {}

	function tabAPI:AddSection(o)
		o = o or {}
		local secName = o.Name or "Section"

		local SectionFrame = newFrame(ScrollFrame, B.S1, 0.08)
		SectionFrame.Size            = UDim2.new(1, 0, 0, 0)
		SectionFrame.AutomaticSize   = Enum.AutomaticSize.Y
		newCorner(SectionFrame, 8)
		newStroke(SectionFrame, B.BD, 1, 0.52)

		local SecHeader = newTransparentFrame(SectionFrame)
		SecHeader.Size   = UDim2.new(1, 0, 0, 30)
		newHList(SecHeader, 7, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
		newPadding(SecHeader, 0, 0, 11, 11)

		local SecAccent = newFrame(SecHeader, selfRef.TH.A)
		SecAccent.Size   = UDim2.fromOffset(3, 12)
		SecAccent.ZIndex = 17
		newCorner(SecAccent, 2)
		td._acBar = SecAccent

		local SecTitle = newLabel(SecHeader, secName, 11, Enum.Font.GothamBold, B.TX)
		SecTitle.Size   = UDim2.new(1, -24, 1, 0)
		SecTitle.ZIndex = 17

		local SecDivider = newFrame(SectionFrame, B.BD, 0.62)
		SecDivider.Size     = UDim2.new(1, -18, 0, 1)
		SecDivider.Position = UDim2.fromOffset(9, 30)
		SecDivider.ZIndex   = 17

		local SecContent = newTransparentFrame(SectionFrame)
		SecContent.Size          = UDim2.new(1, -14, 0, 0)
		SecContent.Position      = UDim2.fromOffset(7, 38)
		SecContent.AutomaticSize = Enum.AutomaticSize.Y
		newVList(SecContent, 4)

		local SecPad = Instance.new("UIPadding")
		SecPad.PaddingBottom = UDim.new(0, 8)
		SecPad.Parent        = SectionFrame

		local function secMakeElement(height)
			local f = newFrame(SecContent, B.S2, 0.20)
			f.Size = UDim2.new(1, 0, 0, height)
			newCorner(f, 6)
			newStroke(f, B.BD, 1, 0.60)
			return f
		end

		local secAPI = {}
		function secAPI:AddToggle(o2)   return _Toggle(secMakeElement, o2, selfRef.TH) end
		function secAPI:AddSlider(o2)   return _Slider(secMakeElement, o2, selfRef.TH) end
		function secAPI:AddButton(o2)   return _Button(secMakeElement, o2, selfRef.TH, selfRef._gui) end
		function secAPI:AddInput(o2)    return _Input(secMakeElement, o2, selfRef.TH) end
		function secAPI:AddDropdown(o2) return _Dropdown(SecContent, o2, selfRef.TH) end
		function secAPI:AddParagraph(o2)
			o2 = o2 or {}
			local PF = newFrame(SecContent, B.S2, 0.20)
			PF.Size          = UDim2.new(1, 0, 0, 0)
			PF.AutomaticSize = Enum.AutomaticSize.Y
			newCorner(PF, 6)
			newStroke(PF, B.BD, 1, 0.60)
			newPadding(PF, 9, 9, 10, 10)
			local PT = newLabel(PF, o2.Title or "", 12, Enum.Font.GothamBold, B.TX)
			PT.Size = UDim2.new(1, 0, 0, (o2.Title ~= "" and o2.Title) and 16 or 0)
			local PC = newLabel(PF, o2.Content or "", 10, Enum.Font.Gotham, B.TS)
			PC.Size           = UDim2.new(1, 0, 0, 0)
			PC.AutomaticSize  = Enum.AutomaticSize.Y
			PC.Position       = UDim2.fromOffset(0, (o2.Title ~= "" and o2.Title) and 19 or 0)
			PC.TextWrapped    = true
			PC.TextYAlignment = Enum.TextYAlignment.Top
			local p = {}
			function p:SetTitle(v)   PT.Text = v end
			function p:SetContent(v) PC.Text = v end
			return p
		end
		return secAPI
	end

	function tabAPI:AddToggle(o)   return _Toggle(makeElement, o, selfRef.TH) end
	function tabAPI:AddSlider(o)   return _Slider(makeElement, o, selfRef.TH) end
	function tabAPI:AddButton(o)   return _Button(makeElement, o, selfRef.TH, selfRef._gui) end
	function tabAPI:AddInput(o)    return _Input(makeElement, o, selfRef.TH) end
	function tabAPI:AddDropdown(o) return _Dropdown(ScrollFrame, o, selfRef.TH) end

	function tabAPI:AddColorPicker(o)
		o = o or {}
		local cb = o.Callback or function() end
		local cols = {
			{ n="Purple", c=Color3.fromRGB(120,76,220)  },
			{ n="Red",    c=Color3.fromRGB(215,58,58)   },
			{ n="Cyan",   c=Color3.fromRGB(28,175,215)  },
			{ n="Green",  c=Color3.fromRGB(38,175,96)   },
			{ n="Gold",   c=Color3.fromRGB(205,156,26)  },
			{ n="Orange", c=Color3.fromRGB(215,106,26)  },
			{ n="Pink",   c=Color3.fromRGB(195,46,156)  },
			{ n="White",  c=Color3.fromRGB(195,195,205) },
		}
		local RF = makeElement(54)
		local HeaderLbl = newLabel(RF, (o.Name or "Theme"):upper(), 9, Enum.Font.GothamBold, B.TD)
		HeaderLbl.Size         = UDim2.new(1, -16, 0, 12)
		HeaderLbl.Position     = UDim2.fromOffset(9, 6)
		HeaderLbl.LetterSpacing= 1
		local SwatchRow = newTransparentFrame(RF)
		SwatchRow.Size     = UDim2.new(1, -16, 0, 22)
		SwatchRow.Position = UDim2.fromOffset(8, 24)
		newHList(SwatchRow, 5)
		local swatches = {}
		local curTheme = selfRef.ThemeName
		for _, c in ipairs(cols) do
			local s = Instance.new("TextButton")
			s.Size             = UDim2.fromOffset(22, 22)
			s.BackgroundColor3 = c.c
			s.Text             = ""
			s.BorderSizePixel  = 0
			s.ZIndex           = 17
			s.Parent           = SwatchRow
			newCorner(s, 6)
			local ss = newStroke(s, B.W, 2, c.n == curTheme and 0 or 1)
			table.insert(swatches, { s = ss, n = c.n })
			s.MouseButton1Click:Connect(function()
				for _, x in ipairs(swatches) do x.s.Transparency = 1 end
				ss.Transparency = 0
				cb(c.n, c.c)
			end)
		end
	end

	function tabAPI:AddSeparator()
		local sep = newTransparentFrame(ScrollFrame)
		sep.Size  = UDim2.new(1, 0, 0, 1)
		local line = newFrame(sep, B.BD, 0.65)
		line.Size = UDim2.fromScale(1, 1)
	end

	return tabAPI
end

_Toggle = function(mkElement, o, TH)
	o = o or {}
	local name  = o.Name        or "Toggle"
	local desc  = o.Description or ""
	local def   = o.Default     or false
	local icn   = o.Icon
	local cb    = o.Callback    or function() end
	local state = def
	local H     = desc ~= "" and 50 or 32

	local F = mkElement(H)

	if icn then
		local i = newImage(F, icn, 13, B.TS)
		i.Position = UDim2.fromOffset(10, H / 2 - 6)
	end

	local TL = newLabel(F, name, 12, Enum.Font.GothamSemibold, B.TX)
	TL.Size     = UDim2.new(1, -(icn and 66 or 48), 0, 14)
	TL.Position = UDim2.fromOffset(icn and 28 or 10, desc ~= "" and 8 or 9)

	if desc ~= "" then
		local DL = newLabel(F, desc, 10, Enum.Font.Gotham, B.TS)
		DL.Size         = UDim2.new(1, -(icn and 66 or 48), 0, 12)
		DL.Position     = UDim2.fromOffset(icn and 28 or 10, 24)
		DL.TextTruncate = Enum.TextTruncate.AtEnd
	end

	local Track = newFrame(F, state and TH.A or B.S4)
	Track.Size     = UDim2.fromOffset(30, 16)
	Track.Position = UDim2.new(1, -38, 0.5, -8)
	newCorner(Track, 9)
	local trackStroke = newStroke(Track, state and TH.AL or B.BD, 1, 0.55)

	local Knob = newFrame(Track, B.W)
	Knob.Size     = UDim2.fromOffset(10, 10)
	Knob.Position = UDim2.fromOffset(state and 17 or 3, 3)
	newCorner(Knob, 6)

	local ClickBtn = newButton(F)
	ClickBtn.Size = UDim2.fromScale(1, 1)

	local function set(v)
		state = v
		tw(Track,       0.15, { BackgroundColor3 = v and TH.A or B.S4 })
		tw(trackStroke, 0.15, { Color = v and TH.AL or B.BD })
		tw(Knob,        0.15, { Position = UDim2.fromOffset(v and 17 or 3, 3) }, Enum.EasingStyle.Back)
		task.spawn(cb, v)
	end

	ClickBtn.MouseEnter:Connect(function()
		tw(F, 0.08, { BackgroundColor3 = B.S3, BackgroundTransparency = 0.08 })
	end)
	ClickBtn.MouseLeave:Connect(function()
		tw(F, 0.08, { BackgroundColor3 = B.S2, BackgroundTransparency = 0.16 })
	end)
	ClickBtn.MouseButton1Click:Connect(function() set(not state) end)
	if state then task.spawn(cb, state) end

	local api = {}
	function api:Set(v) set(v) end
	function api:Get() return state end
	return api
end

_Slider = function(mkElement, o, TH)
	o = o or {}
	local name = o.Name        or "Slider"
	local desc = o.Description or ""
	local mn   = o.Min         or 0
	local mx   = o.Max         or 100
	local def  = o.Default     or mn
	local suf  = o.Suffix      or ""
	local rnd  = o.Rounding    or 1
	local icn  = o.Icon
	local cb   = o.Callback    or function() end
	local val  = math.clamp(def, mn, mx)
	local dragging = false
	local H    = desc ~= "" and 60 or 46

	local F = mkElement(H)

	if icn then
		local i = newImage(F, icn, 13, B.TS)
		i.Position = UDim2.fromOffset(10, 8)
	end

	local TL = newLabel(F, name, 12, Enum.Font.GothamSemibold, B.TX)
	TL.Size     = UDim2.new(1, -66, 0, 14)
	TL.Position = UDim2.fromOffset(icn and 28 or 10, 7)

	local VL = newLabel(F, tostring(val) .. suf, 12, Enum.Font.GothamBold, TH.AL, Enum.TextXAlignment.Right)
	VL.Size     = UDim2.new(0, 48, 0, 14)
	VL.Position = UDim2.new(1, -56, 0, 7)

	if desc ~= "" then
		local DL = newLabel(F, desc, 10, Enum.Font.Gotham, B.TS)
		DL.Size         = UDim2.new(1, -20, 0, 12)
		DL.Position     = UDim2.fromOffset(10, 22)
		DL.TextTruncate = Enum.TextTruncate.AtEnd
	end

	local trackY = desc ~= "" and 40 or 28

	local TrackBg = newFrame(F, B.S4, 0.08)
	TrackBg.Size     = UDim2.new(1, -18, 0, 4)
	TrackBg.Position = UDim2.fromOffset(9, trackY)
	newCorner(TrackBg, 3)

	local TrackFill = newFrame(TrackBg, TH.A)
	TrackFill.Size = UDim2.new((val - mn) / (mx - mn), 0, 1, 0)
	newCorner(TrackFill, 3)

	local Knob = newFrame(TrackBg, B.W)
	Knob.Size     = UDim2.fromOffset(13, 13)
	Knob.Position = UDim2.new((val - mn) / (mx - mn), -6, 0.5, -6)
	newCorner(Knob, 7)
	newStroke(Knob, TH.AL, 1.5, 0.30)

	local function set(v)
		v = math.clamp(v, mn, mx)
		if rnd > 0 then v = math.round(v / rnd) * rnd end
		val = v
		local pct = (v - mn) / (mx - mn)
		tw(TrackFill, 0.05, { Size     = UDim2.new(pct, 0, 1, 0) })
		tw(Knob,      0.05, { Position = UDim2.new(pct, -6, 0.5, -6) })
		VL.Text = tostring(v) .. suf
		task.spawn(cb, v)
	end

	local function getPercent(x)
		return math.clamp(
			(x - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X,
			0, 1
		)
	end

	TrackBg.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
			or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			tw(Knob, 0.1, { Size = UDim2.fromOffset(17, 17) }, Enum.EasingStyle.Back)
			set(mn + (mx - mn) * getPercent(i.Position.X))
		end
	end)
	Knob.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
			or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			tw(Knob, 0.1, { Size = UDim2.fromOffset(17, 17) }, Enum.EasingStyle.Back)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging and (
			i.UserInputType == Enum.UserInputType.MouseMovement or
			i.UserInputType == Enum.UserInputType.Touch
		) then
			set(mn + (mx - mn) * getPercent(i.Position.X))
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if dragging and (
			i.UserInputType == Enum.UserInputType.MouseButton1 or
			i.UserInputType == Enum.UserInputType.Touch
		) then
			dragging = false
			tw(Knob, 0.1, { Size = UDim2.fromOffset(13, 13) })
		end
	end)
	set(val)

	local api = {}
	function api:Set(v) set(v) end
	function api:Get() return val end
	return api
end

_Button = function(mkElement, o, TH, gui)
	o = o or {}
	local name = o.Name        or "Button"
	local desc = o.Description or ""
	local icn  = o.Icon
	local conf = o.Confirm     or false
	local cb   = o.Callback    or function() end
	local H    = desc ~= "" and 50 or 32

	local F = mkElement(H)

	if icn then
		local i = newImage(F, icn, 13, B.TS)
		i.Position = UDim2.fromOffset(10, H / 2 - 6)
	end

	local TL = newLabel(F, name, 12, Enum.Font.GothamSemibold, B.TX)
	TL.Size     = UDim2.new(1, -(icn and 66 or 48), 0, 14)
	TL.Position = UDim2.fromOffset(icn and 28 or 10, desc ~= "" and 8 or 9)

	if desc ~= "" then
		local DL = newLabel(F, desc, 10, Enum.Font.Gotham, B.TS)
		DL.Size         = UDim2.new(1, -(icn and 66 or 48), 0, 12)
		DL.Position     = UDim2.fromOffset(icn and 28 or 10, 24)
		DL.TextTruncate = Enum.TextTruncate.AtEnd
	end

	local Arrow = newFrame(F, TH.A, 0.76)
	Arrow.Size     = UDim2.fromOffset(18, 18)
	Arrow.Position = UDim2.new(1, -26, 0.5, -9)
	newCorner(Arrow, 5)
	local ArrowLabel = newLabel(Arrow, "›", 14, Enum.Font.GothamBold, TH.AL, Enum.TextXAlignment.Center)
	ArrowLabel.Size           = UDim2.fromScale(1, 1)
	ArrowLabel.TextYAlignment = Enum.TextYAlignment.Center

	local ClickBtn = newButton(F)
	ClickBtn.Size = UDim2.fromScale(1, 1)

	ClickBtn.MouseEnter:Connect(function()
		tw(F,     0.1, { BackgroundColor3 = B.S3, BackgroundTransparency = 0.08 })
		tw(TL,    0.1, { TextColor3 = TH.AL })
		tw(Arrow, 0.1, { BackgroundTransparency = 0.52 })
	end)
	ClickBtn.MouseLeave:Connect(function()
		tw(F,     0.1, { BackgroundColor3 = B.S2, BackgroundTransparency = 0.16 })
		tw(TL,    0.1, { TextColor3 = B.TX })
		tw(Arrow, 0.1, { BackgroundTransparency = 0.76 })
	end)

	local function doConfirm(callback)
		local Overlay = Instance.new("Frame")
		Overlay.BackgroundColor3    = Color3.new(0, 0, 0)
		Overlay.BackgroundTransparency = 0.52
		Overlay.Size                = UDim2.fromScale(1, 1)
		Overlay.BorderSizePixel     = 0
		Overlay.ZIndex              = 500
		Overlay.Parent              = gui

		local Dialog = newFrame(gui, B.S2, 0.05)
		Dialog.Size        = UDim2.fromOffset(0, 0)
		Dialog.Position    = UDim2.fromScale(0.5, 0.5)
		Dialog.AnchorPoint = Vector2.new(0.5, 0.5)
		Dialog.ZIndex      = 501
		newCorner(Dialog, 9)
		newStroke(Dialog, B.BD, 1, 0.28)
		tw(Dialog, 0.24, { Size = UDim2.fromOffset(284, 108) }, Enum.EasingStyle.Back)

		local DTitle = newLabel(Dialog, "Confirm", 13, Enum.Font.GothamBold, B.TX)
		DTitle.Size     = UDim2.new(1, -22, 0, 17)
		DTitle.Position = UDim2.fromOffset(11, 11)
		DTitle.ZIndex   = 502

		local DBody = newLabel(Dialog, "Are you sure?", 10, Enum.Font.Gotham, B.TS)
		DBody.Size        = UDim2.new(1, -22, 0, 22)
		DBody.Position    = UDim2.fromOffset(11, 30)
		DBody.TextWrapped = true
		DBody.ZIndex      = 502

		local function makeDialogBtn(text, color, xOffset)
			local db = newFrame(Dialog, color)
			db.Size     = UDim2.fromOffset(82, 22)
			db.Position = UDim2.new(1, xOffset, 1, -32)
			db.ZIndex   = 502
			newCorner(db, 5)
			local dl = newLabel(db, text, 10, Enum.Font.GothamSemibold, B.W, Enum.TextXAlignment.Center)
			dl.Size           = UDim2.fromScale(1, 1)
			dl.TextYAlignment = Enum.TextYAlignment.Center
			dl.ZIndex         = 503
			local dBtn = newButton(db)
			dBtn.Size   = UDim2.fromScale(1, 1)
			dBtn.ZIndex = 504
			return dBtn
		end

		local closed = false
		local function closeDialog()
			if closed then return end
			closed = true
			tw(Dialog, 0.13, { Size = UDim2.fromOffset(0, 0) })
			task.wait(0.14)
			if Overlay.Parent then Overlay:Destroy() end
			if Dialog.Parent  then Dialog:Destroy() end
		end

		makeDialogBtn("Cancel",  B.S4, -180).MouseButton1Click:Connect(closeDialog)
		makeDialogBtn("Confirm", TH.A,  -90).MouseButton1Click:Connect(function()
			closeDialog()
			task.spawn(callback)
		end)
		Overlay.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 then closeDialog() end
		end)
	end

	ClickBtn.MouseButton1Click:Connect(function()
		tw(F, 0.05, { Size = UDim2.new(1, 0, 0, H - 2) })
		task.wait(0.05)
		tw(F, 0.1, { Size = UDim2.new(1, 0, 0, H) }, Enum.EasingStyle.Back)
		if conf then doConfirm(cb) else task.spawn(cb) end
	end)

	local api = {}
	function api:SetText(t) TL.Text = t end
	return api
end

_Input = function(mkElement, o, TH)
	o = o or {}
	local name = o.Name        or "Input"
	local desc = o.Description or ""
	local def  = o.Default     or ""
	local ph   = o.Placeholder or "Enter value..."
	local num  = o.Numeric     or false
	local fin  = o.Finished    or false
	local icn  = o.Icon
	local cb   = o.Callback    or function() end
	local val  = def
	local H    = desc ~= "" and 62 or 46

	local F   = mkElement(H)
	local FSK = F:FindFirstChildOfClass("UIStroke")

	if icn then
		local i = newImage(F, icn, 13, B.TS)
		i.Position = UDim2.fromOffset(10, 8)
	end

	local TL = newLabel(F, name, 12, Enum.Font.GothamSemibold, B.TX)
	TL.Size     = UDim2.new(1, -20, 0, 14)
	TL.Position = UDim2.fromOffset(icn and 28 or 10, desc ~= "" and 6 or 5)

	if desc ~= "" then
		local DL = newLabel(F, desc, 10, Enum.Font.Gotham, B.TS)
		DL.Size         = UDim2.new(1, -20, 0, 12)
		DL.Position     = UDim2.fromOffset(10, 20)
		DL.TextTruncate = Enum.TextTruncate.AtEnd
	end

	local IB = Instance.new("TextBox")
	IB.BackgroundColor3    = B.S3
	IB.BackgroundTransparency = 0.10
	IB.BorderSizePixel     = 0
	IB.Size                = UDim2.new(1, -16, 0, 20)
	IB.Position            = UDim2.fromOffset(8, desc ~= "" and 38 or 21)
	IB.Text                = def
	IB.PlaceholderText     = ph
	IB.PlaceholderColor3   = B.TD
	IB.TextColor3          = B.TX
	IB.TextSize            = 11
	IB.Font                = Enum.Font.Gotham
	IB.TextXAlignment      = Enum.TextXAlignment.Left
	IB.ZIndex              = 17
	IB.Parent              = F
	newCorner(IB, 5)
	newPadding(IB, 0, 0, 8, 8)
	local ibStroke = newStroke(IB, B.BD, 1, 0.52)

	IB.Focused:Connect(function()
		tw(ibStroke, 0.12, { Color = TH.A, Transparency = 0.10 })
		if FSK then tw(FSK, 0.12, { Color = TH.A, Transparency = 0.28 }) end
	end)
	IB.FocusLost:Connect(function(enterPressed)
		tw(ibStroke, 0.12, { Color = B.BD, Transparency = 0.52 })
		if FSK then tw(FSK, 0.12, { Color = B.BD, Transparency = 0.58 }) end
		if fin and enterPressed then
			val = IB.Text
			task.spawn(cb, val)
		end
	end)
	if not fin then
		IB:GetPropertyChangedSignal("Text"):Connect(function()
			if num then
				local cleaned = IB.Text:gsub("[^%d%.%-]", "")
				if cleaned ~= IB.Text then IB.Text = cleaned end
			end
			val = IB.Text
			task.spawn(cb, val)
		end)
	end

	local api = {}
	function api:Set(v) IB.Text = tostring(v); val = tostring(v) end
	function api:Get() return val end
	return api
end

_Dropdown = function(parent, o, TH)
	o = o or {}
	local name  = o.Name        or "Dropdown"
	local desc  = o.Description or ""
	local items = o.Items       or {}
	local multi = o.Multi       or false
	local def   = o.Default     or (multi and {} or (items[1] or ""))
	local icn   = o.Icon
	local cb    = o.Callback    or function() end
	local open  = false
	local H     = desc ~= "" and 50 or 32
	local sel   = multi and {} or def

	if multi and type(def) == "table" then
		for _, v in pairs(def) do sel[v] = true end
	end

	local F = newFrame(parent, B.S2, 0.16)
	F.Size             = UDim2.new(1, 0, 0, H)
	F.ClipsDescendants = true
	newCorner(F, 6)
	local FSK = newStroke(F, B.BD, 1, 0.58)

	if icn then
		local i = newImage(F, icn, 13, B.TS)
		i.Position = UDim2.fromOffset(10, H / 2 - 6)
	end

	local TL = newLabel(F, name, 12, Enum.Font.GothamSemibold, B.TX)
	TL.Size     = UDim2.new(1, -(icn and 56 or 38), 0, 14)
	TL.Position = UDim2.fromOffset(icn and 28 or 10, desc ~= "" and 7 or 9)

	local Arrow = newLabel(F, "⌄", 11, Enum.Font.GothamBold, B.TS, Enum.TextXAlignment.Center)
	Arrow.Size     = UDim2.fromOffset(13, 13)
	Arrow.Position = UDim2.new(1, -18, 0, desc ~= "" and 7 or 9)

	if desc ~= "" then
		local DL = newLabel(F, desc, 10, Enum.Font.Gotham, B.TS)
		DL.Size         = UDim2.new(1, -38, 0, 12)
		DL.Position     = UDim2.fromOffset(10, 22)
		DL.TextTruncate = Enum.TextTruncate.AtEnd
	end

	local ValLabel = newLabel(F, "", 10, Enum.Font.GothamMedium, TH.AL)
	ValLabel.Size         = UDim2.new(1, -38, 0, 12)
	ValLabel.Position     = UDim2.fromOffset(10, desc ~= "" and 35 or 19)
	ValLabel.TextTruncate = Enum.TextTruncate.AtEnd

	local DropList = newFrame(F, B.S3, 0.14)
	DropList.Size     = UDim2.new(1, -8, 0, 0)
	DropList.Position = UDim2.fromOffset(4, H + 3)
	newCorner(DropList, 6)
	newStroke(DropList, B.BD, 1, 0.50)

	local DropScroll = Instance.new("ScrollingFrame")
	DropScroll.BackgroundTransparency    = 1
	DropScroll.BorderSizePixel           = 0
	DropScroll.Size                      = UDim2.fromScale(1, 1)
	DropScroll.ScrollBarThickness        = 2
	DropScroll.ScrollBarImageColor3      = B.BD
	DropScroll.CanvasSize                = UDim2.new(0, 0, 0, 0)
	DropScroll.AutomaticCanvasSize       = Enum.AutomaticSize.Y
	DropScroll.ZIndex                    = 18
	DropScroll.Parent                    = DropList
	newPadding(DropScroll, 3, 3, 4, 4)
	newVList(DropScroll, 2)

	local DropClickBtn = newButton(F)
	DropClickBtn.Size = UDim2.new(1, 0, 0, H)

	local function updateLabel()
		if multi then
			local selected = {}
			for v, on in pairs(sel) do
				if on then table.insert(selected, v) end
			end
			if #selected == 0 then
				ValLabel.Text = "None"
			elseif #selected == 1 then
				ValLabel.Text = selected[1]
			else
				ValLabel.Text = selected[1] .. " +" .. (#selected - 1)
			end
		else
			ValLabel.Text = (sel ~= "") and sel or "None"
		end
	end

	local function toggleOpen()
		open = not open
		local listH = open and math.min(#items * 22 + 6, 116) or 0
		tw(F,        0.18, { Size = UDim2.new(1, 0, 0, H + (open and listH + 5 or 0)) })
		tw(DropList, 0.18, { Size = UDim2.new(1, -8, 0, listH) })
		tw(Arrow,    0.14, { Rotation = open and 180 or 0 })
		tw(FSK,      0.12, {
			Color        = open and TH.A or B.BD,
			Transparency = open and 0.14 or 0.58
		})
	end

	DropClickBtn.MouseButton1Click:Connect(toggleOpen)

	local function buildItems()
		for _, c in ipairs(DropScroll:GetChildren()) do
			if c:IsA("Frame") then c:Destroy() end
		end
		for idx, v in ipairs(items) do
			local Item = newFrame(DropScroll, B.S2, 0.52)
			Item.Size        = UDim2.new(1, 0, 0, 20)
			Item.LayoutOrder = idx
			newCorner(Item, 4)

			local isSelected = multi and sel[v] or (not multi and sel == v)
			local ItemLabel  = newLabel(Item, v, 10, Enum.Font.GothamMedium, isSelected and TH.AL or B.TS)
			ItemLabel.Size     = UDim2.new(1, -8, 1, 0)
			ItemLabel.Position = UDim2.fromOffset(7, 0)
			ItemLabel.ZIndex   = 19

			local ItemBtn = newButton(Item)
			ItemBtn.Size   = UDim2.fromScale(1, 1)
			ItemBtn.ZIndex = 20

			ItemBtn.MouseEnter:Connect(function()
				tw(Item, 0.06, { BackgroundTransparency = 0.20 })
			end)
			ItemBtn.MouseLeave:Connect(function()
				tw(Item, 0.06, { BackgroundTransparency = 0.52 })
			end)
			ItemBtn.MouseButton1Click:Connect(function()
				if multi then
					sel[v] = not sel[v]
					tw(ItemLabel, 0.1, { TextColor3 = sel[v] and TH.AL or B.TS })
					updateLabel()
					local result = {}
					for sv, on in pairs(sel) do
						if on then table.insert(result, sv) end
					end
					task.spawn(cb, result)
				else
					sel = v
					for _, child in ipairs(DropScroll:GetChildren()) do
						if child:IsA("Frame") then
							local lbl = child:FindFirstChildOfClass("TextLabel")
							if lbl then lbl.TextColor3 = B.TS end
						end
					end
					tw(ItemLabel, 0.1, { TextColor3 = TH.AL })
					updateLabel()
					toggleOpen()
					task.spawn(cb, v)
				end
			end)
		end
	end

	buildItems()
	updateLabel()

	local api = {}
	function api:Set(v)
		if multi then
			sel = {}
			if type(v) == "table" then
				for _, sv in pairs(v) do sel[sv] = true end
			end
		else
			sel = v
		end
		buildItems()
		updateLabel()
	end
	function api:SetItems(newItems)
		items = newItems
		buildItems()
		updateLabel()
	end
	function api:Get()
		if multi then
			local result = {}
			for sv, on in pairs(sel) do
				if on then table.insert(result, sv) end
			end
			return result
		end
		return sel
	end
	return api
end

function OrbsUI:Toggle()
	self.Visible     = not self.Visible
	self._win.Visible= self.Visible
end

function OrbsUI:Destroy()
	if self._heartbeat then self._heartbeat:Disconnect() end
	self._gui:Destroy()
end

return OrbsUI
