function Section:AddInput(name, config)
	config = config or {}
	local theme = self.Window.Theme
	local title = config.Title or name or "Input"

	local row = CreateInstance("Frame", {
		Name = "Input",
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
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local hasDescription = config.Description and config.Description ~= ""

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		Font = Enum.Font.Gotham,
		Text = title,
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	local boxYOffset = 22

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
		boxYOffset = 38
	end

	local inputBox = CreateInstance("Frame", {
		Name = "InputBox",
		Parent = row,
		Position = UDim2.new(0, 0, 0, boxYOffset),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = theme.Secondary,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = inputBox,
		CornerRadius = UDim.new(0, 5),
	})

	local inputBoxStroke = CreateInstance("UIStroke", {
		Parent = inputBox,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.6,
	})

	local textBox = CreateInstance("TextBox", {
		Name = "TextBox",
		Parent = inputBox,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Font = Enum.Font.Gotham,
		Text = config.Default or "",
		PlaceholderText = config.Placeholder or "",
		TextColor3 = theme.TitleColor,
		PlaceholderColor3 = theme.DescColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
	})

	local currentValue = config.Default or ""

	local function sanitizeNumeric(text)
		local cleaned = text:gsub("[^%d%.%-]", "")
		return cleaned
	end

	local function fireCallback(value)
		if config.Callback then
			local ok, err = pcall(config.Callback, value)
			if not ok then
				warn("Vanta Input Callback Error: " .. tostring(err))
			end
		end
	end

	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		if config.Numeric then
			local sanitized = sanitizeNumeric(textBox.Text)
			if sanitized ~= textBox.Text then
				textBox.Text = sanitized
				return
			end
		end

		currentValue = textBox.Text

		if not config.Finished then
			fireCallback(currentValue)
		end
	end)

	textBox.Focused:Connect(function()
		inputBoxStroke.Transparency = 0.2
	end)

	textBox.FocusLost:Connect(function(enterPressed)
		currentValue = textBox.Text
		inputBoxStroke.Transparency = 0.6

		if config.Finished and enterPressed then
			fireCallback(currentValue)
		end
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		inputBox.BackgroundColor3 = theme2.Secondary
		inputBoxStroke.Color = theme2.Accent
		textBox.TextColor3 = theme2.TitleColor
		textBox.PlaceholderColor3 = theme2.DescColor
	end)

	return {
		Frame = row,
		Set = function(_, newValue)
			textBox.Text = tostring(newValue)
			currentValue = textBox.Text
		end,
		Get = function()
			return currentValue
		end,
	}
end

