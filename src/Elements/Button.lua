function Section:AddButton(config)
	config = config or {}
	local theme = self.Window.Theme

	local row = CreateInstance("TextButton", {
		Name = "Button",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local stroke = CreateInstance("UIStroke", {
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

	local title = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Button",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		title.Size = UDim2.new(1, 0, 0, 16)
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
	end

	row.MouseEnter:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseLeave:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Background
	end)

	row.MouseButton1Down:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Accent
	end)

	row.MouseButton1Up:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseButton1Click:Connect(function()
		local function runCallback()
			if config.Callback then
				local ok, err = pcall(config.Callback)
				if not ok then
					warn("Vanta Button Callback Error: " .. tostring(err))
				end
			end
		end

		if config.Confirm then
			local dialogButtons = config.Confirm.Buttons

			if not dialogButtons then
				dialogButtons = {
					{
						Title = config.Confirm.ConfirmText or "تأكيد",
						Callback = runCallback,
					},
					{
						Title = config.Confirm.CancelText or "إلغاء",
						Callback = config.Confirm.CancelCallback,
					},
				}
			end

			self.Window:Dialog({
				Title = config.Confirm.Title or "تأكيد",
				Content = config.Confirm.Content or ('متأكد إنك تبي تنفذ "' .. (config.Name or "هذا الإجراء") .. '"؟'),
				Buttons = dialogButtons,
			})
		else
			runCallback()
		end
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		stroke.Color = theme2.Accent
		title.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
	end)

	return {
		Frame = row,
		Name = config.Name,
	}
end

