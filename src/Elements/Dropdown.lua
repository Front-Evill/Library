function Section:_BuildDropdown(config, isMulti)
	config = config or {}
	local theme = self.Window.Theme
	local options = config.Options or {}
	local placeholder = config.Placeholder or "Select..."

	local selectedSet = {}
	local selectedSingle = nil

	if isMulti then
		if typeof(config.Default) == "table" then
			for _, v in ipairs(config.Default) do
				selectedSet[v] = true
			end
		end
	else
		selectedSingle = config.Default
	end

	local row = CreateInstance("Frame", {
		Name = isMulti and "MultiDropdown" or "Dropdown",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = true,
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
	local headerHeight = hasDescription and 34 or 16

	local header = CreateInstance("TextButton", {
		Name = "Header",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, headerHeight),
		Text = "",
		AutoButtonColor = false,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, -100, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Dropdown",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = row,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, -100, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local chevron = CreateInstance("ImageLabel", {
		Name = "Chevron",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 1),
		Size = UDim2.new(0, 14, 0, 14),
		Image = ResolveIcon("chevron-down"),
		ImageColor3 = theme.DescColor,
	})

	local valueLabel = CreateInstance("TextLabel", {
		Name = "Value",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -20, 0, 0),
		Size = UDim2.new(0, 80, 0, 16),
		Font = Enum.Font.Gotham,
		Text = placeholder,
		TextColor3 = theme.Accent,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	local optionsContainer = CreateInstance("Frame", {
		Name = "Options",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, headerHeight + 8),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Visible = false,
	})

	CreateInstance("UIListLayout", {
		Parent = optionsContainer,
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local optionRows = {}

	local function updateDisplay()
		if isMulti then
			local list = {}
			for _, optionName in ipairs(options) do
				if selectedSet[optionName] then
					table.insert(list, optionName)
				end
			end
			valueLabel.Text = (#list == 0) and placeholder or table.concat(list, ", ")
		else
			valueLabel.Text = (selectedSingle == nil or selectedSingle == "") and placeholder or tostring(selectedSingle)
		end
	end

	local isOpen = false
	local function setOpen(open)
		isOpen = open

		TweenService:Create(chevron, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Rotation = open and 180 or 0,
		}):Play()

		if open then
			optionsContainer.Visible = true

			local openEntries = {}
			for _, opt in ipairs(optionRows) do
				opt.Frame.BackgroundTransparency = 1
				opt.Label.TextTransparency = 1
				table.insert(openEntries, { instance = opt.Frame, prop = "BackgroundTransparency", target = 0 })
				table.insert(openEntries, { instance = opt.Label, prop = "TextTransparency", target = 0 })

				if opt.Check then
					opt.Check.ImageTransparency = 1
					table.insert(openEntries, {
						instance = opt.Check,
						prop = "ImageTransparency",
						target = selectedSet[opt.Name] and 0 or 1,
					})
				end
			end

			FadeTransparency(openEntries, 0.15, Enum.EasingDirection.Out)
		else
			local closeEntries = {}
			for _, opt in ipairs(optionRows) do
				table.insert(closeEntries, { instance = opt.Frame, prop = "BackgroundTransparency", target = 1 })
				table.insert(closeEntries, { instance = opt.Label, prop = "TextTransparency", target = 1 })

				if opt.Check then
					table.insert(closeEntries, { instance = opt.Check, prop = "ImageTransparency", target = 1 })
				end
			end

			FadeTransparency(closeEntries, 0.12, Enum.EasingDirection.In)

			task.delay(0.12, function()
				if not isOpen then
					optionsContainer.Visible = false
				end
			end)
		end
	end

	header.MouseButton1Click:Connect(function()
		setOpen(not isOpen)
	end)

	for _, optionName in ipairs(options) do
		local optionRow = CreateInstance("TextButton", {
			Name = "Option",
			Parent = optionsContainer,
			BackgroundColor3 = theme.Secondary,
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, 0, 28),
			Text = "",
			AutoButtonColor = false,
			LayoutOrder = #optionsContainer:GetChildren(),
		})

		CreateInstance("UICorner", {
			Parent = optionRow,
			CornerRadius = UDim.new(0, 5),
		})

		local optionLabel = CreateInstance("TextLabel", {
			Parent = optionRow,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -34, 1, 0),
			Font = Enum.Font.Gotham,
			Text = optionName,
			TextColor3 = theme.TitleColor,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local checkIcon
		if isMulti then
			checkIcon = CreateInstance("ImageLabel", {
				Parent = optionRow,
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -8, 0.5, 0),
				Size = UDim2.new(0, 16, 0, 16),
				Image = ResolveIcon("check"),
				ImageColor3 = theme.Accent,
				ImageTransparency = selectedSet[optionName] and 0 or 1,
			})
		end

		optionRow.MouseEnter:Connect(function()
			optionRow.BackgroundColor3 = self.Window.Theme.Background
		end)

		optionRow.MouseLeave:Connect(function()
			optionRow.BackgroundColor3 = self.Window.Theme.Secondary
		end)

		optionRow.MouseButton1Click:Connect(function()
			if isMulti then
				selectedSet[optionName] = not selectedSet[optionName]
				checkIcon.ImageTransparency = selectedSet[optionName] and 0 or 1
				updateDisplay()

				if config.Callback then
					local list = {}
					for _, name in ipairs(options) do
						if selectedSet[name] then
							table.insert(list, name)
						end
					end
					local ok, err = pcall(config.Callback, list)
					if not ok then
						warn("Vanta Dropdown Callback Error: " .. tostring(err))
					end
				end
			else
				selectedSingle = optionName
				updateDisplay()
				setOpen(false)

				if config.Callback then
					local ok, err = pcall(config.Callback, selectedSingle)
					if not ok then
						warn("Vanta Dropdown Callback Error: " .. tostring(err))
					end
				end
			end
		end)

		table.insert(optionRows, { Frame = optionRow, Label = optionLabel, Check = checkIcon, Name = optionName })
	end

	updateDisplay()

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		valueLabel.TextColor3 = theme2.Accent
		chevron.ImageColor3 = theme2.DescColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		for _, opt in ipairs(optionRows) do
			opt.Frame.BackgroundColor3 = theme2.Secondary
			opt.Label.TextColor3 = theme2.TitleColor
			if opt.Check then
				opt.Check.ImageColor3 = theme2.Accent
			end
		end
	end)

	return {
		Frame = row,
		Set = function(_, newValue)
			if isMulti then
				selectedSet = {}
				if typeof(newValue) == "table" then
					for _, v in ipairs(newValue) do
						selectedSet[v] = true
					end
				end
				for _, opt in ipairs(optionRows) do
					if opt.Check then
						opt.Check.ImageTransparency = selectedSet[opt.Name] and 0 or 1
					end
				end
			else
				selectedSingle = newValue
			end
			updateDisplay()
		end,
		Get = function()
			if isMulti then
				local list = {}
				for _, optionName in ipairs(options) do
					if selectedSet[optionName] then
						table.insert(list, optionName)
					end
				end
				return list
			end
			return selectedSingle
		end,
	}
end

function Section:AddDropdown(config)
	return self:_BuildDropdown(config, false)
end

function Section:AddMultiDropdown(config)
	return self:_BuildDropdown(config, true)
end

