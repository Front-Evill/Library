function Library:Window(config)
	config = config or {}

	local rawTheme = {}
	for key, value in pairs(Library.Presets.Dark) do
		rawTheme[key] = value
	end

	if type(config.Theme) == "string" then
		local themeName = config.Theme
		if themeName == "All" or themeName == "Random" then
			themeName = GetRandomPresetName()
		end

		local preset = Library.Presets[themeName]
		if preset then
			for key, value in pairs(preset) do
				rawTheme[key] = value
			end
		end
	elseif type(config.Theme) == "table" then
		if config.Theme.Accent and not config.Theme.Background and not config.Theme.Secondary then
			local generated = GenerateThemeFromAccent(ToColor3(config.Theme.Accent))
			for key, value in pairs(generated) do
				rawTheme[key] = value
			end
		end

		for key, value in pairs(config.Theme) do
			rawTheme[key] = value
		end
	end

	local theme = ResolveTheme(rawTheme)

	local self = setmetatable({}, Library)
	self.Theme = theme

	local tabWidth = config.TabWidth or 160
	local windowSize = config.Size or UDim2.fromOffset(830, 525)
	local minSize = Vector2.new(420, 300)
	local maxSize = Vector2.new(1200, 800)

	local screenGui = CreateInstance("ScreenGui", {
		Name = "VantaUI",
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	local mainFrame = CreateInstance("Frame", {
		Name = "MainFrame",
		Parent = screenGui,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = windowSize,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = theme.Transparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})

	CreateInstance("UICorner", {
		Parent = mainFrame,
		CornerRadius = UDim.new(0, 10),
	})

	local stroke = CreateInstance("UIStroke", {
		Parent = mainFrame,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.4,
	})

	local acrylicCleanup

	if config.Acrylic then
		EnableAcrylicLighting()
		local _, cleanup = AttachAcrylicGlass(mainFrame, screenGui)
		acrylicCleanup = cleanup

		local frostTint = CreateInstance("Frame", {
			Name = "AcrylicTint",
			Parent = mainFrame,
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.92,
			BorderSizePixel = 0,
			ZIndex = 0,
		})

		CreateInstance("UIGradient", {
			Parent = frostTint,
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.85),
				NumberSequenceKeypoint.new(0.5, 0.95),
				NumberSequenceKeypoint.new(1, 0.85),
			}),
		})

		CreateInstance("ImageLabel", {
			Name = "AcrylicNoise",
			Parent = mainFrame,
			Image = "rbxassetid://9968344227",
			ImageTransparency = 0.94,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 0,
		})

		mainFrame.Destroying:Connect(function()
			DisableAcrylicLighting()
		end)
	end

	local topBar = CreateInstance("Frame", {
		Name = "TopBar",
		Parent = mainFrame,
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local topBarDivider = CreateInstance("Frame", {
		Name = "Divider",
		Parent = topBar,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.75,
		BorderSizePixel = 0,
	})

	local headerContainer = CreateInstance("Frame", {
		Name = "Header",
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 0),
		Size = UDim2.new(1, -32, 1, 0),
	})

	CreateInstance("UIListLayout", {
		Parent = headerContainer,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = headerContainer,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Vanta",
		TextColor3 = theme.TitleColor,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})

	local descLabel = CreateInstance("TextLabel", {
		Name = "SubTitle",
		Parent = headerContainer,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.Gotham,
		Text = config.SubTitle or config.Description or "",
		TextColor3 = theme.DescColor,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})

	local verticalTabs = (windowSize.X.Offset / math.max(windowSize.Y.Offset, 1)) >= 1.3

	local tabsFrame = CreateInstance("Frame", {
		Name = "TabsFrame",
		Parent = mainFrame,
		Position = verticalTabs and UDim2.new(0, 0, 0, 50) or UDim2.new(0, 0, 0, 50),
		Size = verticalTabs and UDim2.new(0, tabWidth, 1, -50) or UDim2.new(1, 0, 0, 44),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local tabsDivider
	if verticalTabs then
		tabsDivider = CreateInstance("Frame", {
			Name = "TabsDivider",
			Parent = mainFrame,
			Position = UDim2.new(0, tabWidth, 0, 50),
			Size = UDim2.new(0, 1, 1, -50),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.75,
			BorderSizePixel = 0,
		})
	else
		tabsDivider = CreateInstance("Frame", {
			Name = "TabsDivider",
			Parent = mainFrame,
			Position = UDim2.new(0, 0, 0, 94),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.75,
			BorderSizePixel = 0,
		})
	end

	CreateInstance("UIListLayout", {
		Parent = tabsFrame,
		FillDirection = verticalTabs and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 4),
		HorizontalAlignment = verticalTabs and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Left,
		VerticalAlignment = verticalTabs and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	CreateInstance("UIPadding", {
		Parent = tabsFrame,
		PaddingTop = UDim.new(0, verticalTabs and 10 or 6),
		PaddingBottom = UDim.new(0, verticalTabs and 0 or 6),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local contentFrame = CreateInstance("Frame", {
		Name = "ContentFrame",
		Parent = mainFrame,
		Position = verticalTabs and UDim2.new(0, tabWidth, 0, 50) or UDim2.new(0, 0, 0, 94),
		Size = verticalTabs and UDim2.new(1, -tabWidth, 1, -50) or UDim2.new(1, 0, 1, -94),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	CreateInstance("UIPadding", {
		Parent = contentFrame,
		PaddingTop = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
	})

	MakeDraggable(topBar, mainFrame)

	local resizeHandle
	if config.Resize then
		resizeHandle = CreateInstance("Frame", {
			Name = "ResizeHandle",
			Parent = mainFrame,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, 0, 1, 0),
			Size = UDim2.new(0, 26, 0, 26),
			BackgroundTransparency = 1,
			ZIndex = 10,
		})

		local grip = CreateInstance("Frame", {
			Name = "Grip",
			Parent = resizeHandle,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -4, 1, -4),
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.3,
			ZIndex = 10,
		})

		CreateInstance("UICorner", {
			Parent = grip,
			CornerRadius = UDim.new(1, 0),
		})

		MakeResizable(resizeHandle, mainFrame, minSize, maxSize)
	end

	local iconButton
	local iconFrameStroke
	local iconCornerStroke
	if config.icno and config.icno.work then
		local hasImage = config.icno.IdIcon and config.icno.IdIcon ~= ""
		local iconSize = config.icno.Size or 44
		local innerImageSize = math.floor(iconSize * 0.9)
		local innerCornerSize = math.floor(iconSize * 0.45)

		local iconGui = CreateInstance("ScreenGui", {
			Name = "VantaIcon",
			Parent = PlayerGui,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			DisplayOrder = 1000,
		})

		iconButton = CreateInstance("TextButton", {
			Name = "IconToggle",
			Parent = iconGui,
			Position = UDim2.new(0, 40, 0, 40),
			Size = UDim2.new(0, iconSize, 0, iconSize),
			BackgroundColor3 = theme.Background,
			BackgroundTransparency = hasImage and 1 or theme.Transparency,
			Text = "",
			AutoButtonColor = false,
		})

		local iconCorner = CreateInstance("UICorner", {
			Parent = iconButton,
			CornerRadius = UDim.new(0, 12),
		})

		iconFrameStroke = CreateInstance("UIStroke", {
			Parent = iconButton,
			Color = theme.Accent,
			Thickness = 1,
			Transparency = hasImage and 1 or 0.3,
		})

		if hasImage then
			CreateInstance("ImageLabel", {
				Parent = iconButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, innerImageSize, 0, innerImageSize),
				BackgroundTransparency = 1,
				Image = config.icno.IdIcon,
			})
		else
			local corner = CreateInstance("Frame", {
				Name = "Corner",
				Parent = iconButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, innerCornerSize, 0, innerCornerSize),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			})

			CreateInstance("UICorner", {
				Parent = corner,
				CornerRadius = UDim.new(1, 0),
			})

			iconCornerStroke = CreateInstance("UIStroke", {
				Parent = corner,
				Color = theme.Accent,
				Thickness = 2,
				Transparency = 0,
			})
		end

		MakeDraggable(iconButton, iconButton)

		local iconDragged = false
		iconButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				iconDragged = false
			end
		end)

		iconButton.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				iconDragged = true
			end
		end)

		iconButton.MouseButton1Click:Connect(function()
			if not iconDragged then
				screenGui.Enabled = not screenGui.Enabled
			end
		end)
	end

	if config.MinimizeKey then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end
			if input.KeyCode == config.MinimizeKey then
				screenGui.Enabled = not screenGui.Enabled
			end
		end)
	end

	self.ScreenGui = screenGui
	self.MainFrame = mainFrame
	self.Stroke = stroke
	self.TopBar = topBar
	self.TitleLabel = titleLabel
	self.DescLabel = descLabel
	self.TabsFrame = tabsFrame
	self.ContentFrame = contentFrame
	self.TabsVertical = verticalTabs
	self.TabsDivider = tabsDivider
	self.Tabs = {}
	self.SectionLabels = {}
	self.Controls = {}
	self.Pages = {}
	self.TabButtons = {}
	self.TabObjects = {}
	self.ActiveTabName = nil
	self.ResizeHandle = resizeHandle
	self.IconButton = iconButton
	self.IconFrameStroke = iconFrameStroke
	self.IconCornerStroke = iconCornerStroke
	self.AcrylicCleanup = acrylicCleanup

	if not Library._ErrorHookConnected then
		Library._ErrorHookConnected = true

		local ok, ScriptContext = pcall(function()
			return game:GetService("ScriptContext")
		end)

		if ok and ScriptContext then
			ScriptContext.Error:Connect(function(message, trace, errScript)
				local scriptName = errScript and errScript.Name or "Unknown"

				self:Notify({
					Title = "خطأ بالكود",
					Content = tostring(message),
					SubContent = "Script: " .. tostring(scriptName),
					Duration = 7,
					icone = {Work = true, IdIcon = "", Type = "up"},
				})
			end)
		end
	end

	return self
end

