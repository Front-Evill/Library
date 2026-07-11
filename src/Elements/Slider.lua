function Section:AddSlider(name, config)
	config = config or {}
	local theme = self.Window.Theme

	local title = config.Title or name or "Slider"
	local min = config.Min or 0
	local max = config.Max or 100
	local rounding = config.Rounding or 0

	local function roundValue(v)
		local mult = 10 ^ rounding
		return math.floor(v * mult + 0.5) / mult
	end

	local value = roundValue(math.clamp(config.Default or min, min, max))

	local row = CreateInstance("Frame", {
		Name = "Slider",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local rowStroke = CreateInstance("UIStroke", {
		Parent = row,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.7,
	})

	CreateInstance("UIPadding", {
		Parent = row,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 14),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, -50, 0, 16),
		Font = Enum.Font.Gotham,
		Text = title,
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local valueLabel = CreateInstance("TextLabel", {
		Name = "Value",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 50, 0, 16),
		Font = Enum.Font.GothamBold,
		Text = tostring(value),
		TextColor3 = theme.Accent,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Right,
	})

	local hasDescription = config.Description and config.Description ~= ""
	local trackYOffset = 24

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = row,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, 0, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		trackYOffset = 40
	end

	local track = CreateInstance("Frame", {
		Name = "Track",
		Parent = row,
		Position = UDim2.new(0, 0, 0, trackYOffset),
		Size = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = theme.Secondary,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = track,
		CornerRadius = UDim.new(1, 0),
	})

	local fill = CreateInstance("Frame", {
		Name = "Fill",
		Parent = track,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = fill,
		CornerRadius = UDim.new(1, 0),
	})

	local knob = CreateInstance("Frame", {
		Name = "Knob",
		Parent = track,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 14, 0, 14),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	CreateInstance("UICorner", {
		Parent = knob,
		CornerRadius = UDim.new(1, 0),
	})

	local function updateVisual()
		local ratio = (value - min) / math.max(max - min, 0.0001)
		fill.Size = UDim2.new(ratio, 0, 1, 0)
		knob.Position = UDim2.new(ratio, 0, 0.5, 0)
		valueLabel.Text = tostring(value)
	end
	updateVisual()

	local dragging = false

	local function setFromInputX(inputX, fireCallback)
		local absPos = track.AbsolutePosition.X
		local absSize = math.max(track.AbsoluteSize.X, 1)
		local ratio = math.clamp((inputX - absPos) / absSize, 0, 1)
		local raw = min + (max - min) * ratio
		local newValue = math.clamp(roundValue(raw), min, max)

		if newValue ~= value then
			value = newValue
			updateVisual()
			if fireCallback and config.Callback then
				local ok, err = pcall(config.Callback, value)
				if not ok then
					warn("Vanta Slider Callback Error: " .. tostring(err))
				end
			end
		end
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			setFromInputX(input.Position.X, true)

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			setFromInputX(input.Position.X, true)
		end
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		valueLabel.TextColor3 = theme2.Accent
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		track.BackgroundColor3 = theme2.Secondary
		fill.BackgroundColor3 = theme2.Accent
	end)

	return {
		Frame = row,
		Name = title,
		Set = function(_, newValue)
			value = math.clamp(roundValue(newValue), min, max)
			updateVisual()
		end,
		Get = function()
			return value
		end,
	}
end

