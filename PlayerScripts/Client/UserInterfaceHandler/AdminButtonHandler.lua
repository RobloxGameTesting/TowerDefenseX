local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local parent = script.Parent.Parent
local gameClass = parent:WaitForChild("GameClass")
local userInterfaceHandler = parent:WaitForChild("UserInterfaceHandler")
local characterClass = gameClass:WaitForChild("BaseClasses"):WaitForChild("CharacterClass")
local color = Color3.fromRGB(145, 255, 55)
local color2 = Color3.fromRGB(125, 210, 35)
local SPECTATOR_ADMIN_BUTTONS = _G.SPECTATOR_ADMIN_BUTTONS
local LocalPlayer = Players.LocalPlayer
local bottomLeftButtons = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomLeftButtons")
local textLabel = bottomLeftButtons:WaitForChild("SpeedToggle"):WaitForChild("TextLabel")
local pause = bottomLeftButtons:WaitForChild("Pause")
local pause2 = bottomLeftButtons:WaitForChild("Pause2")
local textLabel2 = pause:WaitForChild("TextLabel")
local textLabel3 = pause2:WaitForChild("TextLabel")
local textLabel4 = bottomLeftButtons:WaitForChild("Difficulty"):WaitForChild("TextLabel")
local v = NetworkingHandler.GetFunction("AdminPanelRequest")
local event = BindableHandler.GetEvent("RemoveTowerCircles")
local event2 = BindableHandler.GetEvent("SetSpeedMultiplier")
local event3 = BindableHandler.GetEvent("SetDifficulty")
local event4 = BindableHandler.GetEvent("DefaultUpgradePathLevelChanged")
local event5 = BindableHandler.GetEvent("RandomizeTowers")
local event6 = BindableHandler.GetEvent("RefreshTowersBar")
local event7 = BindableHandler.GetEvent("ResetAbilities")
local event8 = BindableHandler.GetEvent("AdminPressButtonWithName")
local v2 = {
	SkipWave = {
		LeftButtonClick = function(p: string)
			v:InvokeServer(p)
		end,
		RightButtonClick = function(p: string)
			v:InvokeServer(p, true, 5)
			local module = require(gameClass)
			local currentGame = module.GetCurrentGame()

			if currentGame then
				currentGame:Tick(5)
				local module2 = require(userInterfaceHandler)
				module2.Update(5, currentGame:GetState(), currentGame:GetSpeedMultiplier())
			end
		end
	},
	Circle = {
		LeftButtonClick = function(_: string)
			event:Fire()
		end
	},
	DefaultUpgradePath1 = {
		LeftButtonClick = function(p: string)
			local v2 = v:InvokeServer(p)
			event4:Fire(v2, nil)
			return "P1: " .. tostring(v2)
		end,
		RightButtonClick = function(p: string)
			local v2 = v:InvokeServer(p, true)
			event4:Fire(v2, nil)
			return "P1: " .. tostring(v2)
		end
	},
	DefaultUpgradePath2 = {
		LeftButtonClick = function(p: string)
			local v2 = v:InvokeServer(p)
			event4:Fire(nil, v2)
			return "P2: " .. tostring(v2)
		end,
		RightButtonClick = function(p: string)
			local v2 = v:InvokeServer(p, true)
			event4:Fire(nil, v2)
			return "P2: " .. tostring(v2)
		end
	},
	RandomTowers = {
		LeftButtonClick = function(_: string)
			event5:Fire()
		end,
		RightButtonClick = function(_: string)
			event5:Fire(true)
		end
	},
	RandomSkins = {
		LeftButtonClick = function(p: string)
			v:InvokeServer(p)
			event6:Fire()
		end,
		RightButtonClick = function(p: string)
			v:InvokeServer(p, true)
			event6:Fire()
		end
	},
	ResetAbilities = {
		LeftButtonClick = function(p: string)
			v:InvokeServer(p)
			event7:Fire()
		end,
		RightButtonClick = function(p: string)
			v:InvokeServer(p, true)
			event7:Fire()
		end
	},
	ToggleOscillation = {
		LeftButtonClick = function(_: string)
			local module = require(characterClass)
			module.ToggleOscillation()
		end
	},
	ToggleTurretAiming = {
		LeftButtonClick = function(_: string)
			local module = require(characterClass)
			module.ToggleTurretAiming()
		end
	},
	TowerUpgradeShop = {
		LeftButtonClick = function(_: string)
			local module = require(userInterfaceHandler)
			module.ToggleTowerUpgradeShop()
		end
	}
}
local v3 = nil
local v4 = false
local AdminButtonHandler = {
	SetEnabled = function(flag: boolean)
		v4 = flag
	end
}

local function CanPress(name: string) -- 2 equivalent calls inferred from this helper
	return not not v4 and not (LocalPlayer:GetAttribute("Spectator") and not SPECTATOR_ADMIN_BUTTONS[name])
end

local v5 = {}
local v6 = {}

for _, button in pairs(bottomLeftButtons:GetChildren()) do
	if not button:IsA("ImageButton") then
		continue
	end

	local name = button.Name
	local v7 = v2[name]
	local textLabel5 = button:WaitForChild("TextLabel")
	local background = button:WaitForChild("Background")

	v5[name] = function()
		if not CanPress(name) then -- inferred equivalent call
			return
		end

		local text = nil

		if v7 then
			if v7.LeftButtonClick then
				text = v7.LeftButtonClick(name)
			else
				warn("No custom behavior for left click")
			end
		else
			text = v:InvokeServer(name)
		end

		if text then
			textLabel5.Text = text
		end
	end

	v6[name] = function()
		if not CanPress(name) then -- inferred equivalent call
			return
		end

		local text = nil

		if v7 then
			if v7.RightButtonClick then
				text = v7.RightButtonClick(name)
			else
				warn("No custom behavior for right click")
			end
		else
			text = v:InvokeServer(name, true)
		end

		if text then
			textLabel5.Text = text
		end
	end

	button.MouseEnter:Connect(function()
		background.BackgroundColor3 = color2
	end)
	button.MouseLeave:Connect(function()
		background.BackgroundColor3 = color
	end)
	button.MouseButton1Click:Connect(v5[name])
	button.MouseButton2Click:Connect(v6[name])
end

event2:AttachCallback(function(p: number)
	v3 = p

	if v3 == 0 then
		textLabel2.Text = "RESUME"
		textLabel3.Text = "RESUME"
	else
		textLabel2.Text = "PAUSE"
		textLabel3.Text = "PAUSE"
	end

	textLabel.Text = "SPEED: " .. tostring(math.round(100 * v3) / 100)
end)
event3:AttachCallback(function(value: string)
	textLabel4.Text = string.upper(value)
end)
event8:AttachCallback(function(p: string, flag: boolean?)
	if flag then
		local v7 = v6[p]

		if v7 then
			v7()
		else
			warn("No right click callback for button " .. p)
		end
	else
		local v7 = v5[p]

		if v7 then
			v7()
		else
			warn("No left click callback for button " .. p)
		end
	end
end)
return AdminButtonHandler