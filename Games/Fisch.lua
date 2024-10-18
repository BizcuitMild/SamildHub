local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fisch Private",
    SubTitle = "by Samild.",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "house" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do


    local Toggle = Tabs.Main:AddToggle("GiveBaitCrate", {Title = "Give BaitCrate", Default = false })
    Toggle:OnChanged(function()
        print("Toggle changed:", Options.GiveBaitCrate.Value)
        _G.GiveCrate = Options.GiveBaitCrate.Value
        while _G.GiveCrate do task.wait()
            local GetCrate = workspace.world.npcs.Phineas.phineas.finishQuest
            GetCrate:InvokeServer()
        end
    end)
    Options.GiveBaitCrate:SetValue(false)



    local Toggle = Tabs.Main:AddToggle("SellBaitCrate", {Title = "Sell BaitCrate", Default = false })
    Toggle:OnChanged(function()
        print("Toggle changed:", Options.SellBaitCrate.Value)
        _G.SellCrate = Options.SellBaitCrate.Value
        while _G.SellCrate do task.wait()
            local SCrate = workspace.world.npcs["Marc Merchant"].merchant.sell
            SCrate:InvokeServer()
        end
    end)
    Options.SellBaitCrate:SetValue(false)
end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
