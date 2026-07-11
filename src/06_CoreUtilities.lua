local function CreateInstance(className, properties)
	local inst = Instance.new(className)
	for prop, value in pairs(properties) do
		inst[prop] = value
	end
	return inst
end

local function MakeDraggable(dragHandle, target)
	local dragging = false
	local dragStart
	local startPos

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				local delta = input.Position - dragStart
				target.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)
end

local function FadeTransparency(entries, duration, easingDirection)
	for _, entry in ipairs(entries) do
		local tween = TweenService:Create(
			entry.instance,
			TweenInfo.new(duration, Enum.EasingStyle.Quad, easingDirection),
			{ [entry.prop] = entry.target }
		)
		tween:Play()
	end
end

local function MakeResizable(handle, target, minSize, maxSize)
	local resizing = false
	local dragStart
	local startSize

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			dragStart = input.Position
			startSize = target.Size

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if resizing then
				local delta = input.Position - dragStart
				local newWidth = math.clamp(startSize.X.Offset + delta.X, minSize.X, maxSize.X)
				local newHeight = math.clamp(startSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)
				target.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
	end)
end

