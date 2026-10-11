local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("GlobalConstants"))
local event = BindableHandler.GetEvent("CashChanged")
local event2 = BindableHandler.GetEvent("TowerCountChanged")
local event3 = BindableHandler.GetEvent("InfoHandlerReady")
local event4 = BindableHandler.GetEvent("NoCashError")
local event5 = BindableHandler.GetEvent("TowerCountFullError")
local event6 = NetworkingHandler.GetEvent("CollectedCurrencyChanged")
local bottomBar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar")
local text = bottomBar:WaitForChild("CashFrame"):WaitForChild("Text")
local text2 = bottomBar:WaitForChild("TowerCountFrame"):WaitForChild("Text")
local eggsCurrencyFrame = bottomBar:WaitForChild("EggsCurrencyFrame")
local text3 = eggsCurrencyFrame:WaitForChild("Text")
local burgersCurrencyFrame = bottomBar:WaitForChild("BurgersCurrencyFrame")
local text4 = burgersCurrencyFrame:WaitForChild("Text")

local function EnableGradientWithName(uiGradientsByName, text5, p: string) -- 12 equivalent calls inferred from this helper
	for k, item in pairs(uiGradientsByName) do
		if k == p then
			item.Parent = text5
		else
			item.Parent = Lighting
		end
	end
end

local uiGradientsByName = {}
local uiGradientsByName2 = {}
local v = false
local flag = false
local flag2 = false

for _, uiGradient in pairs(text:GetChildren()) do
	if not uiGradient:IsA("UIGradient") then
		continue
	end

	uiGradient.Parent = Lighting
	uiGradient.Enabled = true
	uiGradientsByName[uiGradient.Name] = uiGradient
end

for _, uiGradient in pairs(text2:GetChildren()) do
	if not uiGradient:IsA("UIGradient") then
		continue
	end

	uiGradient.Parent = Lighting
	uiGradient.Enabled = true
	uiGradientsByName2[uiGradient.Name] = uiGradient
end

EnableGradientWithName(uiGradientsByName, text, "Default") -- inferred equivalent call
EnableGradientWithName(uiGradientsByName2, text2, "Default") -- inferred equivalent call
event:AttachCallback(function(p: number)
	text.Text = `${Utilities.FormatNumberWithCommas(p)}`
end)
event2:AttachCallback(function(p: number, p2: number)
	text2.Text = tostring(p) .. "/" .. tostring(p2)

	if p > 0 then
		v = true
	end
end)
event4:AttachCallback(function()
	if flag then
		return
	end

	flag = true
	EnableGradientWithName(uiGradientsByName, text, "Invalid") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName, text, "Default") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName, text, "Invalid") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName, text, "Default") -- inferred equivalent call
	flag = false
end)
event5:AttachCallback(function()
	if flag2 then
		return
	end

	flag2 = true
	EnableGradientWithName(uiGradientsByName2, text2, "Invalid") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName2, text2, "Default") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName2, text2, "Invalid") -- inferred equivalent call
	task.wait(0.25)
	EnableGradientWithName(uiGradientsByName2, text2, "Default") -- inferred equivalent call
	flag2 = false
end)
task.spawn(function()
	while task.wait(0.6) and not v do
		if flag then
			continue
		end

		EnableGradientWithName(uiGradientsByName, text, "Highlight") -- inferred equivalent call
		uiGradientsByName.Highlight.Enabled = not uiGradientsByName.Highlight.Enabled
	end

	if not flag then
		EnableGradientWithName(uiGradientsByName, text, "Default") -- inferred equivalent call
	end
end)
eggsCurrencyFrame.Visible = _G.EASTER_2026_EVENT_ENABLED
text3.Text = "+0"
burgersCurrencyFrame.Visible = _G.FOURTH_OF_JULY_2026_EVENT_ENABLED
text4.Text = "+0"
event6:AttachCallback(function(p: string, p2: number)
	if p == "Eggs" then
		text3.Text = `+{p2}`
	elseif p == "Burgers" then
		text4.Text = `+{p2}`
	end
end)
event3:Fire()
return {}