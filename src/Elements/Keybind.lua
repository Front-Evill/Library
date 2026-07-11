function Section:AddKeybind(name, config)
	config = config or {}
	local theme = self.Window.Theme
	local title = config.Title or name or "Keybind"
	local mode = config.Mode or "Toggle"

	local boundValue, boundType = ResolveKeybind(config.Default)
	local toggledState = false
	local listening = false

	local row = CreateInstance("Frame", {
		Name = "Keybind",
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
		Size = UDim2.new(1, -90, 0, 16),
		Font = Enum.Font.Gotham,
		Text = title,
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
			Size = UDim2.new(1, -90, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local keyButton = CreateInstance("TextButton", {
		Name = "KeyButton",
		Parent = row,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 80, 0, 24),
		BackgroundColor3 = theme.Secondary,
		BackgroundTransparency = 0,
		Text = KeybindDisplayName(boundValue, boundType),
		Font = Enum.Font.GothamBold,
		TextColor3 = theme.Accent,
		TextSize = 12,
		AutoButtonColor = false,
	})

	CreateInstance("UICorner", {
		Parent = keyButton,
		CornerRadius = UDim.new(0, 5),
	})

	local keyButtonStroke = CreateInstance("UIStroke", {
		Parent = keyButton,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.5,
	})

	local function setToggled(newState, fireCallback)
		toggledState = newState

		if fireCallback and config.Callback then
			local ok, err = pcall(config.Callback, toggledState)
			if not ok then
				warn("Vanta Keybind Callback Error: " .. tostring(err))
			end
		end
	end

	local inputBeganConn, inputEndedConn

	local function matchesBound(input)
		if not boundValue then
			return false
		end
		if boundType == "KeyCode" then
			return input.KeyCode == boundValue
		elseif boundType == "MouseButton" then
			return input.UserInputType == boundValue
		end
		return false
	end

	inputBeganConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if listening or gameProcessed then
			return
		end

		if matchesBound(input) then
			if mode == "Always" then
				setToggled(true, true)
			elseif mode == "Toggle" then
				setToggled(not toggledState, true)
			elseif mode == "Hold" then
				setToggled(true, true)
			end
		end
	end)

	inputEndedConn = UserInputService.InputEnded:Connect(function(input, gameProcessed)
		if listening then
			return
		end

		if mode == "Hold" and matchesBound(input) then
			setToggled(false, true)
		end
	end)

	keyButton.MouseButton1Click:Connect(function()
		if listening then
			return
		end

		listening = true
		keyButton.Text = "..."

		local listenConn
		listenConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if input.KeyCode == Enum.KeyCode.Escape then
				listening = false
				keyButton.Text = KeybindDisplayName(boundValue, boundType)
				listenConn:Disconnect()
				return
			end

			local newValue, newType

			if input.UserInputType == Enum.UserInputType.Keyboard then
				newValue, newType = input.KeyCode, "KeyCode"
			elseif input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.MouseButton2
				or input.UserInputType == Enum.UserInputType.MouseButton3 then
				newValue, newType = input.UserInputType, "MouseButton"
			end

			if newValue then
				boundValue = newValue
				boundType = newType
				keyButton.Text = KeybindDisplayName(boundValue, boundType)
				listening = false
				listenConn:Disconnect()

				if config.ChangedCallback then
					local ok, err = pcall(config.ChangedCallback, boundValue)
					if not ok then
						warn("Vanta Keybind ChangedCallback Error: " .. tostring(err))
					end
				end
			end
		end)
	end)

	keyButton.MouseEnter:Connect(function()
		keyButton.BackgroundColor3 = self.Window.Theme.Accent
	end)

	keyButton.MouseLeave:Connect(function()
		keyButton.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		keyButton.BackgroundColor3 = theme2.Secondary
		keyButton.TextColor3 = theme2.Accent
		keyButtonStroke.Color = theme2.Accent
	end)

	return {
		Frame = row,
		Set = function(_, newKeyName)
			local v, t = ResolveKeybind(newKeyName)
			if v then
				boundValue = v
				boundType = t
				keyButton.Text = KeybindDisplayName(boundValue, boundType)
			end
		end,
		Get = function()
			return boundValue
		end,
		GetState = function()
			return toggledState
		end,
	}
end

