function Library:SetTheme(newTheme)
	local rawTheme = newTheme

	if type(newTheme) == "string" then
		local themeName = newTheme
		if themeName == "All" or themeName == "Random" then
			themeName = GetRandomPresetName()
		end
		rawTheme = Library.Presets[themeName] or {}
	elseif type(newTheme) == "table" and newTheme.Accent and not newTheme.Background and not newTheme.Secondary then
		local generated = GenerateThemeFromAccent(ToColor3(newTheme.Accent))
		for key, value in pairs(newTheme) do
			generated[key] = value
		end
		rawTheme = generated
	end

	local resolved = ResolveTheme(rawTheme)
	for key, value in pairs(resolved) do
		self.Theme[key] = value
	end

	self.Stroke.Color = self.Theme.Accent
	self.MainFrame.BackgroundColor3 = self.Theme.Background
	self.MainFrame.BackgroundTransparency = self.Theme.Transparency

	local topDivider = self.TopBar:FindFirstChild("Divider")
	if topDivider then
		topDivider.BackgroundColor3 = self.Theme.Accent
	end

	if self.TabsDivider then
		self.TabsDivider.BackgroundColor3 = self.Theme.Accent
	end

	self.TitleLabel.TextColor3 = self.Theme.TitleColor
	self.DescLabel.TextColor3 = self.Theme.DescColor

	for _, section in ipairs(self.SectionLabels) do
		if section and section.Parent then
			if section:IsA("ImageLabel") then
				section.ImageColor3 = self.Theme.SectionColor
			else
				section.TextColor3 = self.Theme.SectionColor
			end
		end
	end

	if self.IconButton then
		if self.IconButton.BackgroundTransparency ~= 1 then
			self.IconButton.BackgroundColor3 = self.Theme.Background
		end
		if self.IconFrameStroke then
			self.IconFrameStroke.Color = self.Theme.Accent
		end
		if self.IconCornerStroke then
			self.IconCornerStroke.Color = self.Theme.Accent
		end
	end

	for _, refresh in ipairs(self.Controls) do
		pcall(refresh, self.Theme)
	end

	if self.ActiveTabName then
		self:SelectTab(self.ActiveTabName)
	end
end

function Library:SetTitle(text)
	self.TitleLabel.Text = text
end

function Library:SetSubTitle(text)
	self.DescLabel.Text = text
end

function Library:SelectTab(name)
	if not self.Pages[name] then
		return
	end

	for tabName, page in pairs(self.Pages) do
		page.Visible = (tabName == name)
	end

	for tabName, button in pairs(self.TabButtons) do
		local active = tabName == name
		local icon = button:FindFirstChildOfClass("ImageLabel")
		local label = button:FindFirstChildOfClass("TextLabel")

		button.BackgroundColor3 = self.Theme.Accent
		button.BackgroundTransparency = active and 0.85 or 1

		if icon then
			icon.ImageColor3 = active and self.Theme.Accent or self.Theme.DescColor
		end

		if label then
			label.TextColor3 = active and self.Theme.TitleColor or self.Theme.DescColor
		end
	end

	self.ActiveTabName = name
end

