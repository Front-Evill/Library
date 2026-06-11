# Orbs UI Library v1.3

A clean and modern UI library for Roblox executors.

---

## Installation

Paste this at the top of your script to load the library:

```lua
local OrbsUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Gui/refs/heads/main/main.lua"))()
```

---

## Creating a Window

```lua
local Window = OrbsUI.new({
    Title       = "Orbs",
    Description = "By FrontEvill",
    Theme       = "Purple",
    MinimizeKey = Enum.KeyCode.RightShift,
})
```

| Option | Type | Description |
|---|---|---|
| Title | string | The name shown in the top bar |
| Description | string | Small text shown next to the title |
| Theme | string | Starting color theme |
| MinimizeKey | KeyCode | Key to show or hide the window |

Available themes: `Purple`, `Red`, `Cyan`, `Green`, `Gold`, `Orange`, `Pink`, `White`

---

## Adding Tabs

```lua
local Tab = Window:AddTab({ Name = "Combat", Icon = "combat" })
```

---

## Adding Sections

Sections group related elements inside a tab.

```lua
local Section = Tab:AddSection({ Name = "Aimbot" })
```

---

## Elements

### Toggle

```lua
Section:AddToggle({
    Name     = "Aimbot",
    Default  = false,
    Icon     = "target",
    Callback = function(v) end,
})
```

| Option | Type | Description |
|---|---|---|
| Name | string | Label shown on the toggle |
| Default | boolean | Starting state |
| Icon | string | Icon shown on the left |
| Callback | function | Called with true or false when toggled |

---

### Slider

```lua
Section:AddSlider({
    Name     = "FOV",
    Min      = 10,
    Max      = 180,
    Default  = 80,
    Suffix   = "°",
    Rounding = 1,
    Icon     = "zap",
    Callback = function(v) end,
})
```

| Option | Type | Description |
|---|---|---|
| Name | string | Label shown on the slider |
| Min | number | Minimum value |
| Max | number | Maximum value |
| Default | number | Starting value |
| Suffix | string | Text shown after the value |
| Rounding | number | Step size for snapping |
| Callback | function | Called with the current value |

---

### Button

```lua
Section:AddButton({
    Name     = "Reset Speed",
    Icon     = "refresh",
    Confirm  = false,
    Callback = function() end,
})
```

| Option | Type | Description |
|---|---|---|
| Name | string | Label on the button |
| Icon | string | Icon shown on the left |
| Confirm | boolean | Shows a confirmation dialog before running |
| Callback | function | Called when the button is clicked |

---

### Input

```lua
Section:AddInput({
    Name        = "Display Name",
    Placeholder = "Enter value...",
    Numeric     = false,
    Finished    = false,
    Icon        = "user",
    Callback    = function(v) end,
})
```

| Option | Type | Description |
|---|---|---|
| Name | string | Label shown above the input |
| Placeholder | string | Hint text inside the box |
| Numeric | boolean | Only allows numbers when true |
| Finished | boolean | Fires callback only when enter is pressed |
| Callback | function | Called with the current text |

---

### Dropdown

```lua
Section:AddDropdown({
    Name     = "Target Team",
    Items    = { "All", "Enemies Only", "Allies Only" },
    Default  = "All",
    Multi    = false,
    Icon     = "search",
    Callback = function(v) end,
})
```

| Option | Type | Description |
|---|---|---|
| Name | string | Label shown above the dropdown |
| Items | table | List of options |
| Default | string or table | Starting selection |
| Multi | boolean | Allows selecting multiple items when true |
| Callback | function | Called with the selected value or table |

---

### Color Picker

```lua
Section:AddColorPicker({
    Name     = "Theme Color",
    Callback = function(themeName, color) end,
})
```

The callback receives the theme name as a string and the Color3 value.

---

## Window Methods

### SetTheme

Changes the color theme of the window.

```lua
Window:SetTheme("Cyan")
```

---

### SetStatus

Updates the text shown in the bottom status bar.

```lua
Window:SetStatus("Ready")
Window:SetStatus("Error occurred", "error")
Window:SetStatus("Warning", "warn")
```

---

### Notify

Shows a notification on the right side of the screen.

```lua
Window:Notify({
    Title    = "Done",
    Content  = "Action completed.",
    Duration = 4,
})
```

| Option | Type | Description |
|---|---|---|
| Title | string | Bold title of the notification |
| Content | string | Body text |
| Duration | number | Seconds before it disappears |

---

## Element Methods

Toggles and sliders return a reference you can use to read or change the value.

```lua
local MyToggle = Section:AddToggle({ ... })
MyToggle:Set(true)
MyToggle:Get()

local MySlider = Section:AddSlider({ ... })
MySlider:Set(80)
MySlider:Get()
```

---

## Available Icons

```
home, settings, user, sword, eye, zap, shield, star, target, map,
lock, unlock, bell, trash, edit, check, close, plus, minus,
arrow_right, arrow_left, arrow_up, arrow_down, refresh, download,
upload, search, info, warning, danger, heart, chat, camera, music,
fly, speed, ghost, misc, visual, combat, movement, player, world,
kill, teleport, signal, save, terminal, play, wrench, run, script,
money, note, plug, locate, logs, ruler, scroll, phone, aimbot, esp
```

---

## Full Example

```lua
local OrbsUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Gui/refs/heads/main/main.lua"))()

local Window = OrbsUI.new({
    Title       = "Orbs",
    Description = "By FrontEvill",
    Theme       = "Purple",
    MinimizeKey = Enum.KeyCode.RightShift,
})

local Tab = Window:AddTab({ Name = "Combat", Icon = "combat" })

local Section = Tab:AddSection({ Name = "Aimbot" })

Section:AddToggle({
    Name     = "Aimbot",
    Default  = false,
    Icon     = "target",
    Callback = function(v) end,
})

Section:AddSlider({
    Name     = "FOV",
    Min      = 10,
    Max      = 180,
    Default  = 80,
    Suffix   = "°",
    Callback = function(v) end,
})

Window:SetStatus("Loaded")

Window:Notify({
    Title    = "Welcome",
    Content  = "UI loaded successfully.",
    Duration = 4,
})
```
