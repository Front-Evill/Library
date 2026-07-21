local Utils = require(script.Parent.Utils)
local CreateInstance = Utils.CreateInstance

local IconsModule = require(script.Parent.Icons)
local ResolveIcon = IconsModule.ResolveIcon

local Section = require(script.Parent.Section)

local Tab = {}
Tab.__index = Tab


function Tab:Select()
	self.Window:SelectTab(self.Name)
end


function Tab:AddSection(config)
	local text = "Section"
	local iconName = nil
	local boxEnabled = true

	if type(config) == "string" then
		text = config
	elseif type(config) == "table" then
		text = config.Name or config.Text or text
		iconName = config.Icon
		if config.Box == false then
			boxEnabled = false
		end
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
		BackgroundTransparency = boxEnabled and self.Window.Theme.Transparency or 1,
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
		Transparency = boxEnabled and 0.6 or 1,
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
		elementsFrame.BackgroundTransparency = boxEnabled and theme2.Transparency or 1
		elementsStroke.Color = theme2.Accent
		elementsStroke.Transparency = boxEnabled and 0.6 or 1
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
		Box = boxEnabled,
		Tab = self,
		Window = self.Window,
	}, Section)

	return sectionObject
end


return Tab
