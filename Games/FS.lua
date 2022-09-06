local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/BizcuitMild/SamildHub/main/UILibrary/Source.lua'))()

local Window = Library:CreateWindow('Samild Hub', 'Fishing Simulator', 'Samild UI Library', 'rbxassetid://9346248665', false, 'VisualUIConfigs', 'Default')

-- Local Main
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local hum = player.Character.HumanoidRootPart
local mouse = player:GetMouse() 
local tpservice = game:GetService("TeleportService")
local VirtualUser = game:service'VirtualUser'

local ToolsCache = game:GetService("ReplicatedStorage").ToolsCache[player.UserId]
local plrTools
local bLocation
local fuckMonster
local fuckMobby

local seacreatureSelectionned
local locationSelected
local bSharks
local bShips
local rods
local eggs


-- Credits To Charwar for Server Hop
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end

-- Server Hop
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function switchServer()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

function teleport(loc)
    bLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    if game.Players.LocalPlayer.Character.Humanoid.Sit then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = loc
end

-- Get Tools Name (Just hidden the tool in replicatedstorage, savageeeee but characte win)
for i, getTools in pairs(player.Character:GetChildren()) do
    if getTools:IsA("Tool") and  getTools:FindFirstChild("GripC1") then
        plrTools = getTools.Name
    end
end

function EquipTool()
    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetEquippedItem:InvokeServer(2)
    local args = {
     [1] = game:GetService("ReplicatedStorage").ToolsCache:FindFirstChild(player.UserId)[plrTools]
    }
    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EquipTool:FireServer(unpack(args))
end

game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Farm
local FarmFunctions = Window:CreateTab('Farms', true, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local Farming = FarmFunctions:CreateSection('Auto Sea Creatures Hunt')
local Toggle = Farming:CreateToggle('Auto Kill All', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    shared.toggle = State
    if shared.toggle then
        fuckMonster = RunService.Stepped:Connect(function()
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end
                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 30, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
                    break
                    end
                end
            end
        end)
    else
        fuckMonster:Disconnect()
        teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
    end
end)

local Toggle = Farming:CreateToggle('Auto Kill Mobby Wood', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    shared.toggle = State
    if shared.toggle then
        fuckMobby = RunService.Stepped:Connect(function()
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") and v.Name == "MobyWood" then
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    for i, getTools in pairs(player.Character:GetChildren()) do
                        if getTools:IsA("Tool") and getTools:FindFirstChild("GripC1") then
                            plrTools = getTools.Name
                        end
                    end
                    teleport(v.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0))
                    wait(1)
                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.MonsterHit:FireServer(game.workspace[v.Name], tostring(plrTools), true)
                    break
                elseif not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    EquipTool()
                    break
                    end
                end
            end
        end)
    else
        fuckMobby:Disconnect()
        teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))
    end
end)

--[[
local SelectToolWeapon = FarmFunctions:CreateSection('Select Weapon')

local Toggle = SelectToolWeapon:CreateToggle('Auto EquipTool', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetEquippedItem:InvokeServer(2)
        local args = {
        [1] = game:GetService("ReplicatedStorage").ToolsCache:FindFirstChild(player.UserId)[plrTools]
        }
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EquipTool:FireServer(unpack(args))
    end
end)
]]

-- EquipTool()
-- game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
--     EquipTool()
-- end)

-- ESP

local ESPFunctions = Window:CreateTab('ESP', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local ESP = ESPFunctions:CreateSection('ESP Functions')
local Toggle = ESP:CreateToggle('Find Sea Creatures', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    if toggle then
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v:FindFirstChild("Health") and v:FindFirstChild("IsSeaMonster") then
                local x = Instance.new('BillboardGui', v.HumanoidRootPart)
                x.AlwaysOnTop = true
                x.Size = UDim2.new(10, 0, 10, 0)
                x.Name = "noCharMatch"
                local label = Instance.new("TextLabel", x)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.BorderSizePixel = 0
                label.BackgroundTransparency = 1
                label.TextScaled = true
                label.Text = v.Name
                label.Size = UDim2.new(15, 0, 6, 0)
            end
        end
        bSharks = game.Workspace.ChildAdded:Connect(function(child)
            if child:FindFirstChild("Health") and child:FindFirstChild("IsSeaMonster") then
                local x = Instance.new('BillboardGui', v.HumanoidRootPart)
                x.AlwaysOnTop = true
                x.Size = UDim2.new(10, 0, 10, 0)
                x.Name = "noCharMatch"
                local label = Instance.new("TextLabel", x)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.BorderSizePixel = 0
                label.BackgroundTransparency = 1
                label.TextScaled = true
                label.Text = v.Name
                label.Size = UDim2.new(15, 0, 6, 0)
            end
        end)
   	else
		for p, q in pairs(game.Workspace:GetDescendants()) do
			if q.Name == "noCharMatch" then
				q:Destroy()
			end
		end
        bSharks:Disconnect()
    end
end)

local Space = FarmFunctions:CreateSection('')
local AutoFarming = FarmFunctions:CreateSection('Auto Fishing')
local Toggle = AutoFarming:CreateToggle('Auto Caught', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.FishCaught:FireServer()
    end
end)
local Toggle = AutoFarming:CreateToggle('Auto Sell', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        wait(2.6)
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.processGameItemSold:InvokeServer("SellEverything")
    end
end)
local Toggle = AutoFarming:CreateToggle('Auto Lock Rare Items', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    if toggle then
        while toggle do
            wait(.1)
            for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Interface.Inventory.Inventory.Frame.Backpack.List.Container:GetChildren()) do
                if string.match(v.Name, "key") then
                    for i, model in pairs(v:GetDescendants()) do
                        if model:IsA("Tool") then
                            if model.RarityLevel.Value >= 4 then
                                if v.DraggableComponent.Contents.LockIcon.Visible == false then
                                    print(v.Name, model.Name, model.RarityLevel.Value)
                                    local args = {
                                        [1] = "Tools",
                                        [2] = v.Name,
                                        [3] = true
                                    }
                                    game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.SetInventoryItemLock:InvokeServer(unpack(args))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


-- Chest
local ChestFunctions = Window:CreateTab('Chests', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))
local AutoChest = ChestFunctions:CreateSection('Chests')
local Toggle = AutoChest:CreateToggle('Daily Chest', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        for i, v in pairs(game.Workspace.Islands:GetDescendants()) do
            if v:IsA("Model") and string.match(v.Name, "Chest") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                wait(1)
                fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
            end
        end            
    end
end)
local Toggle = AutoChest:CreateToggle('Random Chest', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        for i, v in pairs(game.Workspace.RandomChests:GetDescendants()) do
            if v:IsA("Model") and string.match(v.Name, "Chest") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                wait(1)
                fireproximityprompt(v.HumanoidRootPart.ProximityPrompt)
            end
        end            
    end
end)
local Toggle = AutoChest:CreateToggle('Suken Chest', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        wait(5)
        for i, v in pairs(game.Workspace:GetChildren()) do
           if string.find(v.Name, "ShipModel") then
                   teleport(v.HitBox.CFrame)
                   for i, x in pairs(v:GetChildren()) do
                       if string.match(x.Name, "Chest_") then
                           teleport(x.HumanoidRootPart.CFrame)
                           wait(1)
                           fireproximityprompt(x.HumanoidRootPart.ProximityPrompt)    
                       end                                
                   end
               break
            end
        end
    end
end)

-- Teleport
local TeleportsFunctions = Window:CreateTab('Teleports', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local TeleportStore = TeleportsFunctions:CreateSection('Teleport Store')
local Dropdown = TeleportStore:CreateDropdown('Store =>', {"Boat Store","Raygan's Tavern","Supplies Store", "Pets Store"}, 'Boat Store', 0.25, function(String)
    locationSelected = String
end)
local Button = TeleportStore:CreateButton('Teleport', function()
    if locationSelected == "Boat Store" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("BoatShopInterior", "Inside")
    elseif locationSelected == "Raygan's Tavern" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("TavernInterior", "Inside")
    elseif locationSelected == "Supplies Store" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("SuppliesStoreInterior", "Inside")  
    elseif locationSelected == "Pets Store" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.EnterDoor:InvokeServer("PetShop", "MainEntrance")
    end
end)

local Space = TeleportsFunctions:CreateSection('')
local TeleportLocation = TeleportsFunctions:CreateSection('Teleport Location')
local Dropdown = TeleportLocation:CreateDropdown('Location =>', {"Port Jackson","Ancient Shores","Shadow Isles", "Pharaoh's Dunes", "Eruption Island", "Monster's Borough", "Suken Ship"}, 'Port Jackson', 0.25, function(String)
    locationSelected = String
end)
local Button = TeleportLocation:CreateButton('Teleport', function()
    if locationSelected == "Port Jackson" then
            teleport(CFrame.new(1.8703980445862, 53.57190322876, -188.37982177734))           
        elseif locationSelected == "Ancient Shores" then
            teleport(CFrame.new(-2436.431640625, 43.564971923828, -1683.4526367188))    
        elseif locationSelected == "Shadow Isles" then
            teleport(CFrame.new(2196.9926757812, 43.491630554199, -2216.4543457031))    
        elseif locationSelected == "Pharaoh's Dunes" then
            teleport(CFrame.new(-4142.74609375, 46.71378326416, 262.05679321289))
        elseif locationSelected == "Eruption Island" then
            teleport(CFrame.new(3022.9311523438, 52.347640991211, 1323.74609375))
        elseif locationSelected == "Monster's Borough" then
            teleport(CFrame.new(-3211.9047851562, 41.850345611572, 2735.306640625))  
        elseif locationSelected == "Suken Ship" then
            for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "ShipModel") then
                    teleport(v.HitBox.CFrame)
                break
            end
        end                               
    end
end)

-- Boats

local BoatsFunctions = Window:CreateTab('Boats', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local Boats = BoatsFunctions:CreateSection('Boats Functions')
local BoatSpeed = Boats:CreateSlider('Boat Speed', 0, 150, 0, Color3.fromRGB(0, 125, 255), function(Value)
    for i, v in pairs(game.Workspace:GetChildren()) do
        if v.Name == (game.Players.LocalPlayer.Name .. "'s Boat") then
            v.Controller.VehicleSeat.MaxSpeed = tonumber(Value)
        end
    end 
end)
local Button = Boats:CreateButton('TP to Boat', function()
    for i, v in pairs(game.Workspace:GetChildren()) do
        if v.Name == (game.Players.LocalPlayer.Name .. "'s Boat") then
            teleport(v.Controller.VehicleSeat.CFrame + Vector3.new(0, 3, 0))
        end
    end
end)
local Button = Boats:CreateButton('Remove Borders', function()
    for i, v in pairs(game.Workspace.IgnoredByMouse.BoatBorders:GetChildren()) do
        v:Destroy()
    end
end)

-- Rod and Egg
local RodsEggsFunctions = Window:CreateTab('Rods, Eggs', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local RodsFunctions = RodsEggsFunctions:CreateSection('Random Rods')
local Dropdown = RodsFunctions:CreateDropdown('Rods', {"Silver", "Stone", "Gold"}, 'Silver', 0.25, function(String)
    rods = String
end)
local Button = RodsFunctions:CreateButton('Buy', function()
    if rods == "Silver" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("silverchest")    
    elseif rods == "Stone" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("stonechest")    
    elseif rods == "Gold" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("goldchest")            
    end
end)

local Space = RodsEggsFunctions:CreateSection('')
local EggsFunctions = RodsEggsFunctions:CreateSection('Random Eggs')
local Dropdown = EggsFunctions:CreateDropdown('Eggs', {"Royals","Normal","Ruby", "Void"}, 'Royals', 0.25, function(String)
    eggs = String
end)
local Button = EggsFunctions:CreateButton('Buy', function()
    if eggs == "Royals" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("royalegg")    
    elseif eggs == "Normal" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("normalegg")   
    elseif eggs == "Ruby" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("rubyegg")   
    elseif eggs == "Void" then
        game:GetService("ReplicatedStorage").CloudFrameShared.DataStreams.OpenLootboxFunction:InvokeServer("voidegg")         
    end
end)


-- Misc
local MiscFunctions = Window:CreateTab('Misc', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))
local Misc = MiscFunctions:CreateSection('Misc')
local Toggle = Misc:CreateToggle('Reduce Lag', true, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    if toggle then
        while toggle do 
            wait(30)
            for i, v in pairs(game.Workspace.DroppedItems:GetChildren()) do
                if v:IsA("Model") then
                    v:Destroy()
                end
            end
        end
    end
end)
local Toggle = Misc:CreateToggle('Remove Fog', false, Color3.fromRGB(0, 125, 255), 0.25, function(State)
    toggle = State
    while toggle do
        if  game.Lighting.FogEnd == 100 then
            game.Lighting.FogEnd = 1000000
        end
        game.Lighting.FogEnd = 1000000
        game.Lighting.GlobalLighting:Destroy()
        game.Lighting.Atmosphere:Destroy()     
        game.Lighting.Lighting:Destroy()  
        game.Lighting.ColorCorrection:Destroy()     
        game.Lighting.Bloom:Destroy()     
        game.Lighting.Blur:Destroy()     
        game.Lighting.Atmosphere:Destroy()                 
    end
end)
local Button = Misc:CreateButton('Instant ProximityPompt', function()
    game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
        prompt.HoldDuration = 0
    end)
end)
local Button = Misc:CreateButton('Rejoins', function()
    tpservice:Teleport(game.PlaceId, plr)
end)
local Button = Misc:CreateButton('Server Hop', function()
    switchServer()
end)
local Button = Misc:CreateButton('Discord', function()
    --setclipboard("cT34Cx4TGC")
    if not isfolder("SamildHub") then makefolder("SamildHub") end
    if isfile("SamildHub.txt") == false then
        (syn and syn.request or http_request)({
            Url = "http://127.0.0.1:6463/rpc?v=1",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Origin"] = "https://discord.com"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                cmd = "INVITE_BROWSER",
                args = {
                    code = "cT34Cx4TGC"
                },
                nonce = game:GetService("HttpService"):GenerateGUID(false)
            }),
            writefile("Mild.txt", "discord")
        })
    end 
end)

---------------------------------
---------------------------------
local LibrarySettings = Window:CreateTab('Settings', false, 'rbxassetid://9346248665', Vector2.new(524, 44), Vector2.new(36, 36))

local UISettings = LibrarySettings:CreateSection('Settings')

local ToggleKeybind = UISettings:CreateKeybind('Toggle UI', 'RightShift', function()
    Library:ToggleUI()
end)

local TransparencySlider = UISettings:CreateSlider('Transparency', 0, 100, 0, Color3.fromRGB(0, 125, 255), function(Value)
    Library:SetTransparency(Value / 100, true)
end)

local Space = LibrarySettings:CreateSection('')
local ThemesSection = LibrarySettings:CreateSection('Themes')

local ThemesDropdown = ThemesSection:CreateDropdown('Themes', Library:GetThemes(), nil, 0.25, function(Value)
    Library:ChangeTheme(Value)
end)