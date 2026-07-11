function Section:AddToggle(config)
	config = config or {}
	local theme = self.Window.Theme
	local value = config.Default == true

	local row = CreateInstance("Frame", {
		Name = "Toggle",
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

	local textContainer = CreateInstance("Frame", {
		Name = "TextContainer",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -56, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	local title = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = textContainer,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Toggle",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = textContainer,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, 0, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local switchBg = CreateInstance("Frame", {
		Name = "Switch",
		Parent = row,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 40, 0, 22),
		BackgroundColor3 = value and theme.Accent or theme.Background,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = switchBg,
		CornerRadius = UDim.new(1, 0),
	})

	local knob = CreateInstance("Frame", {
		Name = "Knob",
		Parent = switchBg,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
		Size = UDim2.new(0, 18, 0, 18),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = knob,
		CornerRadius = UDim.new(1, 0),
	})

	local clickArea = CreateInstance("TextButton", {
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		AutoButtonColor = false,
	})

	local function setValue(newValue, fireCallback)
		value = newValue
		local currentTheme = self.Window.Theme

		local targetPos = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
		local targetColor = value and currentTheme.Accent or currentTheme.Background

		TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = targetPos,
		}):Play()

		TweenService:Create(switchBg, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = targetColor,
		}):Play()

		if fireCallback and config.Callback then
			local ok, err = pcall(config.Callback, value)
			if not ok then
				warn("Vanta Toggle Callback Error: " .. tostring(err))
			end
		end
	end

	clickArea.MouseButton1Click:Connect(function()
		setValue(not value, true)
	end)

	row.MouseEnter:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseLeave:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Background
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		title.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		switchBg.BackgroundColor3 = value and theme2.Accent or theme2.Background
	end)

	return {
		Frame = row,
		Name = config.Name,
		Set = function(_, newValue)
			setValue(newValue, false)
		end,
		Get = function()
			return value
		end,
	}
end

