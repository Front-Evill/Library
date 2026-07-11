function Library:Destroy()
	if self.IconButton and self.IconButton.Parent then
		self.IconButton.Parent:Destroy()
	end
	if self.NotifyGui then
		self.NotifyGui:Destroy()
		self.NotifyGui = nil
		self.NotifyContainers = nil
	end
	if self.DialogGui then
		self.DialogGui:Destroy()
		self.DialogGui = nil
	end
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

return Library
