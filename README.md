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
	icno = {work = true, IdIcon = "", Size = 50}
}

local Tabs = {
	{ Name = "Home", Icon = "home" },
	{ Name = "Settings", Icon = "settings" },
	{ Name = "Players", Icon = "users" },
	{ Name = "Store", Icon = "shopping-cart" },
}

local CreatedTabs = Window:AddTab(Tabs)

local HOME = CreatedTabs.Home
local SETTINGS = CreatedTabs.Settings
local PLAYERS = CreatedTabs.Players
local STORE = CreatedTabs.Store

local Sections1 = HOME:AddSection({ Name = "Main", Icon = "home" })
local Sections2 = SETTINGS:AddSection({ Name = "General", Icon = "settings" })
local Sections3 = PLAYERS:AddSection({ Name = "Online", Icon = "users" })
local Sections4 = STORE:AddSection({ Name = "Items", Icon = "shopping-cart" })

Window:Notify({
	Title = "Notification",
	Content = "This is a notification",
	SubContent = "SubContent",
	Duration = 5,
	icone = { Work = true, IdIcon = "check", Type = "up" },
	SoundID = "9125826312",
	SoundVolume = 0.6,
})
```
