local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local LP               = Players.LocalPlayer

local VantaUI = {}

local function Shade(c, dV, dS)
	local h, s, v = c:ToHSV()
	s = math.clamp(s + (dS or 0), 0, 1)
	v = math.clamp(v + (dV or 0), 0, 1)
	return Color3.fromHSV(h, s, v)
end

local function ScaleColor(c, m)
	return Color3.new(math.clamp(c.R * m, 0, 1), math.clamp(c.G * m, 0, 1), math.clamp(c.B * m, 0, 1))
end

local COL_TEXT  = Color3.fromRGB(188, 188, 192)
local COL_WHITE = Color3.fromRGB(255, 255, 255)
local COL_ITEM  = Color3.fromRGB(178, 178, 182)

local TI_FAST  = TweenInfo.new(0.14, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out)
local TI_MED   = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TI_SLIDE = TweenInfo.new(0.20, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function tw(obj, info, props)
	TweenService:Create(obj, info, props):Play()
end

local function makeDraggable(area, onDrag)
	local dragging = false

	local hit = Instance.new("TextButton", area)
	hit.Size               = UDim2.new(1, 0, 1, 0)
	hit.BackgroundTransparency = 1
	hit.Text               = ""
	hit.ZIndex             = area.ZIndex + 5

	local function update(x, y)
		local relX = math.clamp((x - area.AbsolutePosition.X) / area.AbsoluteSize.X, 0, 1)
		local relY = math.clamp((y - area.AbsolutePosition.Y) / area.AbsoluteSize.Y, 0, 1)
		onDrag(relX, relY)
	end

	hit.MouseButton1Down:Connect(function()
		dragging = true
		local loc = UserInputService:GetMouseLocation()
		update(loc.X, loc.Y)
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if not dragging then return end
		if i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch then
			update(i.Position.X, i.Position.Y)
		end
	end)

	return hit
end

function VantaUI.CreateWindow(config)
	config = config or {}

	local WINDOW_TITLE = config.Title            or "UI LIBRARY"
	local WINDOW_SIZE   = config.Size             or UDim2.new(0, 308, 0, 490)
	local WINDOW_POS     = config.Position         or UDim2.new(0, 50, 0, 50)
	local TAB_NAMES       = config.Tabs             or { "Tab 1", "Tab 2", "Tab 3" }
	local TOGGLE_KEY       = config.ToggleKey        or Enum.KeyCode.F
	local ICON_ID           = config.Icon             or "rbxassetid://99530762681306"
	local BG_IMAGE           = config.BackgroundImage or "rbxassetid://111823734811187"

	local ACCENT_FULL, ACCENT_GLOW, ACCENT_TOPGLOW, ACCENT_LABEL, ACCENT_MID, ACCENT_LINE, ACCENT_VOID
	local BG_BASE, BG_DEEP, BG_MID, BG_ELEM, TAB_OFF

	local Repainters = {}

	local function applyAccent(color)
		ACCENT_FULL    = color
		ACCENT_GLOW    = Shade(ACCENT_FULL,  0.06, -0.07)
		ACCENT_TOPGLOW = Shade(ACCENT_FULL,  0.19, -0.06)
		ACCENT_LABEL   = Shade(ACCENT_FULL, -0.18, -0.03)
		ACCENT_MID     = Shade(ACCENT_FULL, -0.35,  0.03)
		ACCENT_LINE    = Shade(ACCENT_FULL, -0.55,  0.00)
		ACCENT_VOID    = Shade(ACCENT_FULL, -0.72, -0.28)
	end

	local function applyBackground(color)
		BG_BASE = color
		BG_DEEP = ScaleColor(BG_BASE, 0.65)
		BG_MID  = BG_BASE
		BG_ELEM = ScaleColor(BG_BASE, 1.4)
		TAB_OFF = ScaleColor(BG_BASE, 0.95)
	end

	applyAccent(config.AccentColor or Color3.fromRGB(200, 28, 28))
	applyBackground(config.BackgroundColor or Color3.fromRGB(10, 8, 16))

	local function repaintAll()
		for _, fn in ipairs(Repainters) do
			fn()
		end
	end

	local gui = Instance.new("ScreenGui")
	gui.Name           = config.GuiName or "VantaUILibrary"
	gui.ResetOnSpawn   = false
	gui.IgnoreGuiInset = true
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.Parent         = LP:WaitForChild("PlayerGui")

	local notifyHolder = Instance.new("Frame", gui)
	notifyHolder.Size               = UDim2.new(0, 260, 1, -20)
	notifyHolder.Position           = UDim2.new(1, -270, 0, 10)
	notifyHolder.BackgroundTransparency = 1
	notifyHolder.BorderSizePixel    = 0
	notifyHolder.ZIndex             = 100
	local nhList = Instance.new("UIListLayout", notifyHolder)
	nhList.Padding             = UDim.new(0, 8)
	nhList.VerticalAlignment   = Enum.VerticalAlignment.Bottom
	nhList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	nhList.SortOrder           = Enum.SortOrder.LayoutOrder

	local Main = Instance.new("Frame", gui)
	Main.Size             = WINDOW_SIZE
	Main.Position         = WINDOW_POS
	Main.BackgroundColor3 = BG_DEEP
	Main.BorderSizePixel  = 0
	Main.ClipsDescendants = false
	local mc = Instance.new("UICorner", Main) mc.CornerRadius = UDim.new(0, 14)
	local ms = Instance.new("UIStroke",  Main)
	ms.Color = ACCENT_MID ms.Thickness = 1.5 ms.Transparency = 0.15

	local bgImg = Instance.new("ImageLabel", Main)
	bgImg.Size                   = UDim2.new(1, 0, 1, 0)
	bgImg.BackgroundTransparency = 1
	bgImg.Image                  = BG_IMAGE
	bgImg.ImageTransparency      = 0.48
	bgImg.ScaleType              = Enum.ScaleType.Crop
	bgImg.ZIndex                 = 0
	local bic = Instance.new("UICorner", bgImg) bic.CornerRadius = UDim.new(0, 14)

	local dimLayer = Instance.new("Frame", Main)
	dimLayer.Size                   = UDim2.new(1, 0, 1, 0)
	dimLayer.BackgroundColor3       = BG_DEEP
	dimLayer.BackgroundTransparency = 0.52
	dimLayer.BorderSizePixel        = 0
	dimLayer.ZIndex                 = 1
	local dlc = Instance.new("UICorner", dimLayer) dlc.CornerRadius = UDim.new(0, 14)

	local topBar = Instance.new("Frame", Main)
	topBar.Size             = UDim2.new(1, 0, 0, 3)
	topBar.BackgroundColor3 = ACCENT_FULL
	topBar.BorderSizePixel  = 0
	topBar.ZIndex           = 8
	local tg = Instance.new("UIGradient", topBar)
	tg.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0,   ACCENT_LINE),
		ColorSequenceKeypoint.new(0.4, ACCENT_TOPGLOW),
		ColorSequenceKeypoint.new(0.6, ACCENT_TOPGLOW),
		ColorSequenceKeypoint.new(1,   ACCENT_LINE),
	})

	local Hdr = Instance.new("Frame", Main)
	Hdr.Size                   = UDim2.new(1, 0, 0, 58)
	Hdr.Position               = UDim2.new(0, 0, 0, 3)
	Hdr.BackgroundColor3       = BG_MID
	Hdr.BackgroundTransparency = 0.38
	Hdr.BorderSizePixel        = 0
	Hdr.ZIndex                 = 7

	local hdrLine = Instance.new("Frame", Hdr)
	hdrLine.Size             = UDim2.new(1, 0, 0, 1)
	hdrLine.Position         = UDim2.new(0, 0, 1, -1)
	hdrLine.BackgroundColor3 = ACCENT_MID
	hdrLine.BackgroundTransparency = 0.4
	hdrLine.BorderSizePixel  = 0
	hdrLine.ZIndex           = 7

	local icoImg = Instance.new("ImageLabel", Hdr)
	icoImg.Size                   = UDim2.new(0, 32, 0, 32)
	icoImg.Position               = UDim2.new(0, 14, 0.5, -16)
	icoImg.BackgroundTransparency = 1
	icoImg.Image                  = ICON_ID
	icoImg.ZIndex                 = 8

	local titleLbl = Instance.new("TextLabel", Hdr)
	titleLbl.Size               = UDim2.new(0, 180, 0, 28)
	titleLbl.Position           = UDim2.new(0, 54, 0.5, -14)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text               = WINDOW_TITLE
	titleLbl.TextColor3         = Color3.fromRGB(244, 244, 248)
	titleLbl.TextSize           = 15
	titleLbl.Font               = Enum.Font.GothamBlack
	titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
	titleLbl.ZIndex             = 8

	local closeBtn = Instance.new("TextButton", Hdr)
	closeBtn.Size             = UDim2.new(0, 28, 0, 28)
	closeBtn.Position         = UDim2.new(1, -38, 0.5, -14)
	closeBtn.BackgroundColor3 = ACCENT_VOID
	closeBtn.BackgroundTransparency = 0.3
	closeBtn.BorderSizePixel  = 0
	closeBtn.Text             = "×"
	closeBtn.TextColor3       = ACCENT_LABEL
	closeBtn.TextSize         = 17
	closeBtn.Font             = Enum.Font.GothamBlack
	closeBtn.ZIndex           = 10
	local cbc = Instance.new("UICorner", closeBtn) cbc.CornerRadius = UDim.new(0, 8)
	local cbs = Instance.new("UIStroke",  closeBtn) cbs.Color = ACCENT_LINE cbs.Thickness = 1

	closeBtn.MouseEnter:Connect(function() tw(closeBtn, TI_FAST, {BackgroundTransparency = 0.1}) end)
	closeBtn.MouseLeave:Connect(function() tw(closeBtn, TI_FAST, {BackgroundTransparency = 0.3}) end)
	closeBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

	local TabBar = Instance.new("Frame", Main)
	TabBar.Size                   = UDim2.new(1, 0, 0, 35)
	TabBar.Position               = UDim2.new(0, 0, 0, 61)
	TabBar.BackgroundColor3       = BG_MID
	TabBar.BackgroundTransparency = 0.5
	TabBar.BorderSizePixel        = 0
	TabBar.ZIndex                 = 7

	local tabLine = Instance.new("Frame", TabBar)
	tabLine.Size             = UDim2.new(1, 0, 0, 1)
	tabLine.Position         = UDim2.new(0, 0, 1, -1)
	tabLine.BackgroundColor3 = ACCENT_MID
	tabLine.BackgroundTransparency = 0.38
	tabLine.BorderSizePixel  = 0
	tabLine.ZIndex           = 7

	local tabIndicator = Instance.new("Frame", TabBar)
	tabIndicator.Size             = UDim2.new(0, 84, 0, 2)
	tabIndicator.Position         = UDim2.new(0, 6, 1, -2)
	tabIndicator.BackgroundColor3 = ACCENT_FULL
	tabIndicator.BorderSizePixel  = 0
	tabIndicator.ZIndex           = 9
	local tic = Instance.new("UICorner", tabIndicator) tic.CornerRadius = UDim.new(0, 3)

	table.insert(Repainters, function()
		tw(Main, TI_MED, { BackgroundColor3 = BG_DEEP })
		tw(dimLayer, TI_MED, { BackgroundColor3 = BG_DEEP })
		tw(ms, TI_MED, { Color = ACCENT_MID })
		tw(topBar, TI_MED, { BackgroundColor3 = ACCENT_FULL })
		tg.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0,   ACCENT_LINE),
			ColorSequenceKeypoint.new(0.4, ACCENT_TOPGLOW),
			ColorSequenceKeypoint.new(0.6, ACCENT_TOPGLOW),
			ColorSequenceKeypoint.new(1,   ACCENT_LINE),
		})
		tw(Hdr, TI_MED, { BackgroundColor3 = BG_MID })
		tw(hdrLine, TI_MED, { BackgroundColor3 = ACCENT_MID })
		tw(closeBtn, TI_MED, { BackgroundColor3 = ACCENT_VOID, TextColor3 = ACCENT_LABEL })
		tw(cbs, TI_MED, { Color = ACCENT_LINE })
		tw(TabBar, TI_MED, { BackgroundColor3 = BG_MID })
		tw(tabLine, TI_MED, { BackgroundColor3 = ACCENT_MID })
		tw(tabIndicator, TI_MED, { BackgroundColor3 = ACCENT_FULL })
	end)

	local pageClip = Instance.new("Frame", Main)
	pageClip.Size             = UDim2.new(1, 0, 1, -99)
	pageClip.Position         = UDim2.new(0, 0, 0, 99)
	pageClip.BackgroundTransparency = 1
	pageClip.BorderSizePixel  = 0
	pageClip.ClipsDescendants = true
	pageClip.ZIndex           = 5

	local pages   = {}
	local tBtns   = {}
	local curTab  = nil
	local tabLock = false

	local function getIdx(name)
		for i, n in ipairs(TAB_NAMES) do if n == name then return i end end
		return 1
	end

	local function switchTab(name)
		if tabLock or name == curTab then return end
		tabLock = true

		local nIdx = getIdx(name)
		local pIdx = curTab and getIdx(curTab) or nIdx
		local dir  = (nIdx > pIdx) and 1 or -1
		local W    = pageClip.AbsoluteSize.X

		tw(tabIndicator, TI_MED, { Position = UDim2.new(0, 6 + (nIdx-1)*90, 1, -2) })

		if curTab then
			tw(tBtns[curTab], TI_FAST, {
				BackgroundColor3 = TAB_OFF,
				TextColor3       = ACCENT_LINE,
			})
			local prev = pages[curTab]
			tw(prev, TI_SLIDE, { Position = UDim2.new(0, -dir * W, 0, 0) })
			task.delay(0.22, function()
				if prev and prev.Parent then prev.Visible = false end
			end)
		end

		tw(tBtns[name], TI_FAST, {
			BackgroundColor3 = ACCENT_MID,
			TextColor3       = COL_WHITE,
		})

		local nextPage = pages[name]
		nextPage.Position = UDim2.new(0, dir * W, 0, 0)
		nextPage.Visible  = true
		tw(nextPage, TI_SLIDE, { Position = UDim2.new(0, 0, 0, 0) })

		curTab = name
		task.delay(0.25, function() tabLock = false end)
	end

	for i, name in ipairs(TAB_NAMES) do
		local btn = Instance.new("TextButton", TabBar)
		btn.Size                   = UDim2.new(0, 84, 0, 26)
		btn.Position               = UDim2.new(0, 6 + (i-1)*90, 0.5, -13)
		btn.BackgroundColor3       = TAB_OFF
		btn.BackgroundTransparency = 0.0
		btn.BorderSizePixel        = 0
		btn.Text                   = name
		btn.TextColor3             = ACCENT_LINE
		btn.TextSize               = 11
		btn.Font                   = Enum.Font.GothamBold
		btn.ZIndex                 = 8
		local bc = Instance.new("UICorner", btn) bc.CornerRadius = UDim.new(0, 6)

		local sf = Instance.new("ScrollingFrame", pageClip)
		sf.Size                       = UDim2.new(1, 0, 1, 0)
		sf.Position                   = UDim2.new(0, 0, 0, 0)
		sf.BackgroundTransparency     = 1
		sf.BorderSizePixel            = 0
		sf.ScrollBarThickness         = 2
		sf.ScrollBarImageColor3       = ACCENT_MID
		sf.ScrollBarImageTransparency = 0.3
		sf.AutomaticCanvasSize        = Enum.AutomaticSize.Y
		sf.CanvasSize                 = UDim2.new(0, 0, 0, 0)
		sf.Visible                    = false
		sf.ZIndex                     = 5

		local ll = Instance.new("UIListLayout", sf)
		ll.Padding             = UDim.new(0, 7)
		ll.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local lp = Instance.new("UIPadding", sf)
		lp.PaddingTop    = UDim.new(0, 12)
		lp.PaddingBottom = UDim.new(0, 18)
		lp.PaddingLeft   = UDim.new(0, 11)
		lp.PaddingRight  = UDim.new(0, 11)

		pages[name] = sf
		tBtns[name] = btn
		btn.MouseButton1Click:Connect(function() switchTab(name) end)
	end

	if TAB_NAMES[1] then switchTab(TAB_NAMES[1]) end

	table.insert(Repainters, function()
		for name, btn in pairs(tBtns) do
			if name == curTab then
				tw(btn, TI_MED, { BackgroundColor3 = ACCENT_MID, TextColor3 = COL_WHITE })
			else
				tw(btn, TI_MED, { BackgroundColor3 = TAB_OFF, TextColor3 = ACCENT_LINE })
			end
		end
		for _, sf in pairs(pages) do
			tw(sf, TI_MED, { ScrollBarImageColor3 = ACCENT_MID })
		end
	end)

	local isDragging = false
	local dragOff    = Vector2.new()

	Hdr.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			local p   = i.Position
			dragOff   = Vector2.new(p.X - Main.AbsolutePosition.X, p.Y - Main.AbsolutePosition.Y)
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if not isDragging then return end
		if i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch then
			local p = i.Position
			Main.Position = UDim2.new(0, p.X - dragOff.X, 0, p.Y - dragOff.Y)
		end
	end)

	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)

	UserInputService.InputBegan:Connect(function(i, gpe)
		if gpe then return end
		if i.KeyCode == TOGGLE_KEY then
			Main.Visible = not Main.Visible
		end
	end)

	local Window = {
		Gui    = gui,
		Main   = Main,
		Pages  = pages,
	}

	function Window:Section(tabName, title)
		local pg = pages[tabName]
		if not pg then return end

		local f = Instance.new("Frame", pg)
		f.Size                   = UDim2.new(1, 0, 0, 22)
		f.BackgroundColor3       = ACCENT_VOID
		f.BackgroundTransparency = 0.48
		f.BorderSizePixel        = 0
		f.ZIndex                 = 6
		local fc = Instance.new("UICorner", f) fc.CornerRadius = UDim.new(0, 6)

		local bar = Instance.new("Frame", f)
		bar.Size             = UDim2.new(0, 3, 0.62, 0)
		bar.Position         = UDim2.new(0, 0, 0.19, 0)
		bar.BackgroundColor3 = ACCENT_FULL
		bar.BorderSizePixel  = 0
		bar.ZIndex           = 7
		local bc = Instance.new("UICorner", bar) bc.CornerRadius = UDim.new(0, 8)

		local lbl = Instance.new("TextLabel", f)
		lbl.Size               = UDim2.new(1, -14, 1, 0)
		lbl.Position           = UDim2.new(0, 11, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = title
		lbl.TextColor3         = ACCENT_LABEL
		lbl.TextSize           = 10
		lbl.Font               = Enum.Font.GothamBlack
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 7

		table.insert(Repainters, function()
			tw(f, TI_MED, { BackgroundColor3 = ACCENT_VOID })
			tw(bar, TI_MED, { BackgroundColor3 = ACCENT_FULL })
			tw(lbl, TI_MED, { TextColor3 = ACCENT_LABEL })
		end)

		return f
	end

	function Window:Paragraph(tabName, title, content)
		local pg = pages[tabName]
		if not pg then return end

		local row = Instance.new("Frame", pg)
		row.Size                   = UDim2.new(1, 0, 0, 0)
		row.AutomaticSize          = Enum.AutomaticSize.Y
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local pad = Instance.new("UIPadding", row)
		pad.PaddingTop    = UDim.new(0, 10)
		pad.PaddingBottom = UDim.new(0, 10)
		pad.PaddingLeft   = UDim.new(0, 13)
		pad.PaddingRight  = UDim.new(0, 13)

		local list = Instance.new("UIListLayout", row)
		list.Padding = UDim.new(0, 4)

		local titleLbl = Instance.new("TextLabel", row)
		titleLbl.Size               = UDim2.new(1, 0, 0, 16)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text               = title
		titleLbl.TextColor3         = ACCENT_LABEL
		titleLbl.TextSize           = 12
		titleLbl.Font               = Enum.Font.GothamBold
		titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
		titleLbl.LayoutOrder        = 1
		titleLbl.ZIndex             = 6

		local contentLbl = Instance.new("TextLabel", row)
		contentLbl.Size             = UDim2.new(1, 0, 0, 0)
		contentLbl.AutomaticSize    = Enum.AutomaticSize.Y
		contentLbl.BackgroundTransparency = 1
		contentLbl.Text             = content
		contentLbl.TextColor3       = COL_TEXT
		contentLbl.TextSize         = 11
		contentLbl.Font             = Enum.Font.GothamSemibold
		contentLbl.TextWrapped      = true
		contentLbl.TextXAlignment   = Enum.TextXAlignment.Left
		contentLbl.TextYAlignment   = Enum.TextYAlignment.Top
		contentLbl.LayoutOrder      = 2
		contentLbl.ZIndex           = 6

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(titleLbl, TI_MED, { TextColor3 = ACCENT_LABEL })
		end)

		return row
	end

	function Window:Button(tabName, title, description, cb)
		local pg = pages[tabName]
		if not pg then return end

		local row = Instance.new("Frame", pg)
		row.Size                   = description and UDim2.new(1, 0, 0, 50) or UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local titleLbl = Instance.new("TextLabel", row)
		titleLbl.Size               = UDim2.new(1, -26, 0, 18)
		titleLbl.Position           = UDim2.new(0, 13, 0, description and 7 or 0)
		titleLbl.AnchorPoint         = description and Vector2.new(0, 0) or Vector2.new(0, 0)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text               = title
		titleLbl.TextColor3         = COL_TEXT
		titleLbl.TextSize           = 12
		titleLbl.Font               = Enum.Font.GothamSemibold
		titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
		titleLbl.ZIndex             = 6
		if not description then
			titleLbl.Size     = UDim2.new(1, -26, 1, 0)
			titleLbl.Position = UDim2.new(0, 13, 0, 0)
		end

		local descLbl
		if description then
			descLbl = Instance.new("TextLabel", row)
			descLbl.Size               = UDim2.new(1, -26, 0, 16)
			descLbl.Position           = UDim2.new(0, 13, 0, 26)
			descLbl.BackgroundTransparency = 1
			descLbl.Text               = description
			descLbl.TextColor3         = ACCENT_LINE
			descLbl.TextSize           = 10
			descLbl.Font               = Enum.Font.GothamSemibold
			descLbl.TextXAlignment     = Enum.TextXAlignment.Left
			descLbl.ZIndex             = 6
		end

		local hit = Instance.new("TextButton", row)
		hit.Size               = UDim2.new(1, 0, 1, 0)
		hit.BackgroundTransparency = 1
		hit.Text               = ""
		hit.ZIndex             = 9

		hit.MouseEnter:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.3 }) end)
		hit.MouseLeave:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.52 }) end)
		hit.MouseButton1Down:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.15 }) end)
		hit.MouseButton1Up:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.3 }) end)
		hit.MouseButton1Click:Connect(function()
			if cb then cb() end
		end)

		table.insert(Repainters, function()
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			if descLbl then tw(descLbl, TI_MED, { TextColor3 = ACCENT_LINE }) end
		end)

		return row
	end

	function Window:Toggle(tabName, labelTxt, default, cb)
		local pg = pages[tabName]
		if not pg then return end

		local row = Instance.new("Frame", pg)
		row.Size                   = UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local lbl = Instance.new("TextLabel", row)
		lbl.Size               = UDim2.new(1, -56, 1, 0)
		lbl.Position           = UDim2.new(0, 13, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = labelTxt
		lbl.TextColor3         = COL_TEXT
		lbl.TextSize           = 12
		lbl.Font               = Enum.Font.GothamSemibold
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 6

		local track = Instance.new("Frame", row)
		track.Size             = UDim2.new(0, 40, 0, 20)
		track.Position         = UDim2.new(1, -49, 0.5, -10)
		track.BackgroundColor3 = default and ACCENT_MID or ACCENT_VOID
		track.BorderSizePixel  = 0
		track.ZIndex           = 7
		local tc = Instance.new("UICorner", track) tc.CornerRadius = UDim.new(1, 0)

		local knob = Instance.new("Frame", track)
		knob.Size             = UDim2.new(0, 14, 0, 14)
		knob.Position         = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
		knob.BackgroundColor3 = COL_WHITE
		knob.BorderSizePixel  = 0
		knob.ZIndex           = 8
		local kc = Instance.new("UICorner", knob) kc.CornerRadius = UDim.new(1, 0)

		local state = default
		local hit   = Instance.new("TextButton", row)
		hit.Size               = UDim2.new(1, 0, 1, 0)
		hit.BackgroundTransparency = 1
		hit.Text               = ""
		hit.ZIndex             = 9

		hit.MouseEnter:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.35 }) end)
		hit.MouseLeave:Connect(function() tw(row, TI_FAST, { BackgroundTransparency = 0.52 }) end)

		hit.MouseButton1Click:Connect(function()
			state = not state
			tw(track, TI_FAST, { BackgroundColor3 = state and ACCENT_MID or ACCENT_VOID })
			tw(knob,  TI_FAST, { Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) })
			if cb then cb(state) end
		end)

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(track, TI_MED, { BackgroundColor3 = state and ACCENT_MID or ACCENT_VOID })
		end)

		return {
			Set = function(v)
				state = v
				tw(track, TI_FAST, { BackgroundColor3 = state and ACCENT_MID or ACCENT_VOID })
				tw(knob,  TI_FAST, { Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7) })
			end
		}
	end

	local openPopup = nil

	function Window:Dropdown(tabName, labelTxt, opts, default, cb)
		local pg = pages[tabName]
		if not pg then return end

		local wrap = Instance.new("Frame", pg)
		wrap.Size               = UDim2.new(1, 0, 0, 40)
		wrap.BackgroundTransparency = 1
		wrap.BorderSizePixel    = 0
		wrap.ClipsDescendants   = false
		wrap.ZIndex             = 9

		local row = Instance.new("Frame", wrap)
		row.Size                   = UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 9
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local lbl = Instance.new("TextLabel", row)
		lbl.Size               = UDim2.new(0, 95, 1, 0)
		lbl.Position           = UDim2.new(0, 13, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = labelTxt
		lbl.TextColor3         = COL_TEXT
		lbl.TextSize           = 12
		lbl.Font               = Enum.Font.GothamSemibold
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 9

		local selBtn = Instance.new("TextButton", row)
		selBtn.Size                   = UDim2.new(0, 112, 0, 28)
		selBtn.Position               = UDim2.new(1, -120, 0.5, -14)
		selBtn.BackgroundColor3       = ACCENT_VOID
		selBtn.BackgroundTransparency = 0.42
		selBtn.BorderSizePixel        = 0
		selBtn.Text                   = default .. "  ▾"
		selBtn.TextColor3             = ACCENT_LABEL
		selBtn.TextSize               = 11
		selBtn.Font                   = Enum.Font.GothamBold
		selBtn.ZIndex                 = 10
		local sc = Instance.new("UICorner", selBtn) sc.CornerRadius = UDim.new(0, 7)
		local ss = Instance.new("UIStroke",  selBtn) ss.Color = ACCENT_LINE ss.Thickness = 1

		local dropFrame = Instance.new("Frame", gui)
		dropFrame.Size                   = UDim2.new(0, 112, 0, #opts * 28)
		dropFrame.BackgroundColor3       = ACCENT_VOID
		dropFrame.BackgroundTransparency = 0.3
		dropFrame.BorderSizePixel        = 0
		dropFrame.ZIndex                 = 80
		dropFrame.Visible                = false
		local dfc = Instance.new("UICorner", dropFrame) dfc.CornerRadius = UDim.new(0, 8)
		local dfs = Instance.new("UIStroke",  dropFrame) dfs.Color = ACCENT_LINE dfs.Thickness = 1
		local dfl = Instance.new("UIListLayout", dropFrame) dfl.Padding = UDim.new(0, 0)

		for _, opt in ipairs(opts) do
			local item = Instance.new("TextButton", dropFrame)
			item.Size                   = UDim2.new(1, 0, 0, 28)
			item.BackgroundColor3       = ACCENT_VOID
			item.BackgroundTransparency = 0.0
			item.BorderSizePixel        = 0
			item.Text                   = opt
			item.TextColor3             = COL_ITEM
			item.TextSize               = 11
			item.Font                   = Enum.Font.GothamSemibold
			item.ZIndex                 = 81
			item.MouseEnter:Connect(function()
				tw(item, TI_FAST, { BackgroundColor3 = ACCENT_LINE })
			end)
			item.MouseLeave:Connect(function()
				tw(item, TI_FAST, { BackgroundColor3 = ACCENT_VOID })
			end)
			item.MouseButton1Click:Connect(function()
				selBtn.Text       = opt .. "  ▾"
				dropFrame.Visible = false
				openPopup         = nil
				if cb then cb(opt) end
			end)
		end

		selBtn.MouseButton1Click:Connect(function()
			if openPopup and openPopup ~= dropFrame then
				openPopup.Visible = false
			end
			if dropFrame.Visible then
				dropFrame.Visible = false
				openPopup         = nil
				return
			end
			local ap          = selBtn.AbsolutePosition
			local as          = selBtn.AbsoluteSize
			dropFrame.Position = UDim2.new(0, ap.X, 0, ap.Y + as.Y + 4)
			dropFrame.Visible  = true
			openPopup          = dropFrame
		end)

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(selBtn, TI_MED, { BackgroundColor3 = ACCENT_VOID, TextColor3 = ACCENT_LABEL })
			tw(ss, TI_MED, { Color = ACCENT_LINE })
			tw(dropFrame, TI_MED, { BackgroundColor3 = ACCENT_VOID })
			tw(dfs, TI_MED, { Color = ACCENT_LINE })
			for _, item in ipairs(dropFrame:GetChildren()) do
				if item:IsA("TextButton") then
					tw(item, TI_MED, { BackgroundColor3 = ACCENT_VOID })
				end
			end
		end)
	end

	function Window:Slider(tabName, labelTxt, minV, maxV, default, sfx, cb)
		local pg = pages[tabName]
		if not pg then return end

		local row = Instance.new("Frame", pg)
		row.Size                   = UDim2.new(1, 0, 0, 54)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local nameLbl = Instance.new("TextLabel", row)
		nameLbl.Size               = UDim2.new(0.54, 0, 0, 20)
		nameLbl.Position           = UDim2.new(0, 13, 0, 8)
		nameLbl.BackgroundTransparency = 1
		nameLbl.Text               = labelTxt
		nameLbl.TextColor3         = COL_TEXT
		nameLbl.TextSize           = 12
		nameLbl.Font               = Enum.Font.GothamSemibold
		nameLbl.TextXAlignment     = Enum.TextXAlignment.Left
		nameLbl.ZIndex             = 6

		local valLbl = Instance.new("TextLabel", row)
		valLbl.Size               = UDim2.new(0.44, 0, 0, 20)
		valLbl.Position           = UDim2.new(0.54, 0, 0, 8)
		valLbl.BackgroundTransparency = 1
		valLbl.Text               = tostring(default) .. (sfx or "")
		valLbl.TextColor3         = ACCENT_LABEL
		valLbl.TextSize           = 12
		valLbl.Font               = Enum.Font.GothamBold
		valLbl.TextXAlignment     = Enum.TextXAlignment.Right
		valLbl.ZIndex             = 6

		local track = Instance.new("Frame", row)
		track.Size             = UDim2.new(1, -26, 0, 5)
		track.Position         = UDim2.new(0, 13, 0, 39)
		track.BackgroundColor3 = ACCENT_VOID
		track.BorderSizePixel  = 0
		track.ZIndex           = 6
		local trc = Instance.new("UICorner", track) trc.CornerRadius = UDim.new(1, 0)

		local fill = Instance.new("Frame", track)
		fill.Size             = UDim2.new((default - minV) / (maxV - minV), 0, 1, 0)
		fill.BackgroundColor3 = ACCENT_MID
		fill.BorderSizePixel  = 0
		fill.ZIndex           = 7
		local flc = Instance.new("UICorner", fill) flc.CornerRadius = UDim.new(1, 0)
		local flg = Instance.new("UIGradient", fill)
		flg.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, ACCENT_MID),
			ColorSequenceKeypoint.new(1, ACCENT_GLOW),
		})

		local knob = Instance.new("Frame", track)
		knob.Size         = UDim2.new(0, 16, 0, 16)
		knob.AnchorPoint  = Vector2.new(0.5, 0.5)
		knob.Position     = UDim2.new((default - minV) / (maxV - minV), 0, 0.5, 0)
		knob.BackgroundColor3 = COL_WHITE
		knob.BorderSizePixel  = 0
		knob.ZIndex       = 8
		local knc = Instance.new("UICorner", knob) knc.CornerRadius = UDim.new(1, 0)

		local dragging = false

		local function update(x)
			local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
			local val = math.floor(minV + rel * (maxV - minV))
			valLbl.Text   = tostring(val) .. (sfx or "")
			fill.Size     = UDim2.new(rel, 0, 1, 0)
			knob.Position = UDim2.new(rel, 0, 0.5, 0)
			if cb then cb(val) end
		end

		local hit = Instance.new("TextButton", track)
		hit.Size               = UDim2.new(1, 8, 0, 26)
		hit.Position           = UDim2.new(0, -4, 0.5, -13)
		hit.BackgroundTransparency = 1
		hit.Text               = ""
		hit.ZIndex             = 9

		hit.MouseButton1Down:Connect(function()
			dragging = true
			update(UserInputService:GetMouseLocation().X)
		end)

		UserInputService.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1
			or i.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(i)
			if not dragging then return end
			if i.UserInputType == Enum.UserInputType.MouseMovement
			or i.UserInputType == Enum.UserInputType.Touch then
				update(i.Position.X)
			end
		end)

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(valLbl, TI_MED, { TextColor3 = ACCENT_LABEL })
			tw(track, TI_MED, { BackgroundColor3 = ACCENT_VOID })
			tw(fill, TI_MED, { BackgroundColor3 = ACCENT_MID })
			flg.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, ACCENT_MID),
				ColorSequenceKeypoint.new(1, ACCENT_GLOW),
			})
		end)
	end

	function Window:Colorpicker(tabName, labelTxt, default, withAlpha, cb)
		local pg = pages[tabName]
		if not pg then return end

		default = default or Color3.fromRGB(255, 255, 255)
		local h0, s0, v0 = default:ToHSV()

		local wrap = Instance.new("Frame", pg)
		wrap.Size               = UDim2.new(1, 0, 0, 40)
		wrap.BackgroundTransparency = 1
		wrap.BorderSizePixel    = 0
		wrap.ClipsDescendants   = false
		wrap.ZIndex             = 9

		local row = Instance.new("Frame", wrap)
		row.Size                   = UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 9
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local lbl = Instance.new("TextLabel", row)
		lbl.Size               = UDim2.new(1, -70, 1, 0)
		lbl.Position           = UDim2.new(0, 13, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = labelTxt
		lbl.TextColor3         = COL_TEXT
		lbl.TextSize           = 12
		lbl.Font               = Enum.Font.GothamSemibold
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 9

		local swatch = Instance.new("TextButton", row)
		swatch.Size             = UDim2.new(0, 44, 0, 24)
		swatch.Position         = UDim2.new(1, -54, 0.5, -12)
		swatch.BackgroundColor3 = default
		swatch.BorderSizePixel  = 0
		swatch.Text             = ""
		swatch.ZIndex           = 10
		local swc = Instance.new("UICorner", swatch) swc.CornerRadius = UDim.new(0, 6)
		local sws = Instance.new("UIStroke",  swatch) sws.Color = ACCENT_LINE sws.Thickness = 1

		local panelH = withAlpha and 176 or 152
		local panel = Instance.new("Frame", gui)
		panel.Size                   = UDim2.new(0, 180, 0, panelH)
		panel.BackgroundColor3       = ACCENT_VOID
		panel.BackgroundTransparency = 0.08
		panel.BorderSizePixel        = 0
		panel.Visible                = false
		panel.ZIndex                 = 80
		local pc = Instance.new("UICorner", panel) pc.CornerRadius = UDim.new(0, 8)
		local ps = Instance.new("UIStroke",  panel) ps.Color = ACCENT_LINE ps.Thickness = 1

		local svBox = Instance.new("Frame", panel)
		svBox.Size             = UDim2.new(1, -20, 0, 100)
		svBox.Position         = UDim2.new(0, 10, 0, 10)
		svBox.BackgroundColor3 = Color3.fromHSV(h0, 1, 1)
		svBox.BorderSizePixel  = 0
		svBox.ClipsDescendants = true
		svBox.ZIndex           = 81
		local svc = Instance.new("UICorner", svBox) svc.CornerRadius = UDim.new(0, 6)

		local satOverlay = Instance.new("Frame", svBox)
		satOverlay.Size             = UDim2.new(1, 0, 1, 0)
		satOverlay.BackgroundColor3 = Color3.new(1, 1, 1)
		satOverlay.BorderSizePixel  = 0
		satOverlay.ZIndex           = 82
		local satGrad = Instance.new("UIGradient", satOverlay)
		satGrad.Color = ColorSequence.new(Color3.new(1, 1, 1))
		satGrad.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1),
		})

		local valOverlay = Instance.new("Frame", svBox)
		valOverlay.Size             = UDim2.new(1, 0, 1, 0)
		valOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
		valOverlay.BorderSizePixel  = 0
		valOverlay.ZIndex           = 83
		local valGrad = Instance.new("UIGradient", valOverlay)
		valGrad.Rotation = 90
		valGrad.Color = ColorSequence.new(Color3.new(0, 0, 0))
		valGrad.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0),
		})

		local svCursor = Instance.new("Frame", svBox)
		svCursor.Size             = UDim2.new(0, 10, 0, 10)
		svCursor.AnchorPoint      = Vector2.new(0.5, 0.5)
		svCursor.Position         = UDim2.new(s0, 0, 1 - v0, 0)
		svCursor.BackgroundColor3 = COL_WHITE
		svCursor.BorderSizePixel  = 0
		svCursor.ZIndex           = 84
		local svcc = Instance.new("UICorner", svCursor) svcc.CornerRadius = UDim.new(1, 0)
		local svcs = Instance.new("UIStroke",  svCursor) svcs.Color = Color3.new(0, 0, 0) svcs.Thickness = 1.5

		local hueBar = Instance.new("Frame", panel)
		hueBar.Size            = UDim2.new(1, -20, 0, 14)
		hueBar.Position        = UDim2.new(0, 10, 0, 118)
		hueBar.BorderSizePixel = 0
		hueBar.ZIndex          = 81
		local hbc = Instance.new("UICorner", hueBar) hbc.CornerRadius = UDim.new(0, 6)
		local hueGrad = Instance.new("UIGradient", hueBar)
		hueGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0/6, Color3.fromHSV(0/6, 1, 1)),
			ColorSequenceKeypoint.new(1/6, Color3.fromHSV(1/6, 1, 1)),
			ColorSequenceKeypoint.new(2/6, Color3.fromHSV(2/6, 1, 1)),
			ColorSequenceKeypoint.new(3/6, Color3.fromHSV(3/6, 1, 1)),
			ColorSequenceKeypoint.new(4/6, Color3.fromHSV(4/6, 1, 1)),
			ColorSequenceKeypoint.new(5/6, Color3.fromHSV(5/6, 1, 1)),
			ColorSequenceKeypoint.new(1,   Color3.fromHSV(1,   1, 1)),
		})

		local hueCursor = Instance.new("Frame", hueBar)
		hueCursor.Size             = UDim2.new(0, 4, 1, 6)
		hueCursor.AnchorPoint      = Vector2.new(0.5, 0.5)
		hueCursor.Position         = UDim2.new(h0, 0, 0.5, 0)
		hueCursor.BackgroundColor3 = COL_WHITE
		hueCursor.BorderSizePixel  = 0
		hueCursor.ZIndex           = 85
		local hcc = Instance.new("UICorner", hueCursor) hcc.CornerRadius = UDim.new(0, 2)

		local alphaBar, alphaCursor, alphaGrad
		if withAlpha then
			alphaBar = Instance.new("Frame", panel)
			alphaBar.Size            = UDim2.new(1, -20, 0, 14)
			alphaBar.Position        = UDim2.new(0, 10, 0, 142)
			alphaBar.BackgroundColor3 = default
			alphaBar.BorderSizePixel = 0
			alphaBar.ZIndex          = 81
			local abc = Instance.new("UICorner", alphaBar) abc.CornerRadius = UDim.new(0, 6)
			alphaGrad = Instance.new("UIGradient", alphaBar)
			alphaGrad.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 1),
			})

			alphaCursor = Instance.new("Frame", alphaBar)
			alphaCursor.Size             = UDim2.new(0, 4, 1, 6)
			alphaCursor.AnchorPoint      = Vector2.new(0.5, 0.5)
			alphaCursor.Position         = UDim2.new(0, 0, 0.5, 0)
			alphaCursor.BackgroundColor3 = COL_WHITE
			alphaCursor.BorderSizePixel  = 0
			alphaCursor.ZIndex           = 85
			local acc = Instance.new("UICorner", alphaCursor) acc.CornerRadius = UDim.new(0, 2)
		end

		local hue, sat, val, alpha = h0, s0, v0, 0
		local currentColor = default
		local changedCallbacks = {}

		local api = { Value = currentColor, Transparency = alpha }

		local function fire()
			currentColor = Color3.fromHSV(hue, sat, val)
			api.Value        = currentColor
			api.Transparency = alpha
			swatch.BackgroundColor3 = currentColor
			if withAlpha then
				alphaBar.BackgroundColor3 = currentColor
			end
			if cb then cb(currentColor, alpha) end
			for _, fn in ipairs(changedCallbacks) do fn(currentColor, alpha) end
		end

		local function refreshCursors()
			svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
			svCursor.Position   = UDim2.new(sat, 0, 1 - val, 0)
			hueCursor.Position  = UDim2.new(hue, 0, 0.5, 0)
			if withAlpha then
				alphaCursor.Position = UDim2.new(alpha, 0, 0.5, 0)
			end
		end

		makeDraggable(svBox, function(relX, relY)
			sat = relX
			val = 1 - relY
			refreshCursors()
			fire()
		end)

		makeDraggable(hueBar, function(relX)
			hue = relX
			refreshCursors()
			fire()
		end)

		if withAlpha then
			makeDraggable(alphaBar, function(relX)
				alpha = relX
				refreshCursors()
				fire()
			end)
		end

		swatch.MouseButton1Click:Connect(function()
			if openPopup and openPopup ~= panel then
				openPopup.Visible = false
			end
			if panel.Visible then
				panel.Visible = false
				openPopup      = nil
				return
			end
			local ap = swatch.AbsolutePosition
			local as = swatch.AbsoluteSize
			panel.Position = UDim2.new(0, ap.X + as.X - 180, 0, ap.Y + as.Y + 4)
			panel.Visible  = true
			openPopup       = panel
		end)

		function api.OnChanged(fn)
			table.insert(changedCallbacks, fn)
		end

		function api.SetValueRGB(color)
			hue, sat, val = color:ToHSV()
			refreshCursors()
			fire()
		end

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(sws, TI_MED, { Color = ACCENT_LINE })
			tw(panel, TI_MED, { BackgroundColor3 = ACCENT_VOID })
			tw(ps, TI_MED, { Color = ACCENT_LINE })
		end)

		return api
	end

	function Window:Keybind(tabName, labelTxt, default, defaultMode, cb)
		local pg = pages[tabName]
		if not pg then return end

		local currentKey  = default or Enum.KeyCode.F
		local currentMode = defaultMode or "Toggle"
		local state       = currentMode == "Always"
		local listening   = false

		local row = Instance.new("Frame", pg)
		row.Size                   = UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local lbl = Instance.new("TextLabel", row)
		lbl.Size               = UDim2.new(1, -100, 1, 0)
		lbl.Position           = UDim2.new(0, 13, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = labelTxt
		lbl.TextColor3         = COL_TEXT
		lbl.TextSize           = 12
		lbl.Font               = Enum.Font.GothamSemibold
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 6

		local function keyLabelFor(k)
			if k == "MB1" or k == "MB2" then return k end
			if typeof(k) == "EnumItem" then return k.Name end
			return tostring(k)
		end

		local keyBtn = Instance.new("TextButton", row)
		keyBtn.Size                   = UDim2.new(0, 84, 0, 26)
		keyBtn.Position               = UDim2.new(1, -92, 0.5, -13)
		keyBtn.BackgroundColor3       = ACCENT_VOID
		keyBtn.BackgroundTransparency = 0.42
		keyBtn.BorderSizePixel        = 0
		keyBtn.Text                   = keyLabelFor(currentKey)
		keyBtn.TextColor3             = ACCENT_LABEL
		keyBtn.TextSize               = 11
		keyBtn.Font                   = Enum.Font.GothamBold
		keyBtn.ZIndex                 = 7
		local kbc = Instance.new("UICorner", keyBtn) kbc.CornerRadius = UDim.new(0, 7)
		local kbs = Instance.new("UIStroke",  keyBtn) kbs.Color = ACCENT_LINE kbs.Thickness = 1

		local changedCallbacks = {}
		local clickCallbacks   = {}

		local function setState(newState)
			if state == newState then return end
			state = newState
			for _, fn in ipairs(changedCallbacks) do fn(state) end
			if cb then cb(state) end
		end

		local function inputMatches(i)
			if currentKey == "MB1" then return i.UserInputType == Enum.UserInputType.MouseButton1 end
			if currentKey == "MB2" then return i.UserInputType == Enum.UserInputType.MouseButton2 end
			if typeof(currentKey) == "EnumItem" then return i.KeyCode == currentKey end
			return false
		end

		keyBtn.MouseButton1Click:Connect(function()
			listening   = true
			keyBtn.Text = "..."
		end)

		UserInputService.InputBegan:Connect(function(i, gpe)
			if listening then
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					currentKey  = "MB1"
				elseif i.UserInputType == Enum.UserInputType.MouseButton2 then
					currentKey  = "MB2"
				elseif i.UserInputType == Enum.UserInputType.Keyboard then
					currentKey  = i.KeyCode
				else
					return
				end
				keyBtn.Text = keyLabelFor(currentKey)
				listening   = false
				return
			end

			if gpe then return end
			if not inputMatches(i) then return end

			if currentMode == "Toggle" then
				setState(not state)
				if state then
					for _, fn in ipairs(clickCallbacks) do fn() end
				end
			elseif currentMode == "Hold" then
				setState(true)
			end
		end)

		UserInputService.InputEnded:Connect(function(i)
			if currentMode == "Hold" and inputMatches(i) then
				setState(false)
			end
		end)

		local api = {}

		function api.GetState()
			return state
		end

		function api.OnClick(fn)
			table.insert(clickCallbacks, fn)
		end

		function api.OnChanged(fn)
			table.insert(changedCallbacks, fn)
		end

		function api.SetValue(key, modeParam)
			currentKey  = key
			currentMode = modeParam or currentMode
			keyBtn.Text = keyLabelFor(currentKey)
			if currentMode == "Always" then
				setState(true)
			end
		end

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(keyBtn, TI_MED, { BackgroundColor3 = ACCENT_VOID, TextColor3 = ACCENT_LABEL })
			tw(kbs, TI_MED, { Color = ACCENT_LINE })
		end)

		return api
	end

	function Window:Input(tabName, labelTxt, default, placeholder, numeric, finished, cb)
		local pg = pages[tabName]
		if not pg then return end

		local row = Instance.new("Frame", pg)
		row.Size                   = UDim2.new(1, 0, 0, 40)
		row.BackgroundColor3       = BG_ELEM
		row.BackgroundTransparency = 0.52
		row.BorderSizePixel        = 0
		row.ZIndex                 = 6
		local rc = Instance.new("UICorner", row) rc.CornerRadius = UDim.new(0, 9)
		local rs = Instance.new("UIStroke",  row) rs.Color = ACCENT_VOID rs.Thickness = 1

		local lbl = Instance.new("TextLabel", row)
		lbl.Size               = UDim2.new(0, 90, 1, 0)
		lbl.Position           = UDim2.new(0, 13, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text               = labelTxt
		lbl.TextColor3         = COL_TEXT
		lbl.TextSize           = 12
		lbl.Font               = Enum.Font.GothamSemibold
		lbl.TextXAlignment     = Enum.TextXAlignment.Left
		lbl.ZIndex             = 6

		local box = Instance.new("TextBox", row)
		box.Size                   = UDim2.new(1, -113, 0, 26)
		box.Position               = UDim2.new(0, 103, 0.5, -13)
		box.BackgroundColor3       = ACCENT_VOID
		box.BackgroundTransparency = 0.42
		box.BorderSizePixel        = 0
		box.Text                   = default or ""
		box.PlaceholderText        = placeholder or ""
		box.PlaceholderColor3      = COL_ITEM
		box.TextColor3             = COL_TEXT
		box.ClearTextOnFocus       = false
		box.Font                   = Enum.Font.GothamSemibold
		box.TextSize               = 12
		box.ZIndex                 = 7
		local bc = Instance.new("UICorner", box) bc.CornerRadius = UDim.new(0, 7)
		local bs = Instance.new("UIStroke",  box) bs.Color = ACCENT_LINE bs.Thickness = 1

		local changedCallbacks = {}
		local api = { Value = default or "" }

		local function fire(value)
			api.Value = value
			if cb then cb(value) end
			for _, fn in ipairs(changedCallbacks) do fn(value) end
		end

		if numeric then
			box:GetPropertyChangedSignal("Text"):Connect(function()
				local filtered = box.Text:gsub("[^%d%.%-]", "")
				if filtered ~= box.Text then
					box.Text = filtered
				end
			end)
		end

		if finished then
			box.FocusLost:Connect(function()
				fire(box.Text)
			end)
		else
			box:GetPropertyChangedSignal("Text"):Connect(function()
				fire(box.Text)
			end)
		end

		function api.OnChanged(fn)
			table.insert(changedCallbacks, fn)
		end

		function api.SetValue(v)
			box.Text = v
			fire(v)
		end

		table.insert(Repainters, function()
			tw(row, TI_MED, { BackgroundColor3 = BG_ELEM })
			tw(rs, TI_MED, { Color = ACCENT_VOID })
			tw(box, TI_MED, { BackgroundColor3 = ACCENT_VOID })
			tw(bs, TI_MED, { Color = ACCENT_LINE })
		end)

		return api
	end

	function Window:SetAccentColor(color)
		applyAccent(color)
		repaintAll()
	end

	function Window:SetBackgroundColor(color)
		applyBackground(color)
		repaintAll()
	end

	function Window:SetTheme(accentColor, backgroundColor)
		if accentColor then applyAccent(accentColor) end
		if backgroundColor then applyBackground(backgroundColor) end
		repaintAll()
	end

	function Window:GetAccentColor()
		return ACCENT_FULL
	end

	function Window:GetBackgroundColor()
		return BG_BASE
	end

	function Window:SelectTab(nameOrIndex)
		local name = nameOrIndex
		if type(nameOrIndex) == "number" then
			name = TAB_NAMES[nameOrIndex]
		end
		if name then switchTab(name) end
	end

	function Window:Notify(cfg)
		cfg = cfg or {}
		local title    = cfg.Title or "Notification"
		local content  = cfg.Content or ""
		local sub      = cfg.SubContent
		local duration = cfg.Duration

		local card = Instance.new("Frame", notifyHolder)
		card.Size                   = UDim2.new(1, 0, 0, 0)
		card.AutomaticSize          = Enum.AutomaticSize.Y
		card.BackgroundColor3       = BG_DEEP
		card.BackgroundTransparency = 1
		card.BorderSizePixel        = 0
		card.ClipsDescendants       = true
		card.ZIndex                 = 100
		local cc = Instance.new("UICorner", card) cc.CornerRadius = UDim.new(0, 9)
		local cs = Instance.new("UIStroke",  card) cs.Color = ACCENT_MID cs.Thickness = 1 cs.Transparency = 1

		local bar = Instance.new("Frame", card)
		bar.Size             = UDim2.new(0, 3, 1, -14)
		bar.Position         = UDim2.new(0, 0, 0, 7)
		bar.BackgroundColor3 = ACCENT_FULL
		bar.BackgroundTransparency = 1
		bar.BorderSizePixel  = 0
		bar.ZIndex           = 101
		local bc = Instance.new("UICorner", bar) bc.CornerRadius = UDim.new(0, 8)

		local pad = Instance.new("UIPadding", card)
		pad.PaddingTop    = UDim.new(0, 10)
		pad.PaddingBottom = UDim.new(0, 10)
		pad.PaddingLeft   = UDim.new(0, 14)
		pad.PaddingRight  = UDim.new(0, 12)

		local list = Instance.new("UIListLayout", card)
		list.Padding = UDim.new(0, 2)

		local titleLbl = Instance.new("TextLabel", card)
		titleLbl.Size               = UDim2.new(1, 0, 0, 16)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text               = title
		titleLbl.TextColor3         = Color3.fromRGB(244, 244, 248)
		titleLbl.TextTransparency   = 1
		titleLbl.TextSize           = 13
		titleLbl.Font               = Enum.Font.GothamBlack
		titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
		titleLbl.LayoutOrder        = 1
		titleLbl.ZIndex             = 101

		local contentLbl = Instance.new("TextLabel", card)
		contentLbl.Size             = UDim2.new(1, 0, 0, 0)
		contentLbl.AutomaticSize    = Enum.AutomaticSize.Y
		contentLbl.BackgroundTransparency = 1
		contentLbl.Text             = content
		contentLbl.TextColor3       = COL_TEXT
		contentLbl.TextTransparency = 1
		contentLbl.TextSize         = 11
		contentLbl.Font             = Enum.Font.GothamSemibold
		contentLbl.TextWrapped      = true
		contentLbl.TextXAlignment   = Enum.TextXAlignment.Left
		contentLbl.LayoutOrder      = 2
		contentLbl.ZIndex           = 101

		local subLbl
		if sub then
			subLbl = Instance.new("TextLabel", card)
			subLbl.Size             = UDim2.new(1, 0, 0, 0)
			subLbl.AutomaticSize    = Enum.AutomaticSize.Y
			subLbl.BackgroundTransparency = 1
			subLbl.Text             = sub
			subLbl.TextColor3       = ACCENT_LABEL
			subLbl.TextTransparency = 1
			subLbl.TextSize         = 10
			subLbl.Font             = Enum.Font.GothamSemibold
			subLbl.TextWrapped      = true
			subLbl.TextXAlignment   = Enum.TextXAlignment.Left
			subLbl.LayoutOrder      = 3
			subLbl.ZIndex           = 101
		end

		local function fadeIn()
			tw(card, TI_MED, { BackgroundTransparency = 0.08 })
			tw(cs, TI_MED, { Transparency = 0.15 })
			tw(bar, TI_MED, { BackgroundTransparency = 0 })
			tw(titleLbl, TI_MED, { TextTransparency = 0 })
			tw(contentLbl, TI_MED, { TextTransparency = 0 })
			if subLbl then tw(subLbl, TI_MED, { TextTransparency = 0 }) end
		end

		local function fadeOutAndDestroy()
			tw(card, TI_MED, { BackgroundTransparency = 1 })
			tw(cs, TI_MED, { Transparency = 1 })
			tw(bar, TI_MED, { BackgroundTransparency = 1 })
			tw(titleLbl, TI_MED, { TextTransparency = 1 })
			tw(contentLbl, TI_MED, { TextTransparency = 1 })
			if subLbl then tw(subLbl, TI_MED, { TextTransparency = 1 }) end
			task.delay(0.25, function()
				if card.Parent then card:Destroy() end
			end)
		end

		task.defer(fadeIn)

		if duration then
			task.delay(duration, fadeOutAndDestroy)
		end

		return {
			Close = fadeOutAndDestroy,
		}
	end

	function Window:Dialog(cfg)
		cfg = cfg or {}
		local title   = cfg.Title or "Dialog"
		local content = cfg.Content or ""
		local buttons = cfg.Buttons or {}

		local backdrop = Instance.new("Frame", gui)
		backdrop.Size                   = UDim2.new(1, 0, 1, 0)
		backdrop.BackgroundColor3       = Color3.new(0, 0, 0)
		backdrop.BackgroundTransparency = 1
		backdrop.BorderSizePixel        = 0
		backdrop.ZIndex                 = 150

		local box = Instance.new("Frame", backdrop)
		box.AnchorPoint            = Vector2.new(0.5, 0.5)
		box.Position               = UDim2.new(0.5, 0, 0.5, 0)
		box.Size                   = UDim2.new(0, 260, 0, 0)
		box.AutomaticSize          = Enum.AutomaticSize.Y
		box.BackgroundColor3       = BG_DEEP
		box.BorderSizePixel        = 0
		box.ZIndex                 = 151
		local boc = Instance.new("UICorner", box) boc.CornerRadius = UDim.new(0, 12)
		local bos = Instance.new("UIStroke",  box) bos.Color = ACCENT_MID bos.Thickness = 1.5

		local pad = Instance.new("UIPadding", box)
		pad.PaddingTop    = UDim.new(0, 16)
		pad.PaddingBottom = UDim.new(0, 16)
		pad.PaddingLeft   = UDim.new(0, 16)
		pad.PaddingRight  = UDim.new(0, 16)

		local list = Instance.new("UIListLayout", box)
		list.Padding = UDim.new(0, 12)
		list.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local titleLbl = Instance.new("TextLabel", box)
		titleLbl.Size               = UDim2.new(1, 0, 0, 18)
		titleLbl.BackgroundTransparency = 1
		titleLbl.Text               = title
		titleLbl.TextColor3         = Color3.fromRGB(244, 244, 248)
		titleLbl.TextSize           = 15
		titleLbl.Font               = Enum.Font.GothamBlack
		titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
		titleLbl.LayoutOrder        = 1
		titleLbl.ZIndex             = 151

		local contentLbl = Instance.new("TextLabel", box)
		contentLbl.Size             = UDim2.new(1, 0, 0, 0)
		contentLbl.AutomaticSize    = Enum.AutomaticSize.Y
		contentLbl.BackgroundTransparency = 1
		contentLbl.Text             = content
		contentLbl.TextColor3       = COL_TEXT
		contentLbl.TextSize         = 12
		contentLbl.Font             = Enum.Font.GothamSemibold
		contentLbl.TextWrapped      = true
		contentLbl.TextXAlignment   = Enum.TextXAlignment.Left
		contentLbl.LayoutOrder      = 2
		contentLbl.ZIndex           = 151

		local btnRow = Instance.new("Frame", box)
		btnRow.Size               = UDim2.new(1, 0, 0, 32)
		btnRow.BackgroundTransparency = 1
		btnRow.LayoutOrder        = 3
		btnRow.ZIndex             = 151
		local btnList = Instance.new("UIListLayout", btnRow)
		btnList.FillDirection        = Enum.FillDirection.Horizontal
		btnList.Padding              = UDim.new(0, 8)
		btnList.HorizontalAlignment  = Enum.HorizontalAlignment.Right

		local function closeDialog()
			tw(backdrop, TI_MED, { BackgroundTransparency = 1 })
			task.delay(0.25, function()
				if backdrop.Parent then backdrop:Destroy() end
			end)
		end

		for i, b in ipairs(buttons) do
			local btn = Instance.new("TextButton", btnRow)
			btn.Size             = UDim2.new(0, 96, 1, 0)
			btn.BackgroundColor3 = (i == 1) and ACCENT_MID or ACCENT_VOID
			btn.BorderSizePixel  = 0
			btn.Text             = b.Title or "OK"
			btn.TextColor3       = COL_WHITE
			btn.Font             = Enum.Font.GothamBold
			btn.TextSize         = 12
			btn.ZIndex           = 151
			local btc = Instance.new("UICorner", btn) btc.CornerRadius = UDim.new(0, 7)

			btn.MouseButton1Click:Connect(function()
				if b.Callback then b.Callback() end
				closeDialog()
			end)
		end

		if #buttons == 0 then
			btnRow.Visible = false
		end

		tw(backdrop, TI_MED, { BackgroundTransparency = 0.45 })

		return {
			Close = closeDialog,
		}
	end

	return Window
end

return VantaUI
