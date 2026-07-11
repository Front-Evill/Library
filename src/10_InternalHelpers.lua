function Library:SafeFind(root, ...)
	local current = root
	local pathParts = {...}

	if not current then
		self:Notify({
			Title = "خطأ بالمسار",
			Content = "الجذر (root) اللي أعطيته فارغ (nil)",
			Duration = 6,
			icone = {Work = true, IdIcon = "", Type = "up"},
		})
		return nil
	end

	for _, part in ipairs(pathParts) do
		local ok, child = pcall(function()
			return current:WaitForChild(part, 3)
		end)

		if not ok or not child then
			self:Notify({
				Title = "خطأ بالمسار",
				Content = 'تعذر إيجاد "' .. tostring(part) .. '" داخل ' .. tostring(current.Name),
				Duration = 6,
				icone = {Work = true, IdIcon = "", Type = "up"},
			})
			return nil
		end

		current = child
	end

	return current
end

function Library:SafePlayer(nameOrUserId)
	local Players = game:GetService("Players")
	local player = nil

	if type(nameOrUserId) == "number" then
		local ok, result = pcall(function()
			return Players:GetPlayerByUserId(nameOrUserId)
		end)
		player = ok and result or nil
	else
		local ok, result = pcall(function()
			return Players:FindFirstChild(tostring(nameOrUserId))
		end)
		player = ok and result or nil
	end

	if not player then
		self:Notify({
			Title = "خطأ باللاعب",
			Content = "ما لكيت لاعب بالاسم/الآيدي: " .. tostring(nameOrUserId),
			Duration = 6,
			icone = {Work = true, IdIcon = "", Type = "up"},
		})
		return nil
	end

	return player
end

function Library:GetNotifyContainer(position)
	self.NotifyGui = self.NotifyGui or CreateInstance("ScreenGui", {
		Name = "VantaNotifications",
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 1500,
	})

	self.NotifyContainers = self.NotifyContainers or {}

	if self.NotifyContainers[position] then
		return self.NotifyContainers[position]
	end

	local container = CreateInstance("Frame", {
		Name = "NotifyContainer_" .. position,
		Parent = self.NotifyGui,
		BackgroundTransparency = 1,
		AnchorPoint = position == "down" and Vector2.new(1, 1) or Vector2.new(1, 0),
		Position = position == "down" and UDim2.new(1, -20, 1, -20) or UDim2.new(1, -20, 0, 20),
		Size = UDim2.new(0, 300, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	CreateInstance("UIListLayout", {
		Parent = container,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = position == "down" and Enum.VerticalAlignment.Bottom or Enum.VerticalAlignment.Top,
	})

	self.NotifyContainers[position] = container
	return container
end

