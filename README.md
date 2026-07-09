```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Library/refs/heads/main/main.luau"))()

local Window = Library:Window{
	Title = "Vanta Hub",
	SubTitle = "roblox interface",
	TabWidth = 160,
	Size = UDim2.fromOffset(830, 525),
	Resize = true,
	Acrylic = true,
	Theme = "Purple",
	MinimizeKey = Enum.KeyCode.P,
	icno = {work = true, IdIcon = ""}
}

local Tabs = {{ Name = "Home", Icon = "home" }, { Name = "Settings", Icon = "settings" }, { Name = "Players", Icon = "users" }, { Name = "Store", Icon = "shopping-cart" },}
Window:AddTab(Tabs)

local Sections1 = HOME:AddSection({ Name = "Main", Icon = "home" })
```
