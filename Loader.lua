--// idk its nice \\--

local is_synapse_function = is_synapse_function or issentinelclosure
local Library
local uESP
local Utils = {}
local Library
local TweenService = game:GetService("TweenService")
local window 
local universal
local loopAPI = {}
local LoopThreads = {}
local Games = {
	[2753915549] = "Blox Fruits",
	[2317712696] = "The Wild West",
	[2866967438] = "Fishing Simulator",
}
local GameName = Games[game.PlaceId] or (function() -- solution for multiple places in a game
	local Game = "No Game Detected"
	return Game
end)()
local function Resize (part,new,_delay)
	_delay = _delay or 0.5
	local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(part, tweenInfo, new)
	tween:Play()
end
do -- Loop API (since jailtapper)
	local function CreateThread(func) 
		local thread = coroutine.create(func)
		coroutine.resume(thread)
	end
	function loopAPI:CreateLoop(name, WaitMethod, func, runLoop) 
		LoopThreads[name] = {}
		LoopThreads[name]["running"] = false
		LoopThreads[name]["destroy"] = false
		CreateThread(function() 
			while true do 
				if typeof(WaitMethod) == "userdata" then WaitMethod:Wait() else WaitMethod() end
				if LoopThreads[name]["running"] then 
					func()
				end
				if LoopThreads[name]["destroy"] then 
					LoopThreads[name] = nil
					break
				end
			end
		end)
		if runLoop then 
			self:RunLoop(name)
		end
	end
	function loopAPI:RunLoop(name, WaitMethod, func) 
		if LoopThreads[name] then 
			LoopThreads[name]["running"] = true
		end
	end
	function loopAPI:StopLoop(name) 
		if LoopThreads[name] then 
			LoopThreads[name]["running"] = false
		end
	end
	function loopAPI:DestroyLoop(name) 
		if LoopThreads[name] then 
			LoopThreads[name]["destroy"] = true
		end
	end
end
local function CreateDrag(gui)
	local UserInputService = game:GetService("UserInputService")
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		Resize(gui, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.16)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

do -- UI Library 

	--// Services \\--
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local CoreGui = RunService:IsStudio() and game:GetService("Players").LocalPlayer.PlayerGui or game:GetService("CoreGui")

	--// Functions \\--
	local function keyCheck(x,x1)
		for _,v in next, x1 do
			if v == x then 
				return true
			end 
		end
	end
end

do -- Utils API
	Utils.AddLaunch = function(LaunchName, func) 
		getfenv(1)[LaunchName] = {}
		getfenv(1)[LaunchName].launch = function() 
			func()
		end
	end
end

Utils.AddLaunch("HubLauncher", function() 
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Close = Instance.new("TextButton")
	local Detail = Instance.new("ImageLabel")
	local Settings = Instance.new("TextButton")
	local Detail_2 = Instance.new("ImageLabel")
	local MainTab = Instance.new("Frame")
	local Kinorana1 = Instance.new("TextLabel")
	local Kinorana2 = Instance.new("TextLabel")
	local KeyFrame = Instance.new("Frame")
	local TextBox = Instance.new("TextBox")
	local KeyIcon = Instance.new("ImageLabel")
	local RememberMe = Instance.new("TextLabel")
	local CheckBox = Instance.new("TextButton")
	local Login = Instance.new("TextButton")
	local KeyLabel = Instance.new("TextLabel")
	local SettingsTab = Instance.new("Frame")
	local Kinorana1_2 = Instance.new("TextLabel")
	local Kinorana2_2 = Instance.new("TextLabel")
	local GameDetection = Instance.new("TextLabel")
	local BackIcon = Instance.new("TextButton")
	local loggingIn = false
	local Colors = {Vaild = Color3.fromRGB(255, 200, 255), Invaild = Color3.new(1, 0.254902, 0.254902)}
	ScreenGui.Parent = game.CoreGui

	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
	Frame.BorderColor3 = Color3.new(0.815686, 0.815686, 0.815686)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.04093327, 0, 0.337049246, 0)
	Frame.Size = UDim2.new(0, 386, 0, 127)
	CreateDrag(Frame)
	Close.Name = "Close"
	Close.Parent = Frame
	Close.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(1, -25, 0, 0)
	Close.Size = UDim2.new(0, 25, 0.211321458, 0)
	Close.AutoButtonColor = false
	Close.Font = Enum.Font.SourceSans
	Close.Text = ""
	Close.TextColor3 = Color3.new(0, 0, 0)
	Close.TextSize = 14
	Close.MouseButton1Click:Connect(function() 
		ScreenGui:Destroy()
	end)
	Detail.Name = "Detail"
	Detail.Parent = Close
	Detail.BackgroundColor3 = Color3.new(1, 1, 1)
	Detail.BackgroundTransparency = 1
	Detail.Position = UDim2.new(0.5, -8, 0.5, -8)
	Detail.Size = UDim2.new(0, 15, 0, 15)
	Detail.Image = "rbxassetid://3487597401"

	Settings.Name = "Settings"
	Settings.Parent = Frame
	Settings.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
	Settings.BorderSizePixel = 0
	Settings.Position = UDim2.new(1.02331603, -47, 0, 0)
	Settings.Size = UDim2.new(-0.023316063, 25, 0.211321458, 0)
	Settings.AutoButtonColor = false
	Settings.Font = Enum.Font.SourceSans
	Settings.Text = ""
	Settings.TextColor3 = Color3.new(0, 0, 0)
	Settings.TextSize = 14

	Detail_2.Name = "Detail"
	Detail_2.Parent = Settings
	Detail_2.BackgroundColor3 = Color3.new(1, 1, 1)
	Detail_2.BackgroundTransparency = 1
	Detail_2.Position = UDim2.new(0.5, -8, 0.5, -8)
	Detail_2.Size = UDim2.new(0, 15, 0, 15)
	Detail_2.Image = "rbxassetid://2766645188"

	MainTab.Name = "MainTab"
	MainTab.Parent = Frame
	MainTab.BackgroundColor3 = Color3.new(1, 1, 1)
	MainTab.BackgroundTransparency = 1
	MainTab.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
	MainTab.Size = UDim2.new(0, 386, 0, 127)

	Kinorana1.Name = "Kinorana1"
	Kinorana1.Parent = MainTab
	Kinorana1.BackgroundColor3 = Color3.new(1, 1, 1)
	Kinorana1.BackgroundTransparency = 1
	Kinorana1.Position = UDim2.new(0.372686356, 0, 0.0636268258, 0)
	Kinorana1.Size = UDim2.new(0, 36, 0, 18)
	Kinorana1.Font = Enum.Font.SourceSansBold
	Kinorana1.Text = "Samild"
	Kinorana1.TextColor3 = Color3.new(1, 1, 1)
	Kinorana1.TextSize = 30

	Kinorana2.Name = "Kinorana2"
	Kinorana2.Parent = MainTab
	Kinorana2.BackgroundColor3 = Color3.new(1, 1, 1)
	Kinorana2.BackgroundTransparency = 1
	Kinorana2.Position = UDim2.new(0.486676008, 0, 0.0636268705, 0)
	Kinorana2.Size = UDim2.new(0, 53, 0, 18)
	Kinorana2.Font = Enum.Font.SourceSansBold
	Kinorana2.Text = "   Hub"
	Kinorana2.TextColor3 = Color3.new(1, 0.254902, 0.254902)
	Kinorana2.TextSize = 30

	KeyFrame.Name = "KeyFrame"
	KeyFrame.Parent = MainTab
	KeyFrame.BackgroundColor3 = Color3.new(0.980392, 0.980392, 0.980392)
	KeyFrame.BorderSizePixel = 0
	KeyFrame.Position = UDim2.new(0.0231865197, 0, 0.392999977, 0)
	KeyFrame.Size = UDim2.new(0, 368, 0, 34)

	TextBox.Parent = KeyFrame
	TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
	TextBox.BackgroundTransparency = 1
	TextBox.Position = UDim2.new(0.0867036358, 0, 0, 0)
	TextBox.Size = UDim2.new(0, 335, 0, 34)
	TextBox.Font = Enum.Font.SourceSans
	TextBox.PlaceholderColor3 = Color3.new(0.698039, 0.698039, 0.698039)
	TextBox.PlaceholderText = "Please input your key"
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.new(0, 0, 0)
	TextBox.TextSize = 16
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	Callback = function(Value)
		TextBox.Text = Value
	end

	KeyIcon.Name = "KeyIcon"
	KeyIcon.Parent = KeyFrame
	KeyIcon.BackgroundColor3 = Color3.new(0.980392, 0.980392, 0.980392)
	KeyIcon.BackgroundTransparency = 1
	KeyIcon.BorderSizePixel = 0
	KeyIcon.Position = UDim2.new(0.0142740402, 0, 0.174600363, 0)
	KeyIcon.Size = UDim2.new(0, 19, 0, 21)
    KeyIcon.Image = "http://www.roblox.com/asset/?id=4510496189"

    Name = game.Players.LocalPlayer.Name

	RememberMe.Name = "RememberMe"
	RememberMe.Parent = MainTab
	RememberMe.BackgroundColor3 = Color3.new(1, 1, 1)
	RememberMe.BackgroundTransparency = 1
	RememberMe.Position = UDim2.new(0.105846979, 0, 0.731006682, 0)
	RememberMe.Size = UDim2.new(0, 73, 0, 22)
	RememberMe.Font = Enum.Font.Gotham
	RememberMe.Text = "HELLO : "..Name..""
	RememberMe.TextColor3 = Color3.new(1, 1, 1)
    RememberMe.TextSize = 12
    
    --[[
	CheckBox.Name = "CheckBox"
	CheckBox.Parent = MainTab
	CheckBox.BackgroundColor3 = Color3.new(0.980392, 0.980392, 0.980392)
	CheckBox.BorderSizePixel = 0
	CheckBox.Position = UDim2.new(0.0231865197, 0, 0.724546075, 0)
	CheckBox.Size = UDim2.new(0, 19, 0, 19)
	CheckBox.Font = Enum.Font.SourceSansBold
	CheckBox.Text = "CheckBox"
	CheckBox.TextColor3 = Color3.new(0, 0, 0)
    CheckBox.TextSize = 14
    ]]

	Login.Name = "Login"
	Login.Parent = MainTab
	Login.BackgroundColor3 = Color3.new(1, 0.254902, 0.254902)
	Login.BorderColor3 = Color3.new(1, 0.254902, 0.254902)
	Login.Position = UDim2.new(0.795336783, 0, 0.724546075, 0)
	Login.Size = UDim2.new(0, 69, 0, 24)
	Login.Font = Enum.Font.SourceSansBold
	Login.Text = "Login"
	Login.TextColor3 = Color3.new(1, 1, 1)
	Login.TextSize = 14
	Login.MouseButton1Click:Connect(function() 
		if not loggingIn then
			if TextBox.Text == "itsmemild" then
				Kinorana2.TextColor3 = Colors.Vaild
				wait(0.30)
				ScreenGui:Destroy()
				Hub.launch()
				loggingIn = true
			else
				loggingIn = false
				print("Login Fail!")
			end
		end
	end)

	KeyLabel.Name = "KeyLabel"
	KeyLabel.Parent = MainTab
	KeyLabel.BackgroundColor3 = Color3.new(1, 1, 1)
	KeyLabel.BackgroundTransparency = 1
	KeyLabel.Position = UDim2.new(0.0177640766, 0, 0.211321488, 0)
	KeyLabel.Size = UDim2.new(0, 27, 0, 18)
	KeyLabel.Font = Enum.Font.GothamSemibold
	KeyLabel.Text = "Key"
	KeyLabel.TextColor3 = Color3.new(1, 1, 1)
	KeyLabel.TextSize = 12

	SettingsTab.Name = "SettingsTab"
	SettingsTab.Parent = Frame
	SettingsTab.BackgroundColor3 = Color3.new(1, 1, 1)
	SettingsTab.BackgroundTransparency = 1
	SettingsTab.BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843)
	SettingsTab.Size = UDim2.new(0, 386, 0, 127)
	SettingsTab.Visible = false

	Kinorana1_2.Name = "Kinorana1"
	Kinorana1_2.Parent = SettingsTab
	Kinorana1_2.BackgroundColor3 = Color3.new(1, 1, 1)
	Kinorana1_2.BackgroundTransparency = 1
	Kinorana1_2.Position = UDim2.new(0.372686356, 0, 0.0636268258, 0)
	Kinorana1_2.Size = UDim2.new(0, 36, 0, 18)
	Kinorana1_2.Font = Enum.Font.SourceSansBold
	Kinorana1_2.Text = "SamildHub           "
	Kinorana1_2.TextColor3 = Color3.new(1, 1, 1)
	Kinorana1_2.TextSize = 30

	Kinorana2_2.Name = "Kinorana2"
	Kinorana2_2.Parent = SettingsTab
	Kinorana2_2.BackgroundColor3 = Color3.new(1, 1, 1)
	Kinorana2_2.BackgroundTransparency = 1
	Kinorana2_2.Position = UDim2.new(0.486676008, 0, 0.0636268705, 0)
	Kinorana2_2.Size = UDim2.new(0, 53, 0, 18)
	Kinorana2_2.Font = Enum.Font.SourceSansBold
	Kinorana2_2.Text = "           Settings"
	Kinorana2_2.TextColor3 = Color3.new(1, 0.254902, 0.254902)
	Kinorana2_2.TextSize = 30

	GameDetection.Name = "GameDetection"
	GameDetection.Parent = SettingsTab
	GameDetection.BackgroundColor3 = Color3.new(1, 1, 1)
	GameDetection.BackgroundTransparency = 1
	GameDetection.Position = UDim2.new(0.34455958, 0, 0.385826886, 0)
	GameDetection.Size = UDim2.new(0, 119, 0, 28)
	GameDetection.Font = Enum.Font.SourceSansBold
	GameDetection.Text = GameName
	GameDetection.TextColor3 = Color3.new(1, 1, 1)
	GameDetection.TextSize = 16

	BackIcon.Name = "BackIcon"
	BackIcon.Parent = Frame
	BackIcon.BackgroundColor3 = Color3.new(0.129412, 0.129412, 0.129412)
	BackIcon.BorderSizePixel = 0
	BackIcon.Position = UDim2.new(1.02331603, -47, 0, 0)
	BackIcon.Size = UDim2.new(-0.023316063, 25, 0.211321458, 0)
	BackIcon.Visible = false
	BackIcon.AutoButtonColor = false
	BackIcon.Font = Enum.Font.SourceSans
	BackIcon.TextColor3 = Color3.new(1, 1, 1)
	BackIcon.TextSize = 20

	-- Scripts:

	local function SGKS_fake_script() -- Settings.LocalScript 
		local script = Instance.new('LocalScript', Settings)

		local SettingsButton = script.Parent
		local GUIFrame = SettingsButton.Parent
		SettingsButton.MouseButton1Click:Connect(function() 
			GUIFrame.MainTab.Visible = false
			SettingsButton.Visible = false
			GUIFrame.SettingsTab.Visible = true
			GUIFrame.BackIcon.Visible = true
		end)
	end
	coroutine.wrap(SGKS_fake_script)()
	local function EYWK_fake_script() -- CheckBox.LocalScript 
		local script = Instance.new('LocalScript', CheckBox)

		local BackIcon = script.Parent
		BackIcon.Text = utf8.char(10003)
	end
	coroutine.wrap(EYWK_fake_script)()
	local function HOCN_fake_script() -- BackIcon.LocalScript 
		local script = Instance.new('LocalScript', BackIcon)

		local BackIcon = script.Parent
		local GUIFrame = BackIcon.Parent
		BackIcon.Text = utf8.char(8592)
		BackIcon.MouseButton1Click:Connect(function() 
			GUIFrame.MainTab.Visible = true
			BackIcon.Visible = false
			GUIFrame.SettingsTab.Visible = false
			GUIFrame.Settings.Visible = true
		end)
	end
	coroutine.wrap(HOCN_fake_script)()

end)
Utils.AddLaunch("UIInit", function()
	--window = Library:CreateTab(GameName == "No Game Detected" and "Universal" or GameName)
	print("Running the scripts")
end)
Utils.AddLaunch("BloxFruits", function() 
	loadstring(game:HttpGet('https://raw.githubusercontent.com/BizcuitMild/SamildHub/main/Games/BF.lua'))()
end)
Utils.AddLaunch("WildWest", function() 
    loadstring(game:HttpGet('https://raw.githubusercontent.com/BizcuitMild/SamildHub/main/Games/TWW.lua'))()
end)
Utils.AddLaunch("FishingSimulator", function() 
    loadstring(game:HttpGet('https://raw.githubusercontent.com/BizcuitMild/SamildHub/main/Games/FS.lua'))()
end)

Utils.AddLaunch("Hub", function()
	if GameName == "Blox Fruits" then
		--UIInit.launch()	
		--BloxFruits.launch()
	elseif GameName == "The Wild West" then
		--UIInit.launch()
		--WildWest.launch()
	elseif GameName == "Fishing Simulator" then
		UIInit.launch()
		FishingSimulator.launch()
	else
		Universal.launch()
	end
end)
HubLauncher.launch()
--// I wonder if ever anyone looks here. Well thx for source