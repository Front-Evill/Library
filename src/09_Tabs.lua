local Tab = {}
Tab.__index = Tab

function Library:AddTab(tabConfig)
	tabConfig = tabConfig or {}

	if tabConfig[1] ~= nil then
		local created = {}
		for _, entry in ipairs(tabConfig) do
			local single = entry

			if typeof(entry) == "table" and not entry.Name and not entry.Title and not entry.Icon then
				single = { Name = entry[1], Icon = entry[2] }
			end

			local tabObject = self:AddTab(single)
			table.insert(created, tabObject)
			created[tabObject.Name] = tabObject
		end

		return created
	end

	local name = tabConfig.Name or tabConfig.Title or ("Tab " .. tostring(#self.Tabs + 1))
	local iconId = ResolveIcon(tabConfig.Icon)

	local button = CreateInstance("TextButton", {
		Name = name,
		Parent = self.TabsFrame,
		BackgroundColor3 = self.Theme.Accent,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		AutomaticSize = self.TabsVertical and Enum.AutomaticSize.None or Enum.AutomaticSize.X,
		Size = self.TabsVertical and UDim2.new(1, 0, 0, 34) or UDim2.new(0, 0, 1, 0),
		LayoutOrder = #self.Tabs + 1,
	})

	CreateInstance("UICorner", {
		Parent = button,
		CornerRadius = UDim.new(0, 8),
	})

	CreateInstance("UIPadding", {
		Parent = button,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local innerLayout = CreateInstance("UIListLayout", {
		Parent = button,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	CreateInstance("ImageLabel", {
		Name = "Icon",
		Parent = button,
		BackgroundTransparency = 1,
		Image = iconId,
		ImageColor3 = self.Theme.DescColor,
		Size = UDim2.new(0, 18, 0, 18),
		LayoutOrder = 1,
	})

	CreateInstance("TextLabel", {
		Name = "Label",
		Parent = button,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.Gotham,
		Text = name,
		TextColor3 = self.Theme.DescColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})

	local page = CreateInstance("Frame", {
		Name = name .. "Page",
		Parent = self.ContentFrame,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = false,
	})

	CreateInstance("UIListLayout", {
		Parent = page,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	table.insert(self.Tabs, name)
	self.Pages[name] = page
	self.TabButtons[name] = button

	button.MouseButton1Click:Connect(function()
		self:SelectTab(name)
	end)

	if #self.Tabs == 1 then
		self:SelectTab(name)
	end

	local tabObject = setmetatable({
		Name = name,
		Page = page,
		Button = button,
		Window = self,
	}, Tab)

	self.TabObjects[name] = tabObject

	return tabObject
end

function Tab:Select()
	self.Window:SelectTab(self.Name)
end

local Section = {}
Section.__index = Section

function Tab:AddSection(config)
	local text = "Section"
	local iconName = nil

	if type(config) == "string" then
		text = config
	elseif type(config) == "table" then
		text = config.Name or config.Text or text
		iconName = config.Icon
	end

	local sectionFrame = CreateInstance("Frame", {
		Name = "Section",
		Parent = self.Page,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Page:GetChildren(),
	})

	CreateInstance("UIListLayout", {
		Parent = sectionFrame,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local headerFrame = CreateInstance("Frame", {
		Name = "Header",
		Parent = sectionFrame,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 24),
		LayoutOrder = 1,
	})

	CreateInstance("UIListLayout", {
		Parent = headerFrame,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	if iconName and iconName ~= "" then
		CreateInstance("ImageLabel", {
			Name = "Icon",
			Parent = headerFrame,
			BackgroundTransparency = 1,
			Image = ResolveIcon(iconName),
			ImageColor3 = self.Window.Theme.SectionColor,
			Size = UDim2.new(0, 20, 0, 20),
			LayoutOrder = 1,
		})
	end

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = headerFrame,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = text,
		TextColor3 = self.Window.Theme.SectionColor,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})

	local elementsFrame = CreateInstance("Frame", {
		Name = "Elements",
		Parent = sectionFrame,
		BackgroundColor3 = self.Window.Theme.Secondary,
		BackgroundTransparency = self.Window.Theme.Transparency,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = true,
		LayoutOrder = 2,
	})

	CreateInstance("UICorner", {
		Parent = elementsFrame,
		CornerRadius = UDim.new(0, 10),
	})

	local elementsStroke = CreateInstance("UIStroke", {
		Parent = elementsFrame,
		Color = self.Window.Theme.Accent,
		Thickness = 1,
		Transparency = 0.6,
	})

	CreateInstance("UIPadding", {
		Parent = elementsFrame,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	CreateInstance("UIListLayout", {
		Parent = elementsFrame,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	table.insert(self.Window.Controls, function(theme2)
		elementsFrame.BackgroundColor3 = theme2.Secondary
		elementsFrame.BackgroundTransparency = theme2.Transparency
		elementsStroke.Color = theme2.Accent
	end)

	table.insert(self.Window.SectionLabels, titleLabel)

	local sectionIcon = headerFrame:FindFirstChild("Icon")
	if sectionIcon then
		table.insert(self.Window.SectionLabels, sectionIcon)
	end

	local sectionObject = setmetatable({
		Name = text,
		Frame = sectionFrame,
		TitleLabel = titleLabel,
		Container = elementsFrame,
		Tab = self,
		Window = self.Window,
	}, Section)

	return sectionObject
end

