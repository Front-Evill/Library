# VantaLib

VantaLib is a Roblox UI library for building sleek, themeable script interfaces — windows, tabs, sections, and a full set of controls (buttons, toggles, sliders, dropdowns, keybinds, inputs) along with notifications and confirmation dialogs. It ships as a single-file bundle so it can be loaded with one `loadstring` call, the same way libraries like Fluent are distributed.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Guide](#guide)
  - [Creating a Window](#creating-a-window)
  - [Themes](#themes)
  - [Tabs and Sections](#tabs-and-sections)
  - [Buttons](#buttons)
  - [Toggles](#toggles)
  - [Sliders](#sliders)
  - [Dropdowns](#dropdowns)
  - [Keybinds](#keybinds)
  - [Inputs](#inputs)
  - [Notifications](#notifications)
  - [Dialogs](#dialogs)
- [Full API Reference](#full-api-reference)
  - [Window](#window)
  - [Tabs and Sections](#tabs-and-sections-1)
  - [Controls](#controls)
  - [Feedback](#feedback)
- [Project Structure](#project-structure)

## Installation

```lua
local Vanta = loadstring(game:HttpGet("https://github.com/Front-Evill/Library/releases/latest/download/main.lua"))()
```

## Quick Start

```lua
local Vanta = loadstring(game:HttpGet("https://github.com/Front-Evill/Library/releases/latest/download/main.lua"))()

local Window = Vanta:Window({
    Title = "VantaLib",
    SubTitle = "Demo Window",
    Theme = "Purple",
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
})

local MainTab = Window:AddTab({ Name = "Main", Icon = "lucide-house" })
local Section = MainTab:AddSection({ Name = "General" })

Section:AddButton({
    Name = "Say Hello",
    Callback = function()
        Window:Notify({
            Title = "Hello",
            Content = "This is a notification.",
            Duration = 4,
        })
    end,
})
```

## Guide

### Creating a Window

The window is the root object. Every tab, section, and control is created from it.

```lua
local Window = Vanta:Window({
    Title = "My Script",
    SubTitle = "v1.0.0",
    Theme = "Blue",
    Size = UDim2.fromOffset(830, 525),
    TabWidth = 160,
    Resize = true,
    Acrylic = true,
    MinimizeKey = Enum.KeyCode.RightControl,
    icno = {
        work = true,
        IdIcon = "rbxassetid://0",
        Size = 44,
    },
})
```

- `Theme` can be a preset name (`"Dark"`, `"Purple"`, `"Rose"`, `"Blue"`, `"Green"`, `"Orange"`, `"Cyan"`, `"Gold"`, `"Random"`/`"All"`) or a custom table (see [Themes](#themes))
- `Acrylic` enables a frosted-glass background effect
- `icno` adds a floating toggle icon on the screen (outside the window) that shows/hides the whole UI when clicked — useful for mobile
- `MinimizeKey` binds a keyboard key that also toggles the whole UI on/off
- `Theme: All` You can make an interface in which every time it is turned on, it changes the color randomly
### Themes

Presets are auto-generated from a single accent color, so you can also just pass an accent to get a matching theme:

```lua
Window:SetTheme({ Accent = "#8C5CFF" })
```

Or supply every color manually:

```lua
Window:SetTheme({
    Accent = Color3.fromRGB(150, 100, 255),
    Background = Color3.fromRGB(20, 18, 24),
    Secondary = Color3.fromRGB(28, 25, 34),
    TitleColor = Color3.fromRGB(255, 255, 255),
    DescColor = Color3.fromRGB(180, 180, 190),
    SectionColor = Color3.fromRGB(150, 100, 255),
    Transparency = 0.35,
})
```
### Tabs and Sections

```lua
local Tab = Window:AddTab({ Name = "Combat", Icon = "lucide-sword" })
local Section = Tab:AddSection({ Name = "Aimbot", Icon = "lucide-target" })
```

Multiple tabs can be created in one call by passing a list:

```lua
local Tabs = Window:AddTab({
    Home     = { Name = "Main", Icon = "lucide-house" },
    Settings = { Name = "Settings", Icon = "lucide-settings" },
})
```

### Icons 
If you need to change some icon, you can take the icon from the site below and copy the name and put it 
- 'warn` that most of the icons on this site do not exist, so you will need to take the icon and upload it yourself and use it.
```
https://lucide.dev/icons
```

### Buttons

```lua
Section:AddButton({
    Name = "Reset Character",
    Description = "Reloads your character",
    Callback = function()
        -- action
    end,
	--[[ In case you want the button to be a check for completion
    Confirm = {
        Title = "Are you sure?",
        Content = "This will reload your character.",
    }, ]]
})
```

### Toggles

```lua
local MyToggle = Section:AddToggle({
    Name = "Auto Farm",
    Description = "Automatically farms nearby resources",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state)
    end,
})

MyToggle:Set(true)
print(MyToggle:Get())
```

### Sliders

```lua
local MySlider = Section:AddSlider("WalkSpeed", {
    Min = 16,
    Max = 200,
    Default = 16,
    Rounding = 0,
    Callback = function(value)
        print("WalkSpeed:", value)
    end,
})

MySlider:Set(50)
print(MySlider:Get())
```

### Dropdowns

Single selection:

```lua
local MyDropdown = Section:AddDropdown({
    Options = { "Option 1", "Option 2", "Option 3" },
    Default = "Option 1",
    Placeholder = "Select an option",
    Callback = function(selected)
        print("Selected:", selected)
    end,
})
```

Multi selection:

```lua
local MyMultiDropdown = Section:AddMultiDropdown({
    Options = { "Option 1", "Option 2", "Option 3" },
    Default = { "Option 1" },
    Callback = function(selectedList)
        print("Selected:", table.concat(selectedList, ", "))
    end,
})
```

### Keybinds

```lua
local MyKeybind = Section:AddKeybind("FlyKey", {
    Default = Enum.KeyCode.F,
    Mode = "Toggle",
    Callback = function(state)
        print("Fly toggled:", state)
    end,
})
```

### Inputs

```lua
local MyInput = Section:AddInput("Username", {
    Default = "",
    Callback = function(text)
        print("Input:", text)
    end,
})
```

### Notifications

```lua
Window:Notify({
    Title = "Success",
    Content = "Settings saved.",
    SubContent = "Just now",
    Duration = 5,
    icone = { Work = true, Type = "up", IdIcon = "" }, -- If you use the up, the notifications will be at the top, and if you use down, the notifications will be under
})
```

### Dialogs

```lua
Window:Dialog({
    Title = "Delete Config",
    Content = "This action cannot be undone.",
    Buttons = {
        { Title = "Delete", Callback = function() end },
        { Title = "Cancel", Callback = function() end },
    },
})
```

## Full API Reference

The API is organized into four groups: the window itself, navigation (tabs and sections), controls (the interactive elements placed inside a section), and feedback (notifications and dialogs).

### Window

#### `Vanta:Window(config)`

Creates and returns a window object, the root of the entire UI.

- `Title` — string, window title text, default `"Vanta"`
- `SubTitle` / `Description` — string, subtitle text next to the title, default `""`
- `Theme` — string | table, preset name or theme table, default `"Dark"`
- `Size` — UDim2, initial window size, default `UDim2.fromOffset(830, 525)`
- `TabWidth` — number, width of the vertical tab rail, default `160`
- `Resize` — boolean, adds a drag-resize handle, default `false`
- `Acrylic` — boolean, enables frosted-glass background, default `false`
- `MinimizeKey` — Enum.KeyCode, toggles the whole UI when pressed, no default
- `icno` — table `{ work, IdIcon, Size }`, adds the floating toggle icon, no default

**Returns:** the window object, which exposes every method below.

#### `Window:SetTheme(theme)`

Applies a new theme, given as a preset name or a theme table, live to the whole UI.

#### `Window:SetTitle(text)`

Updates the window title to the given string.

#### `Window:SetSubTitle(text)`

Updates the window subtitle to the given string.

#### `Window:Destroy()`

Removes the window, any open notifications and dialogs, and the floating icon (if one was created) from the game.

### Tabs and Sections

#### `Window:AddTab(config)`

Adds a tab to the window and returns a tab object.

- `Name` / `Title` — string, the tab's name
- `Icon` — string, icon name from the Lucide icon set

A list of config tables can be passed instead of one, in which case every entry is created as its own tab in a single call.

**Returns:** a tab object, or a list of tab objects when a list was passed in.

#### `Window:SelectTab(name)`

Programmatically switches the window to the tab with the given name.

#### `Tab:AddSection(config)`

Adds a section to a tab and returns a section object, which is where controls get added.

- `Name` / `Text` — string, section title
- `Icon` — string, icon name

A plain string can be passed instead of a table as shorthand for `Name`.

**Returns:** a section object.

### Controls

Every control below is created on a section object, and every control that holds a value returns a `Set` method to change that value programmatically and a `Get` method to read it back.

#### `Section:AddButton(config)`

- `Name` — string, button label
- `Description` — string, optional secondary line under the label
- `Callback` — function, called when the button is clicked
- `Confirm` — table `{ Title, Content, ConfirmText, CancelText, CancelCallback, Buttons }`, shows a confirmation dialog before `Callback` runs

**Returns:** `{ Frame, Name }`

#### `Section:AddToggle(config)`

- `Name` — string, toggle label
- `Description` — string, optional secondary line
- `Default` — boolean, initial state, default `false`
- `Callback` — function(state), called whenever the state changes

**Returns:** `{ Frame, Name, Set(self, value), Get() }`

#### `Section:AddSlider(name, config)`

- `name` — string, identifier and fallback title
- `Title` — string, overrides `name` for display
- `Min` — number, minimum value, default `0`
- `Max` — number, maximum value, default `100`
- `Default` — number, initial value
- `Rounding` — number, decimal places to round to
- `Callback` — function(value), called whenever the value changes

**Returns:** `{ Frame, Name, Set(self, value), Get() }`

#### `Section:AddDropdown(config)` and `Section:AddMultiDropdown(config)`

- `Options` — table, list of string options
- `Default` — string | table, preselected option (string for single, table for multi)
- `Placeholder` — string, text shown when nothing is selected
- `Callback` — function(value), called on change — receives a string (single) or a list (multi)

**Returns:** `{ Frame, Set(self, value), Get() }`

#### `Section:AddKeybind(name, config)`

- `name` — string, identifier and fallback title
- `Title` — string, overrides `name` for display
- `Default` — Enum.KeyCode | Enum.UserInputType, initial bound key
- `Mode` — string, `"Toggle"` or `"Hold"`
- `Callback` — function(state), called whenever the bound input fires

**Returns:** `{ Frame, Set(self, keyName), Get(), GetState() }`

#### `Section:AddInput(name, config)`

- `name` — string, identifier and fallback title
- `Title` — string, overrides `name` for display
- `Default` — string, initial text
- `Callback` — function(text), called when the text is submitted

**Returns:** `{ Frame, Set(self, value), Get() }`

### Feedback

#### `Window:Notify(config)`

- `Title` — string, notification title
- `Content` — string, main text
- `SubContent` — string, optional secondary text
- `Duration` — number, seconds before auto-dismiss
- `icone` — boolean | table, `true` for a default icon, or `{ Work, IdIcon, Type }` (`Type` = `"up"`/`"down"` for screen corner)
- `SoundID` — string, sound asset to play
- `SoundVolume` — number, default `1`
- `SoundSpeed` — number, default `1`
- `SoundLooped` — boolean, loops the sound when `true`

**Returns:** `{ Frame, Dismiss }`

#### `Window:Dialog(config)`

- `Title` — string, dialog title
- `Content` — string, dialog body text
- `Buttons` — table, list of `{ Title, Callback }`

**Returns:** `{ Frame, Close }`
