# VantaUI

A UI library for Roblox, built entirely with `Instance` + `TweenService` — no external dependencies.

The library only contains design and animation elements: Window, Tabs, Sections/Groups, Toggle, Dropdown, Slider, Colorpicker, Keybind, Input, Button, Paragraph, Notify, confirmation Dialogs, and a floating icon to show/hide the UI.

---

## Installation

```lua
local VantaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Gui/refs/heads/main/VantaUI.lua"))()
```

---

## Creating a window — `VantaUI.CreateWindow(config)`

```lua
local Window = VantaUI.CreateWindow({
    Title           = "VANTA UI",
    Size            = UDim2.new(0, 308, 0, 490),
    Position        = UDim2.new(0, 50, 0, 50),
    Tabs            = {"General", "Style", "Extras", "About"},
    ToggleKey       = Enum.KeyCode.RightShift,
    Icon            = "rbxassetid://0",
    BackgroundImage = "rbxassetid://0",
    AccentColor     = Color3.fromRGB(200, 28, 28),
    BackgroundColor = Color3.fromRGB(10, 8, 16),
    Transparency    = 0.8,
    GuiName         = "VantaExample",
})
```

### Floating toggle icon — `Window:AddToggleIcon(config)`

```lua
local Icon = Window:AddToggleIcon({
    Image             = "rbxassetid://0",
    Size              = UDim2.new(0, 46, 0, 46),
    Position          = UDim2.new(1, -66, 1, -66),
    ClickSound        = "rbxassetid://0",
    ClickSoundVolume  = 0.5,
})

-- Later, if you want to remove it completely with no issues:
Icon:Destroy()
```

`ClickSound` is optional — if you set it, that sound plays every time the icon actually toggles the window (not while dragging it). `ClickSoundVolume` defaults to `0.5`.

---

## Sections — the recommended way to add elements

`Window:Section(tabName, {Title=...})` builds a rounded box with a nice border under a highlighted title, and returns a **Group** containing every element function. Anything you add through the Group appears grouped inside that same box:

```lua
local MainGroup = Window:Section("General", {
    Title = "MAIN SETTINGS",
})

MainGroup.Toggle({
    Title    = "Enable Feature",
    Default  = false,
    Callback = function(value) end,
})

MainGroup.Button({
    Title       = "Run",
    Description = "optional",
    Callback    = function() end,
})

MainGroup.Slider({
    Title    = "Value",
    Min      = 0,
    Max      = 100,
    Default  = 50,
    Suffix   = "%",
    Callback = function(value) end,
})
```

You can create more than one `Section` on the same tab — each gets its own independent box.

### Ungrouped elements (flat)

If you don't need a surrounding box, call the same functions directly on `Window` instead of a Group:

```lua
Window:Toggle("General", {
    Title    = "Ungrouped Toggle",
    Default  = false,
    Callback = function(value) end,
})
```

Every element function (`Toggle`, `Dropdown`, `Slider`, `Colorpicker`, `Keybind`, `Input`, `Button`, `Paragraph`) is available with the same signature on `Window` (flat) and on any `Group` (grouped inside a box) — pick whichever fits.

---

## Available elements

All examples below work whether you call them via `Window:X("TabName", cfg)` or `Group.X(cfg)`.

### 1. Toggle

```lua
local Toggle = Window:Toggle("General", {
    Title    = "Enable Feature",
    Default  = false,
    Callback = function(value)
        print("New value:", value)
    end,
})

Toggle.Set(true)
print(Toggle.Get())
```

### 2. Dropdown

```lua
local Dropdown = Window:Dropdown("General", {
    Title    = "Mode",
    Values   = {"A", "B", "C"},
    Default  = "A",
    Callback = function(selected)
        print("Selected:", selected)
    end,
})

Dropdown.Set("B")
print(Dropdown.Get())
```

### 3. Slider

```lua
Window:Slider("General", {
    Title    = "Value",
    Min      = 0,
    Max      = 100,
    Default  = 50,
    Suffix   = "%",
    Callback = function(value)
        print("Value:", value)
    end,
})
```

### 4. Paragraph

```lua
Window:Paragraph("General", {
    Title   = "Welcome",
    Content = "Any explanatory text goes here.\nSupports multiple lines.",
})
```

### 5. Button

```lua
Window:Button("General", {
    Title       = "Run Action",
    Description = "Optional description text",
    Callback    = function()
        print("Button clicked")
    end,
})
```

### 6. Colorpicker

Pass `Transparency` (a number between 0 and 1) to enable an extra alpha slider. Leave it unset to hide it.

```lua
local Colorpicker = Window:Colorpicker("Style", {
    Title    = "Accent Color",
    Default  = Color3.fromRGB(200, 28, 28),
    Callback = function(color, alpha)
        print("Color:", color)
    end,
})

Colorpicker.OnChanged(function(color, alpha)
    print("Changed:", color)
end)

Colorpicker.SetValueRGB(Color3.fromRGB(30, 170, 90))
print(Colorpicker.Value, Colorpicker.Transparency)
```

**Wiring it directly into the live theme:**

```lua
Window:Colorpicker("Style", {
    Title    = "Accent Color",
    Default  = Color3.fromRGB(200, 28, 28),
    Callback = function(color)
        Window:SetAccentColor(color)
    end,
})
```

### 7. Keybind

`Default` accepts `Enum.KeyCode.X` or `"MB1"` / `"MB2"` (mouse buttons). `Mode` accepts `"Always"`, `"Toggle"`, or `"Hold"`. `ChangedCallback` is optional and only fires when the bound key itself is rebound.

`Mode = "Always"` now fires `Callback(true)` once immediately when the element is created (previously it only fired the first time `SetValue` was called with that mode, which was inconsistent).

```lua
local Keybind = Window:Keybind("Extras", {
    Title           = "Sample Bind",
    Default         = Enum.KeyCode.RightShift,
    Mode            = "Toggle",
    Callback        = function(state)
        print("State:", state)
    end,
    ChangedCallback = function(newKey)
        print("Rebound to:", newKey)
    end,
})

Keybind.OnClick(function()
    print("Pressed while in Toggle mode")
end)

Keybind.OnChanged(function(state)
    print("Changed:", state)
end)

print(Keybind.GetState())
Keybind.SetValue("MB2", "Hold")
```

### 8. Input

`Numeric = true` allows digits only. `Finished = true` calls `Callback` only when focus is lost, instead of on every keystroke.

```lua
Window:Input("Extras", {
    Title       = "Sample Text",
    Default     = "",
    Placeholder = "Type here...",
    Numeric     = false,
    Finished    = true,
    Callback    = function(value)
        print("Submitted:", value)
    end,
})
```

---

## Tab system

```lua
Window:SelectTab("General")
Window:SelectTab(1)
```

---

## Notifications — `Window:Notify(config)`

```lua
local n = Window:Notify({
    Title       = "Vanta UI",
    Content     = "This is a notification",
    SubContent  = "Optional secondary line",
    Duration    = 5,
    Sound       = "rbxassetid://0",
    SoundVolume = 0.5,
})

n.Close()
```

`Sound` is optional — if set, it plays once as soon as the notification appears. `SoundVolume` defaults to `0.5`.

---

## Confirmation dialog — `Window:Dialog(config)`

```lua
Window:Dialog({
    Title   = "Are you sure?",
    Content = "This action cannot be undone.",
    Buttons = {
        {
            Title    = "Confirm",
            Callback = function()
                print("Confirmed")
            end,
        },
        {
            Title    = "Cancel",
            Callback = function()
                print("Cancelled")
            end,
        },
    },
})
```

---

## Theme control

```lua
Window:SetAccentColor(Color3.fromRGB(28, 110, 200))
Window:SetBackgroundColor(Color3.fromRGB(14, 14, 14))
Window:SetTheme(Color3.fromRGB(30, 170, 90), Color3.fromRGB(6, 10, 18))

local currentAccent = Window:GetAccentColor()
local currentBg     = Window:GetBackgroundColor()
```

---

## Tearing a window down — `Window:Destroy()`

```lua
Window:Destroy()
```

Disconnects every input listener the window created (dragging, the toggle key, sliders, keybinds, colorpicker drag areas) and destroys its `ScreenGui`. Use this if your script can reload or rebuild the UI more than once in the same session — without it, each rebuild used to leave the previous window's global input listeners running in the background permanently.

---

## Notes on this cleaned-up build

A pass was done over the original source to check for bugs, dead code, and inconsistent behavior. Nothing about the visual design or the public API's shape changed — these were correctness/consistency fixes only:

- **`Window:Destroy()` added.** Previously there was no way to fully tear down a window: hiding it (`Main.Visible = false`) or destroying the `ScreenGui` directly still left several global `UserInputService` connections (window dragging, the toggle key, every slider, every keybind, every colorpicker's drag zones) running forever in the background, since Roblox only auto-disconnects listeners attached to an instance's own events — not listeners a script attaches to a shared service like `UserInputService`. All of those connections are now tracked internally and released by `Destroy()`.
- **Clicking outside a dropdown or colorpicker now closes it.** Before, an open dropdown or color panel only closed if you clicked its own button again or opened a different popup; clicking anywhere else on the UI left it open. A single shared "click elsewhere to close" catcher now backs every popup.
- **`Dropdown` gained a `Get()` function**, matching the `Get`/`Set` pattern already used by `Toggle`, so you can read the current selection without tracking it yourself.
- **`Keybind` with `Mode = "Always"` now calls `Callback(true)` once at creation**, instead of only the first time `SetValue` was called with that mode — the two code paths previously disagreed on when "always on" actually started notifying you.
- **`Input` with `Numeric = true` and `Finished` left unset (live updates) no longer double-fires the callback** on a single keystroke. The character-filtering step and the "value changed" notification were two separate listeners on the same event; typing an invalid character could fire `Callback` once with the raw text and again with the filtered text. They're now one listener.
