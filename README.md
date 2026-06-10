local OrbsUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Gui/refs/heads/main/main.lua"))()

local Window = OrbsUI.new({
    Title       = "Orbs",
    Description = "By FrontEvill",
    Theme       = "Purple",
    MinimizeKey = Enum.KeyCode.RightShift,
})

local Combat = Window:AddTab({ Name = "Combat", Icon = "combat" })

Combat:AddLabel({ Text = "Aimbot" })

local Aimbot = Combat:AddToggle({
    Name     = "Aimbot",
    Default  = false,
    Icon     = "target",
    Callback = function(v) end,
})

Combat:AddToggle({
    Name     = "Silent Aim",
    Default  = true,
    Icon     = "eye",
    Callback = function(v) end,
})

Combat:AddSlider({
    Name     = "FOV",
    Min      = 10,
    Max      = 180,
    Default  = 80,
    Suffix   = "°",
    Icon     = "zap",
    Callback = function(v) end,
})

Combat:AddSlider({
    Name     = "Smoothness",
    Min      = 1,
    Max      = 20,
    Default  = 5,
    Rounding = 1,
    Icon     = "signal",
    Callback = function(v) end,
})

Combat:AddSeparator()
Combat:AddLabel({ Text = "ESP" })

Combat:AddToggle({ Name = "Player ESP",  Default = true,  Icon = "user",   Callback = function(v) end })
Combat:AddToggle({ Name = "Box ESP",     Default = false, Icon = "shield", Callback = function(v) end })
Combat:AddToggle({ Name = "Health Bar",  Default = true,  Icon = "heart",  Callback = function(v) end })

Combat:AddDropdown({
    Name     = "Target Team",
    Items    = { "All", "Enemies Only", "Allies Only" },
    Default  = "All",
    Icon     = "search",
    Callback = function(v) end,
})

local Movement = Window:AddTab({ Name = "Movement", Icon = "movement" })

Movement:AddLabel({ Text = "Speed" })

local WalkSlider = Movement:AddSlider({
    Name     = "Walk Speed",
    Min      = 16,
    Max      = 250,
    Default  = 16,
    Icon     = "speed",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end,
})

local JumpSlider = Movement:AddSlider({
    Name     = "Jump Power",
    Min      = 50,
    Max      = 500,
    Default  = 50,
    Icon     = "arrow_up",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end,
})

Movement:AddSeparator()
Movement:AddLabel({ Text = "Abilities" })

Movement:AddToggle({ Name = "Fly",      Default = false, Icon = "fly",        Callback = function(v) end })
Movement:AddToggle({ Name = "Noclip",   Default = false, Icon = "ghost",      Callback = function(v) end })
Movement:AddToggle({ Name = "Inf Jump", Default = false, Icon = "star",       Callback = function(v) end })
Movement:AddToggle({ Name = "Low Grav", Default = false, Icon = "arrow_down", Callback = function(v) end })

Movement:AddButton({
    Name     = "Reset Speed",
    Icon     = "refresh",
    Callback = function()
        WalkSlider:Set(16)
        JumpSlider:Set(50)
    end,
})

local Visual = Window:AddTab({ Name = "Visual", Icon = "visual" })

Visual:AddColorPicker({
    Name     = "Theme Color",
    Callback = function(themeName, _)
        Window:SetTheme(themeName)
    end,
})

Visual:AddSeparator()
Visual:AddLabel({ Text = "World" })

Visual:AddToggle({
    Name     = "Fullbright",
    Default  = false,
    Icon     = "eye",
    Callback = function(v)
        game.Lighting.Brightness = v and 2 or 1
        game.Lighting.FogEnd     = v and 1e6 or 100000
    end,
})

Visual:AddToggle({
    Name     = "No Fog",
    Default  = true,
    Icon     = "map",
    Callback = function(v)
        game.Lighting.FogEnd = v and 1e6 or 100000
    end,
})

Visual:AddToggle({
    Name     = "No Shadows",
    Default  = false,
    Icon     = "shield",
    Callback = function(v)
        game.Lighting.GlobalShadows = not v
    end,
})

Visual:AddSlider({
    Name     = "Field of View",
    Min      = 70,
    Max      = 120,
    Default  = 70,
    Suffix   = "°",
    Icon     = "eye",
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end,
})

local Misc = Window:AddTab({ Name = "Misc", Icon = "misc" })

Misc:AddLabel({ Text = "Player" })

Misc:AddInput({
    Name        = "Display Name",
    Placeholder = "Enter display name...",
    Icon        = "user",
    Callback    = function(v) end,
})

Misc:AddDropdown({
    Name     = "Game Mode",
    Items    = { "Normal", "Competitive", "Sandbox", "Custom" },
    Default  = "Normal",
    Icon     = "star",
    Callback = function(v) end,
})

Misc:AddSeparator()
Misc:AddLabel({ Text = "Utility" })

Misc:AddToggle({ Name = "Anti AFK",    Default = true,  Icon = "refresh",     Callback = function(v) end })
Misc:AddToggle({ Name = "Auto Rejoin", Default = false, Icon = "arrow_right", Callback = function(v) end })

Misc:AddButton({
    Name     = "Copy Player ID",
    Icon     = "user",
    Callback = function()
        if setclipboard then
            setclipboard(tostring(game.Players.LocalPlayer.UserId))
        end
        Window:Notify({
            Title    = "Copied",
            Content  = "Player ID copied to clipboard.",
            Duration = 3,
        })
    end,
})

Misc:AddButton({
    Name     = "Rejoin",
    Icon     = "refresh",
    Confirm  = true,
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

Window:SetStatus("Orbs loaded successfully")

Window:Notify({
    Title    = "Orbs Loaded",
    Content  = "Welcome, " .. game.Players.LocalPlayer.DisplayName .. "!",
    Duration = 4,
})
