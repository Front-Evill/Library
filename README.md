# Vanta

Vanta is a UI library for Roblox scripts. It gives you a complete window
system — tabs, sections, and a full set of interactive elements — so you can
build a clean script hub without writing UI code from scratch.

## Features

- **Window system** — draggable, resizable, minimizable, with an optional
  acrylic-style translucent background and a custom background image.
- **Tabs & sections** — organize settings into tabs and titled sections, or
  use `AddSectionsBox` for square image + title cards that expand into a
  full panel with a smooth fade animation.
- **Full element set** — buttons (with confirmation prompts), toggles,
  sliders, dropdowns, multi-dropdowns, keybinds, text inputs, color pickers,
  progress bars, dividers, and paragraphs.
- **Notifications & dialogs** — toast notifications and confirmation popups
  out of the box.
- **Config saving & loading** — persist every flagged element to a JSON file
  and restore it later with two function calls.
- **Theming** — a set of built-in color presets, or generate a theme from
  any accent color.

## Get started

The easiest way to grab the library and a ready-to-use loader script is
through the dashboard:

**[vanta-obf.netlify.app/dashboard](https://vanta-obf.netlify.app/dashboard)**

Everything you need to load Vanta into your script is available there.

## Documentation

Full API reference, every element's options, and code examples live in
**[Vanta.md](./Vanta.md)**. It covers:

- Window, tab, and section setup
- Every element type with its config fields
- Notifications, dialogs, and config save/load
- Theming and icons
- Project structure and building from source

## Example

A complete, ready-to-run example that demonstrates every feature across
multiple tabs is included at [`Vanta_Example.lua`](./Vanta_Example.lua).

```lua
local Library = loadstring(game:HttpGet("https://github.com/Front-Evill/Library/releases/download/latest/main.lua"))()

local Window = Library:Window({
	Title = "Vanta Hub",
	SubTitle = "By FrontEvill",
	TabWidth = 160,
	Size = UDim2.fromOffset(860, 560),
	Resize = true,
	Acrylic = true,
	Theme = "Purple",
	MinimizeKey = Enum.KeyCode.P,
	Search = true,
	Stats = true,
	icno = { work = true, IdIcon = "111125720813548", Size = 44 },
	Background = { work = true, id = "https://www.roblox.com/asset/?id=89124894879171" },
})

local Tabs = Window:AddTab({
	Home = { Name = "Home", Icon = "home" },
	Combat = { Name = "Combat", Icon = "swords" },
	Movement = { Name = "Movement", Icon = "compass" },
	Visuals = { Name = "Visuals", Icon = "palette" },
	Settings = { Name = "Settings", Icon = "settings" },
})

local HomeTab = Tabs.Home
local CombatTab = Tabs.Combat
local MovementTab = Tabs.Movement
local VisualsTab = Tabs.Visuals
local SettingsTab = Tabs.Settings

local WelcomeSection = HomeTab:AddSection({ Name = "Welcome", Icon = "home" })

WelcomeSection:AddParagraph({
	Title = "Vanta Hub",
	Content = "Every feature of the library is demonstrated across these tabs. Explore Combat, Movement, Visuals, and Settings from the sidebar.",
})

local QuickSection = HomeTab:AddSection({ Name = "Quick actions", Icon = "gauge", Box = false })

QuickSection:AddButton({
	Name = "Say hello",
	Description = "Prints a message and shows a notification",
	Callback = function()
		print("hello from Vanta")
		Window:Notify({
			Title = "Hello",
			Content = "Button pressed",
			Duration = 3,
		})
	end,
})

QuickSection:AddButton({
	Name = "Delete data",
	Description = "Removes your saved data",
	Tooltip = "Runs after confirmation",
	Callback = function()
		Window:Notify({
			Title = "Deleted",
			Content = "Your data has been removed",
			Duration = 4,
			icone = { Work = true, IdIcon = "", Type = "up" },
		})
	end,
	Confirm = {
		Title = "Are you sure?",
		Content = "This cannot be undone.",
		ConfirmText = "Delete",
		CancelText = "Cancel",
	},
})

local AimbotCard = CombatTab:AddSectionsBox({ Name = "Aimbot", Image = "crosshair" })
local ESPCard = CombatTab:AddSectionsBox({ Name = "ESP", Image = "eye" })

AimbotCard:AddToggle({
	Name = "Enable aimbot",
	Default = false,
	Flag = "AimbotEnabled",
	Callback = function(value)
		print("aimbot:", value)
	end,
})

AimbotCard:AddSlider("FOV", {
	Title = "FOV",
	Default = 80,
	Min = 10,
	Max = 200,
	Flag = "AimbotFOV",
	Callback = function(value)
		print("fov:", value)
	end,
})

AimbotCard:AddDropdown({
	Name = "Target part",
	Options = { "Head", "Torso", "Closest" },
	Default = "Head",
	Flag = "AimbotPart",
	Callback = function(value)
		print("target part:", value)
	end,
})

ESPCard:AddToggle({
	Name = "Enable ESP",
	Default = false,
	Flag = "ESPEnabled",
	Callback = function(value)
		print("esp:", value)
	end,
})

ESPCard:AddMultiDropdown({
	Name = "Show",
	Options = { "Boxes", "Names", "Health", "Distance" },
	Default = { "Boxes", "Names" },
	Flag = "ESPShow",
	Callback = function(list)
		print(table.concat(list, ", "))
	end,
})

ESPCard:AddColorPicker({
	Name = "ESP color",
	Default = "Purple",
	Flag = "ESPColor",
	Callback = function(presetName)
		print("esp color:", presetName)
	end,
})

local GeneralCombatSection = CombatTab:AddSection({ Name = "General", Icon = "shield" })

GeneralCombatSection:AddKeybind("Panic key", {
	Title = "Panic key",
	Mode = "Toggle",
	Default = "RightShift",
	Flag = "PanicKey",
	Callback = function(value)
		print("panic:", value)
	end,
})

local SpeedCard = MovementTab:AddSectionsBox({ Name = "Speed", Image = "gauge" })
local FlyCard = MovementTab:AddSectionsBox({ Name = "Fly", Image = "rocket" })

SpeedCard:AddToggle({
	Name = "Enable speed",
	Default = false,
	Flag = "SpeedEnabled",
	Callback = function(value)
		print("speed enabled:", value)
	end,
})

SpeedCard:AddSlider("Walk speed", {
	Title = "Walk speed",
	Default = 16,
	Min = 0,
	Max = 100,
	Flag = "WalkSpeed",
	Callback = function(value)
		print("walkspeed:", value)
	end,
})

FlyCard:AddToggle({
	Name = "Enable fly",
	Default = false,
	Flag = "FlyEnabled",
	Callback = function(value)
		print("fly:", value)
	end,
})

FlyCard:AddKeybind("Fly key", {
	Title = "Fly key",
	Mode = "Hold",
	Default = "Space",
	Flag = "FlyKey",
	Callback = function(value)
		print("flying:", value)
	end,
})

local WorldSection = MovementTab:AddSection({ Name = "World", Icon = "map", Box = false })

WorldSection:AddInput("Teleport place", {
	Title = "Teleport place",
	Default = "",
	Placeholder = "Enter a location name",
	Finished = true,
	Flag = "TeleportPlace",
	Callback = function(value)
		print("teleport to:", value)
	end,
})

local InterfaceSection = VisualsTab:AddSection({ Name = "Interface", Icon = "palette" })

InterfaceSection:AddColorPicker({
	Name = "Theme color",
	Description = "Pick a theme for the whole window",
	Default = "Purple",
	Flag = "InterfaceColor",
	Callback = function(presetName)
		print("theme changed to", presetName)
	end,
})

InterfaceSection:AddDivider()

InterfaceSection:AddButton({
	Name = "Randomize theme",
	Callback = function()
		Window:SetTheme("All")
	end,
})

local WorldVisualsSection = VisualsTab:AddSection({ Name = "World", Icon = "globe", Box = false })

local FogProgress = WorldVisualsSection:AddProgressBar({
	Title = "Render distance",
	Default = 50,
	Min = 0,
	Max = 100,
	ShowPercent = true,
})

WorldVisualsSection:AddSlider("Fog amount", {
	Title = "Fog amount",
	Default = 0,
	Min = 0,
	Max = 100,
	Callback = function(value)
		FogProgress:Set(value)
	end,
})

local ConfigSection = SettingsTab:AddSection({ Name = "Config", Icon = "save" })

ConfigSection:AddButton({
	Name = "Save config",
	Description = "Writes all flagged values to Profile1.json",
	Callback = function()
		Window:SaveConfig("Profile1")
	end,
})

ConfigSection:AddButton({
	Name = "Load config",
	Description = "Reads Profile1.json back and applies it",
	Callback = function()
		Window:LoadConfig("Profile1")
	end,
})

local MiscSection = SettingsTab:AddSection({ Name = "Misc", Icon = "settings", Box = false })

MiscSection:AddButton({
	Name = "Open dialog",
	Description = "Shows a confirmation-style popup",
	Callback = function()
		Window:Dialog({
			Title = "Confirm action",
			Content = "Are you sure you want to continue?",
			Buttons = {
				{ Title = "Confirm", Callback = function() print("confirmed") end },
				{ Title = "Cancel", Callback = function() print("cancelled") end },
			},
		})
	end,
})

MiscSection:AddParagraph({
	Title = "Note",
	Content = "Settings are grouped separately from gameplay features to keep things easy to find.",
})

Window:Notify({
	Title = "Welcome",
	Content = "This example shows every Vanta feature across multiple tabs",
	SubContent = "Explore the sidebar to see everything",
	Duration = 6,
	icone = { Work = true, IdIcon = "check", Type = "up" },
})
```

## Sources & credits

- Icons — [Lucide](https://lucide.dev), MIT licensed.
- Roblox API reference — [create.roblox.com/docs](https://create.roblox.com/docs/reference/engine).
- Built and maintained by **FrontEvill**.

## Support

For questions, issues, or the latest builds, use the dashboard linked above.
