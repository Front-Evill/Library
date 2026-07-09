local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Library = {}
Library.__index = Library

local ActiveAcrylicCount = 0

local function EnableAcrylicLighting()
	ActiveAcrylicCount = ActiveAcrylicCount + 1

	local existing = Lighting:FindFirstChild("VantaAcrylicDOF")
	if existing then
		return
	end

	local dof = Instance.new("DepthOfFieldEffect")
	dof.Name = "VantaAcrylicDOF"
	dof.FarIntensity = 0
	dof.NearIntensity = 1
	dof.InFocusRadius = 0.1
	dof.FocusDistance = 0.05
	dof.Parent = Lighting
end

local function DisableAcrylicLighting()
	ActiveAcrylicCount = math.max(0, ActiveAcrylicCount - 1)

	if ActiveAcrylicCount == 0 then
		local existing = Lighting:FindFirstChild("VantaAcrylicDOF")
		if existing then
			existing:Destroy()
		end
	end
end

local function CreateGlassPart()
	local part = Instance.new("Part")
	part.Name = "VantaGlass"
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CastShadow = false
	part.Locked = true
	part.Material = Enum.Material.Glass
	part.Color = Color3.new(0, 0, 0)
	part.Transparency = 0.98
	part.Size = Vector3.new(1, 1, 0)

	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Brick
	mesh.Offset = Vector3.new(0, 0, -0.0001)
	mesh.Parent = part

	return part, mesh
end

local function AttachAcrylicGlass(frame, screenGui)
	local camera = Workspace.CurrentCamera
	if not camera then
		return nil
	end

	local part, mesh = CreateGlassPart()
	part.Parent = camera

	local distance = 0.05
	local inset = 3
	local connections = {}
	local running = true

	local function project(point2D)
		local cam = Workspace.CurrentCamera
		if not cam then
			return Vector3.new()
		end
		local ray = cam:ScreenPointToRay(point2D.X, point2D.Y)
		return ray.Origin + ray.Direction * distance
	end

	local function update()
		if not running then
			return
		end

		local cam = Workspace.CurrentCamera
		if not cam or not part.Parent then
			return
		end

		local ok = pcall(function()
			local absPos = frame.AbsolutePosition
			local absSize = frame.AbsoluteSize

			local topLeft = absPos + Vector2.new(inset, inset)
			local topRight = topLeft + Vector2.new(math.max(absSize.X - inset * 2, 1), 0)
			local bottomRight = topLeft + Vector2.new(math.max(absSize.X - inset * 2, 1), math.max(absSize.Y - inset * 2, 1))

			local p1 = project(topLeft)
			local p2 = project(topRight)
			local p3 = project(bottomRight)

			local width = (p2 - p1).Magnitude
			local height = (p2 - p3).Magnitude

			part.CFrame = CFrame.fromMatrix((p1 + p3) / 2, cam.CFrame.XVector, cam.CFrame.YVector, cam.CFrame.ZVector)
			mesh.Scale = Vector3.new(width, height, 0)
		end)

		if not ok then
			part.Transparency = 1
		end
	end

	connections[#connections + 1] = RunService.RenderStepped:Connect(update)

	connections[#connections + 1] = screenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		part.Transparency = screenGui.Enabled and 0.98 or 1
	end)

	local function cleanup()
		running = false
		for _, connection in ipairs(connections) do
			pcall(function()
				connection:Disconnect()
			end)
		end
		if part then
			part:Destroy()
		end
	end

	frame.Destroying:Connect(cleanup)
	update()

	return part, cleanup
end

local function ToColor3(value)
	if typeof(value) == "Color3" then
		return value
	end

	if typeof(value) == "string" then
		local hex = value:gsub("#", "")
		if #hex == 3 then
			local r = hex:sub(1, 1)
			local g = hex:sub(2, 2)
			local b = hex:sub(3, 3)
			hex = r .. r .. g .. g .. b .. b
		end
		local r = tonumber(hex:sub(1, 2), 16) or 255
		local g = tonumber(hex:sub(3, 4), 16) or 255
		local b = tonumber(hex:sub(5, 6), 16) or 255
		return Color3.fromRGB(r, g, b)
	end

	if typeof(value) == "table" then
		if value.R and value.G and value.B then
			return Color3.fromRGB(value.R, value.G, value.B)
		end
		if value[1] and value[2] and value[3] then
			return Color3.fromRGB(value[1], value[2], value[3])
		end
	end

	return Color3.fromRGB(255, 255, 255)
end

local function ResolveTheme(theme)
	local resolved = {}
	for key, value in pairs(theme) do
		if key == "Transparency" then
			resolved[key] = value
		else
			resolved[key] = ToColor3(value)
		end
	end
	return resolved
end

Library.Presets = {
	Dark = {
		Accent = Color3.fromRGB(90, 90, 100),
		Background = Color3.fromRGB(18, 18, 22),
		Secondary = Color3.fromRGB(26, 26, 31),
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = Color3.fromRGB(160, 160, 168),
		Transparency = 0.78,
	},
	Purple = {
		Accent = Color3.fromRGB(140, 90, 255),
		Background = Color3.fromRGB(22, 18, 30),
		Secondary = Color3.fromRGB(32, 26, 42),
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = Color3.fromRGB(180, 165, 200),
		Transparency = 0.78,
	},
	Rose = {
		Accent = Color3.fromRGB(255, 90, 130),
		Background = Color3.fromRGB(28, 18, 22),
		Secondary = Color3.fromRGB(40, 24, 30),
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = Color3.fromRGB(200, 165, 175),
		Transparency = 0.78,
	},
	Blue = {
		Accent = Color3.fromRGB(80, 140, 255),
		Background = Color3.fromRGB(16, 20, 28),
		Secondary = Color3.fromRGB(22, 28, 38),
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = Color3.fromRGB(160, 175, 200),
		Transparency = 0.78,
	},
	Green = {
		Accent = Color3.fromRGB(80, 220, 150),
		Background = Color3.fromRGB(16, 22, 20),
		Secondary = Color3.fromRGB(22, 32, 28),
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = Color3.fromRGB(160, 195, 180),
		Transparency = 0.78,
	},
}

local function CreateInstance(className, properties)
	local inst = Instance.new(className)
	for prop, value in pairs(properties) do
		inst[prop] = value
	end
	return inst
end

local function MakeDraggable(dragHandle, target)
	local dragging = false
	local dragStart
	local startPos

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				local delta = input.Position - dragStart
				target.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)
end

local function MakeResizable(handle, target, minSize, maxSize)
	local resizing = false
	local dragStart
	local startSize

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			dragStart = input.Position
			startSize = target.Size

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if resizing then
				local delta = input.Position - dragStart
				local newWidth = math.clamp(startSize.X.Offset + delta.X, minSize.X, maxSize.X)
				local newHeight = math.clamp(startSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)
				target.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
	end)
end

function Library:Window(config)
	config = config or {}

	local rawTheme = {}
	for key, value in pairs(Library.Presets.Dark) do
		rawTheme[key] = value
	end

	if type(config.Theme) == "string" then
		local preset = Library.Presets[config.Theme]
		if preset then
			for key, value in pairs(preset) do
				rawTheme[key] = value
			end
		end
	elseif type(config.Theme) == "table" then
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
		BackgroundTransparency = 1,
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
		BackgroundColor3 = theme.Secondary,
		BackgroundTransparency = theme.Transparency,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = topBar,
		CornerRadius = UDim.new(0, 10),
	})

	local topBarFix = CreateInstance("Frame", {
		Parent = topBar,
		Size = UDim2.new(1, 0, 0, 10),
		Position = UDim2.new(0, 0, 1, -10),
		BackgroundColor3 = theme.Secondary,
		BackgroundTransparency = theme.Transparency,
		BorderSizePixel = 0,
		ZIndex = 0,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 6),
		Size = UDim2.new(1, -32, 0, 20),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Vanta",
		TextColor3 = theme.TitleColor,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel = CreateInstance("TextLabel", {
		Name = "SubTitle",
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 26),
		Size = UDim2.new(1, -32, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.SubTitle or config.Description or "",
		TextColor3 = theme.DescColor,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local tabsFrame = CreateInstance("Frame", {
		Name = "TabsFrame",
		Parent = mainFrame,
		Position = UDim2.new(0, 0, 0, 50),
		Size = UDim2.new(0, tabWidth, 1, -50),
		BackgroundColor3 = theme.Secondary,
		BackgroundTransparency = theme.Transparency,
		BorderSizePixel = 0,
	})

	CreateInstance("UIListLayout", {
		Parent = tabsFrame,
		Padding = UDim.new(0, 4),
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	CreateInstance("UIPadding", {
		Parent = tabsFrame,
		PaddingTop = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local contentFrame = CreateInstance("Frame", {
		Name = "ContentFrame",
		Parent = mainFrame,
		Position = UDim2.new(0, tabWidth, 0, 50),
		Size = UDim2.new(1, -tabWidth, 1, -50),
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = theme.Transparency,
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
	if config.icno and config.icno.work then
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
			Size = UDim2.new(0, 44, 0, 44),
			BackgroundColor3 = theme.Background,
			BackgroundTransparency = theme.Transparency,
			Text = "",
			AutoButtonColor = false,
		})

		CreateInstance("UICorner", {
			Parent = iconButton,
			CornerRadius = UDim.new(0, 12),
		})

		CreateInstance("UIStroke", {
			Parent = iconButton,
			Color = theme.Accent,
			Thickness = 1,
			Transparency = 0.3,
		})

		local corner = CreateInstance("Frame", {
			Name = "Corner",
			Parent = iconButton,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 20, 0, 20),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		})

		CreateInstance("UICorner", {
			Parent = corner,
			CornerRadius = UDim.new(1, 0),
		})

		CreateInstance("UIStroke", {
			Parent = corner,
			Color = theme.Accent,
			Thickness = 2,
			Transparency = 0,
		})

		if config.icno.IdIcon and config.icno.IdIcon ~= "" then
			CreateInstance("ImageLabel", {
				Parent = iconButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, 26, 0, 26),
				BackgroundTransparency = 1,
				Image = config.icno.IdIcon,
			})
			corner.Visible = false
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
	self.TopBarFix = topBarFix
	self.TitleLabel = titleLabel
	self.DescLabel = descLabel
	self.TabsFrame = tabsFrame
	self.ContentFrame = contentFrame
	self.ResizeHandle = resizeHandle
	self.IconButton = iconButton
	self.AcrylicCleanup = acrylicCleanup

	return self
end

function Library:SetTheme(newTheme)
	local rawTheme = newTheme

	if type(newTheme) == "string" then
		rawTheme = Library.Presets[newTheme] or {}
	end

	local resolved = ResolveTheme(rawTheme)
	for key, value in pairs(resolved) do
		self.Theme[key] = value
	end

	self.Stroke.Color = self.Theme.Accent
	self.TopBar.BackgroundColor3 = self.Theme.Secondary
	self.TopBar.BackgroundTransparency = self.Theme.Transparency
	self.TopBarFix.BackgroundColor3 = self.Theme.Secondary
	self.TopBarFix.BackgroundTransparency = self.Theme.Transparency
	self.TabsFrame.BackgroundColor3 = self.Theme.Secondary
	self.TabsFrame.BackgroundTransparency = self.Theme.Transparency
	self.ContentFrame.BackgroundColor3 = self.Theme.Background
	self.ContentFrame.BackgroundTransparency = self.Theme.Transparency
	self.TitleLabel.TextColor3 = self.Theme.TitleColor
	self.DescLabel.TextColor3 = self.Theme.DescColor
end

function Library:SetTitle(text)
	self.TitleLabel.Text = text
end

function Library:SetSubTitle(text)
	self.DescLabel.Text = text
end

function Library:Destroy()
	if self.IconButton and self.IconButton.Parent then
		self.IconButton.Parent:Destroy()
	end
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

return Library
