local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui
local debugEnabled = true

local auto_shake = function(toggle : boolean)
    local connection
    local lastButtonInstance = nil

    if not toggle or connection then
        if connection then
            connection:Disconnect()
            connection = nil
        end
        lastButtonInstance = nil
    elseif toggle then
        local success, error = pcall(function()
            local connection = RunService.RenderStepped:Connect(function()
                if playerGui:FindFirstChild("shakeui") and playerGui.shakeui.safezone.button then
                    local currentButton = playerGui.shakeui.safezone.button
                    if currentButton ~= lastButtonInstance then
                        lastButtonInstance = currentButton
                        local pos = currentButton.AbsolutePosition
                        local size = currentButton.AbsoluteSize
                        VIM:SendMouseButtonEvent(pos.X + (size.X / 2), pos.Y + (size.Y / 2), Enum.UserInputType.MouseButton1.Value, true, playerGui, 1)
                        VIM:SendMouseButtonEvent(pos.X + (size.X / 2), pos.Y + (size.Y / 2), Enum.UserInputType.MouseButton1.Value, false, playerGui, 1)
                    end
                else
                    lastButtonInstance = nil
                end
            end)
        end)
        if success and debugEnabled then
            print("Auto-shaking has been successfully toggled: " .. tostring(toggle))
        else
            warn(error)
        end
    end
end

local auto_reel = function(toggle : boolean)
    local connection
    if not toggle or connection then
        connection:Disconnect(); connection = nil
    elseif toggle then
        local success, error = pcall(function()
            connection = RunService.RenderStepped:Connect(function()
                local reel = playerGui:FindFirstChild("reel")
                if not reel then return end

                local bar = reel:FindFirstChild("bar")
                if not bar then return end

                local playerbar = bar:FindFirstChild("playerbar")
                
                if playerbar then
                    task.wait(.1)
                    ReplicatedStorage.events:FindFirstChild("reelfinished"):FireServer(100, true)
                end
            end)
        end)
        if success and debugEnabled then
            print("Auto-reel has been successfully toggled: " .. tostring(toggle))
        else
            warn(error)
        end
    end
end

local Window = Fluent:CreateWindow({
    Title = "Fisch | Private",
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
    -- local ToggleCast = Tabs.Main:AddToggle("AutoCast", {Title = "Auto Cast", Default = false })
    -- ToggleCast:OnChanged(function()
    --     State = Options.AutoCast.Value
    --     auto_cast(State)
    -- end)

    local ToggleMinigame = Tabs.Main:AddToggle("AutoMinigame", {Title = "Auto Minigame", Default = false })
    ToggleMinigame:OnChanged(function()
        State = Options.AutoMinigame.Value
        auto_shake(State)
    end)

    local ToggleReel = Tabs.Main:AddToggle("AutorReel", {Title = "Auto Reel", Default = false })
    ToggleReel:OnChanged(function()
        State = Options.AutorReel.Value
        auto_reel(State)
    end)

    local ToggleBaitCrate = Tabs.Main:AddToggle("SellBaitCrate", {Title = "Sell BaitCrate", Default = false })
    Toggle:OnChanged(function()
        _G.SellCrate = Options.SellBaitCrate.Value
        while _G.SellCrate do task.wait()
            local SCrate = workspace.world.npcs["Marc Merchant"].merchant.sell
            SCrate:InvokeServer()
        end
    end)
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
