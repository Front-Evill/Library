# VantaUI

A Roblox UI Library built entirely using `Instance` and `TweenService` only — with absolutely no external dependencies.

VantaUI focuses exclusively on user interface design and animations, providing a modern and reusable UI framework for Roblox developers.

The library includes only visual interface components and interaction systems such as Windows, Tabs, Sections, Toggles, Dropdowns, Sliders, Paragraphs, Buttons, Colorpickers, Keybinds, Text Inputs, Notifications, Dialogs, Scrolling Containers, Window Dragging, and UI Visibility Toggle Keys.

---

```lua
local VantaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Gui/refs/heads/main/VantaUI.lua"))()
```

---

## Creating a Window — `VantaUI.CreateWindow(config)`

```lua
local Window = VantaUI.CreateWindow({
    Title           = "VANTA UI",
    Size            = UDim2.new(0, 308, 0, 490),
    Position        = UDim2.new(0, 50, 0, 50),
    Tabs            = {"General", "Style", "About"},
    ToggleKey       = Enum.KeyCode.RightShift,
    Icon            = "rbxassetid://0",
    BackgroundImage = "rbxassetid://0",
    AccentColor     = Color3.fromRGB(200, 28, 28),
    BackgroundColor = Color3.fromRGB(10, 8, 16),
    GuiName         = "VantaExample",
})
```

### All configuration fields are optional

| Property        | Default Value                 |
| --------------- | ----------------------------- |
| Title           | `"UI LIBRARY"`                |
| Size            | `UDim2.new(0, 308, 0, 490)`   |
| Position        | `UDim2.new(0, 50, 0, 50)`     |
| Tabs            | `{"Tab 1", "Tab 2", "Tab 3"}` |
| ToggleKey       | `Enum.KeyCode.F`              |
| Icon            | Default Icon                  |
| BackgroundImage | Default Background            |
| AccentColor     | `Color3.fromRGB(200, 28, 28)` |
| BackgroundColor | `Color3.fromRGB(10, 8, 16)`   |
| GuiName         | `"VantaUILibrary"`            |

---

## Section — `Window:Section(tabName, title)`

```lua
Window:Section("General", "MAIN SETTINGS")
```

---

## Toggle — `Window:Toggle(tabName, label, default, callback)`

```lua
local myToggle = Window:Toggle(
    "General",
    "Enable Feature",
    false,
    function(value)
        print("New value:", value)
    end
)

myToggle.Set(true)
```

---

## Dropdown — `Window:Dropdown(tabName, label, options, default, callback)`

```lua
Window:Dropdown(
    "General",
    "Mode",
    {"A", "B", "C"},
    "A",
    function(selected)
        print("Selected:", selected)
    end
)
```

---

## Slider — `Window:Slider(tabName, label, min, max, default, suffix, callback)`

```lua
Window:Slider(
    "General",
    "Value",
    0,
    100,
    50,
    "%",
    function(value)
        print("Value:", value)
    end
)
```

---

## Paragraph — `Window:Paragraph(tabName, title, content)`

A non-interactive text block that supports titles and multiline content.

```lua
Window:Paragraph(
    "General",
    "Welcome",
    "Any explanatory text goes here.\nSupports multiple lines."
)
```

---

## Button — `Window:Button(tabName, title, description, callback)`

The description parameter is optional.

```lua
Window:Button(
    "General",
    "Run Action",
    "Optional description text",
    function()
        print("Button clicked")
    end
)
```

---

## Colorpicker — `Window:Colorpicker(tabName, label, default, withAlpha, callback)`

Provides a saturation/brightness area, hue slider, and optional alpha slider.

```lua
local Colorpicker = Window:Colorpicker(
    "Style",
    "Accent Color",
    Color3.fromRGB(200, 28, 28),
    false,
    function(color, transparency)
        print("Color:", color)
    end
)

Colorpicker.OnChanged(function(color, transparency)
    print("Changed:", color)
end)

Colorpicker.SetValueRGB(Color3.fromRGB(30, 170, 90))

print(Colorpicker.Value, Colorpicker.Transparency)
```

---

## Keybind — `Window:Keybind(tabName, label, default, mode, callback)`

Supported keys:

* `Enum.KeyCode.X`
* `"MB1"`
* `"MB2"`

Supported modes:

* `"Always"`
* `"Toggle"`
* `"Hold"`

```lua
local Keybind = Window:Keybind(
    "Extras",
    "Sample Bind",
    Enum.KeyCode.RightShift,
    "Toggle",
    function(state)
        print("State:", state)
    end
)

Keybind.OnClick(function()
    print("Pressed while in Toggle mode")
end)

Keybind.OnChanged(function(state)
    print("Changed:", state)
end)

print(Keybind.GetState())

Keybind.SetValue("MB2", "Hold")
```

---

## Input — `Window:Input(tabName, label, default, placeholder, numeric, finished, callback)`

* `numeric = true` allows numbers only.
* `finished = true` fires the callback only after focus is lost.

```lua
Window:Input(
    "Extras",
    "Sample Text",
    "",
    "Type here...",
    false,
    true,
    function(value)
        print("Submitted:", value)
    end
)
```

---

## Tab System

```lua
Window:SelectTab("General")
Window:SelectTab(1)
```

---

## Notifications — `Window:Notify(config)`

```lua
Window:Notify({
    Title      = "Vanta UI",
    Content    = "This is a notification",
    SubContent = "Optional secondary line",
    Duration   = 5,
})
```

Notifications appear in the upper-right corner with smooth entrance and exit animations.

If a duration is provided, the notification automatically closes after the specified number of seconds.

---

## Dialogs — `Window:Dialog(config)`

```lua
Window:Dialog({
    Title   = "Are you sure?",
    Content = "This action cannot be undone.",
    Buttons = {
        {
            Title = "Confirm",
            Callback = function()
                print("Confirmed")
            end
        },
        {
            Title = "Cancel",
            Callback = function()
                print("Cancelled")
            end
        },
    },
})
```

Dialogs create a darkened overlay with a centered confirmation window and fully customizable buttons.

The dialog automatically closes when any button is pressed.

---

# Live Theme System

VantaUI supports real-time theme updates after a window has been created.

```lua
Window:SetAccentColor(Color3.fromRGB(28, 110, 200))

Window:SetBackgroundColor(Color3.fromRGB(14, 14, 14))

Window:SetTheme(
    Color3.fromRGB(30, 170, 90),
    Color3.fromRGB(6, 10, 18)
)

local currentAccent = Window:GetAccentColor()
local currentBg = Window:GetBackgroundColor()
```

## How Theme Updates Work

* Every UI element is automatically registered when created.
* Theme changes instantly update all registered elements.
* Active states remain fully preserved.
* Tabs, Toggles, Dropdowns, Sliders, and other components retain their current state during updates.
* Multiple windows remain completely independent from each other.
* Borders, shadows, highlights, and derived colors are generated dynamically from the active theme color to maintain visual consistency.

---

# Complete Example

See the included `Example.lua` file for a full demonstration of the library.

The example contains four simple tabs:

### Home

* Toggle
* Dropdown
* Slider

### Elements

* Button
* Dialog
* Keybind
* Input
* Notification

### Style

* Live Theme Colorpicker

### About

* Paragraph Example

Each section is clearly organized using `Window:Section(...)` calls, making it easy to copy only the parts you need.

---

# Notes

* VantaUI does not include configuration saving functionality.
* Settings persistence can be implemented separately using DataStores or external environments.
* Every UI component is fully independent and does not rely on any gameplay system.
* Multiple windows can be created simultaneously using `CreateWindow()`.
* Each window maintains its own state, theme, tabs, and registered components independently.
