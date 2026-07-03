--!strict
-- ============================================================
--  VantaUI — Example / Usage Guide
--  This file has no real functionality. Every callback below
--  just prints to the output, so you can see how each element
--  works. Copy the parts you need into your own script.
-- ============================================================

-- 1) Load the library
local VantaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourname/yourrepo/main/VantaUI.lua"))()

-- 2) Create the window (all fields are optional)
local Window = VantaUI.CreateWindow({
	Title     = "VANTA UI",
	Tabs      = {"Home", "Elements", "Style", "About"},
	ToggleKey = Enum.KeyCode.RightShift, -- press to show/hide the UI
})

-- 3) Grab the tabs once so the calls below stay short
local Home, Elements, Style, About = "Home", "Elements", "Style", "About"


-- ============================================================
--  HOME — quick tour of the basics
-- ============================================================

Window:Paragraph(Home, "Welcome", "This tab shows the most common elements: Toggle, Dropdown, and Slider.")

Window:Section(Home, "TOGGLE")
Window:Toggle(Home, "Sample Toggle", false, function(value)
	print("Toggle ->", value)
end)

Window:Section(Home, "DROPDOWN")
Window:Dropdown(Home, "Sample Mode", {"Option A", "Option B", "Option C"}, "Option A", function(value)
	print("Dropdown ->", value)
end)

Window:Section(Home, "SLIDER")
Window:Slider(Home, "Sample Value", 0, 100, 50, "%", function(value)
	print("Slider ->", value)
end)


-- ============================================================
--  ELEMENTS — the rest of the toolkit
-- ============================================================

Window:Section(Elements, "BUTTON")
Window:Button(Elements, "Show Confirmation", "Opens a dialog box", function()
	Window:Dialog({
		Title   = "Are you sure?",
		Content = "This is just an example dialog.",
		Buttons = {
			{ Title = "Confirm", Callback = function() print("Confirmed") end },
			{ Title = "Cancel",  Callback = function() print("Cancelled") end },
		},
	})
end)

Window:Section(Elements, "KEYBIND")
local Keybind = Window:Keybind(Elements, "Sample Bind", Enum.KeyCode.RightShift, "Toggle", function(state)
	print("Keybind ->", state)
end)
Keybind.OnClick(function()
	print("Keybind clicked")
end)

Window:Section(Elements, "INPUT")
Window:Input(Elements, "Sample Text", "", "Type here...", false, true, function(value)
	print("Input ->", value)
end)

Window:Section(Elements, "NOTIFICATION")
Window:Button(Elements, "Send Notification", "Shows a toast in the corner", function()
	Window:Notify({
		Title    = "Vanta UI",
		Content  = "This is an example notification.",
		Duration = 5,
	})
end)


-- ============================================================
--  STYLE — one Colorpicker recolors the whole UI live
-- ============================================================

Window:Section(Style, "THEME")

Window:Colorpicker(Style, "Accent Color", Color3.fromRGB(200, 28, 28), false, function(color)
	Window:SetAccentColor(color)
end)

Window:Paragraph(Style, "How it works", "Pick any color above — every border, glow, and highlight in the UI updates instantly to match it.")


-- ============================================================
--  ABOUT
-- ============================================================

Window:Section(About, "VANTA UI")
Window:Paragraph(About, "About this example", "This file only demonstrates the library. Nothing here is a real feature.")
Window:Toggle(About, "Made with VantaUI", true, function() end)


-- 4) Open on the Home tab and greet the user
Window:SelectTab(Home)
Window:Notify({ Title = "VantaUI", Content = "Example script loaded.", Duration = 4 })
