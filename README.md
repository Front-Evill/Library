# Orbs GUI Library

A clean, modern Roblox GUI library with full theme support.

## Quick Start

```lua
local OrbsUI = loadstring(game:HttpGet("RAW_GITHUB_URL"))()

local Window = OrbsUI.new({
    Title = "Orbs",
    Description = "By FrontEvill",
    Theme = "Purple",
})

local Tab = Window:AddTab({ Name = "Combat", Icon = "sword" })

Tab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Icon = "target",
    Callback = function(val)
        print("Aimbot:", val)
    end
})
```

## Components
- `AddTab` — tab with icon
- `AddToggle` — on/off toggle
- `AddSlider` — value slider
- `AddButton` — clickable button
- `AddInput` — text input
- `AddDropdown` — dropdown list
- `AddLabel` — section label
- `AddColorPicker` — theme color picker
- `AddSeparator` — visual divider

## Themes
`Purple` `Red` `Cyan` `Green` `Gold` `Orange` `Pink` `White`

## Icons
`home` `settings` `user` `sword` `eye` `zap` `shield` `star`
`target` `map` `lock` `unlock` `bell` `trash` `edit` `check`
`close` `plus` `minus` `arrow_right` `arrow_left` `arrow_up`
`arrow_down` `refresh` `download` `upload` `search` `info`
`warning` `danger` `heart` `chat` `camera` `music` `run`
`fly` `speed` `ghost` `aimbot` `esp` `misc` `visual`
`combat` `movement` `script` `player` `world` `money`
`kill` `teleport`
