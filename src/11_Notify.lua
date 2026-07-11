function Library:Notify(config)
	config = config or {}

	local iconCfg = config.icone

	if iconCfg == true then
		iconCfg = { Work = true, IdIcon = "", Type = "up" }
	elseif iconCfg == false or iconCfg == nil then
		iconCfg = { Work = false }
	end
	local position = iconCfg.Type == "down" and "down" or "up"
	local container = self:GetNotifyContainer(position)

	self.NotifyOrder = (self.NotifyOrder or 0) + 1

	local fadeEntries = {}

	local card = CreateInstance("Frame", {
		Name = "Notification",
		Parent = container,
		BackgroundColor3 = self.Theme.Background,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = self.NotifyOrder,
		BorderSizePixel = 0,
	})
	table.insert(fadeEntries, { instance = card, prop = "BackgroundTransparency", target = self.Theme.Transparency })

	CreateInstance("UICorner", {
		Parent = card,
		CornerRadius = UDim.new(0, 10),
	})

	local cardStroke = CreateInstance("UIStroke", {
		Parent = card,
		Color = self.Theme.Accent,
		Thickness = 1,
		Transparency = 1,
	})
	table.insert(fadeEntries, { instance = cardStroke, prop = "Transparency", target = 0.3 })

	CreateInstance("UIPadding", {
		Parent = card,
		PaddingTop = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
	})

	local hasIcon = iconCfg.Work == true

	local textOffset = 0
	if hasIcon then
		textOffset = 32

		local iconId = (iconCfg.IdIcon and iconCfg.IdIcon ~= "") and ResolveIcon(iconCfg.IdIcon) or ResolveIcon("alert-triangle")

		local iconLabel = CreateInstance("ImageLabel", {
			Name = "Icon",
			Parent = card,
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			Image = iconId,
			ImageColor3 = self.Theme.Accent,
			Position = UDim2.new(0, 0, 0, 2),
			Size = UDim2.new(0, 22, 0, 22),
		})
		table.insert(fadeEntries, { instance = iconLabel, prop = "ImageTransparency", target = 0 })
	end

	local textContainer = CreateInstance("Frame", {
		Name = "TextContainer",
		Parent = card,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, textOffset, 0, 0),
		Size = UDim2.new(1, -textOffset, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	CreateInstance("UIListLayout", {
		Parent = textContainer,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = textContainer,
		BackgroundTransparency = 1,
		TextTransparency = 1,
		Size = UDim2.new(1, 0, 0, 18),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Notification",
		TextColor3 = self.Theme.TitleColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		LayoutOrder = 1,
	})
	table.insert(fadeEntries, { instance = titleLabel, prop = "TextTransparency", target = 0 })

	if config.Content and config.Content ~= "" then
		local contentLabel = CreateInstance("TextLabel", {
			Name = "Content",
			Parent = textContainer,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = Enum.Font.Gotham,
			Text = config.Content,
			TextColor3 = self.Theme.DescColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 2,
		})
		table.insert(fadeEntries, { instance = contentLabel, prop = "TextTransparency", target = 0 })
	end

	if config.SubContent and config.SubContent ~= "" then
		local subContentLabel = CreateInstance("TextLabel", {
			Name = "SubContent",
			Parent = textContainer,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = Enum.Font.Gotham,
			Text = config.SubContent,
			TextColor3 = self.Theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 3,
		})
		table.insert(fadeEntries, { instance = subContentLabel, prop = "TextTransparency", target = 0 })
	end

	local closeButton = CreateInstance("TextButton", {
		Name = "Close",
		Parent = card,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Text = "",
		AutoButtonColor = false,
	})

	local closeIcon = CreateInstance("ImageLabel", {
		Parent = closeButton,
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Image = ResolveIcon("x"),
		ImageColor3 = self.Theme.DescColor,
	})
	table.insert(fadeEntries, { instance = closeIcon, prop = "ImageTransparency", target = 0 })

	local dismissed = false
	local function dismiss()
		if dismissed then
			return
		end
		dismissed = true

		local exitEntries = {}
		for _, entry in ipairs(fadeEntries) do
			table.insert(exitEntries, { instance = entry.instance, prop = entry.prop, target = 1 })
		end

		FadeTransparency(exitEntries, 0.2, Enum.EasingDirection.In)

		task.delay(0.2, function()
			card:Destroy()
		end)
	end

	closeButton.MouseButton1Click:Connect(dismiss)

	FadeTransparency(fadeEntries, 0.25, Enum.EasingDirection.Out)

	if config.SoundID and config.SoundID ~= "" then
		local soundId = tostring(config.SoundID)
		if not soundId:match("^rbxassetid://") then
			soundId = "rbxassetid://" .. soundId
		end

		local sound = CreateInstance("Sound", {
			Name = "NotifySound",
			Parent = card,
			SoundId = soundId,
			Volume = config.SoundVolume or 1,
			PlaybackSpeed = config.SoundSpeed or 1,
			Looped = config.SoundLooped or false,
		})

		sound.Ended:Connect(function()
			if not config.SoundLooped then
				sound:Destroy()
			end
		end)

		pcall(function()
			sound:Play()
		end)
	end

	if config.Duration then
		task.delay(config.Duration, dismiss)
	end

	return {
		Frame = card,
		Dismiss = dismiss,
	}
end

