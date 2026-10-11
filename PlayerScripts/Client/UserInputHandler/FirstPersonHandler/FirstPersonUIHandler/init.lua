local FirstPersonUIHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local CrosshairHandler = require(script:WaitForChild("CrosshairHandler"))
local AmmoDisplayHandler = require(script:WaitForChild("AmmoDisplayHandler"))
local FirstPersonUIUtilities = require(script:WaitForChild("FirstPersonUIUtilities"))
local Handlers = script:WaitForChild("Handlers")
local Modules = script:WaitForChild("Modules")
local firstPersonScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen")
local frames = firstPersonScreen:WaitForChild("Frames")
local v = false
local torso = nil
local v2 = nil
local v3 = nil
local modulesByName = {}
local v4 = nil

function FirstPersonUIHandler.SetTower(player, p)
	v = true
	torso = player.Character:GetTorso()
	v2 = p
	FirstPersonUIUtilities.SetTower(player, p)
	CrosshairHandler.SetTower(player, p)
	AmmoDisplayHandler.SetTower(player, p)

	if v4 then
		v4.RemoveTower()
		v4 = nil
	end

	if p.UIName then
		v4 = modulesByName[p.UIName]
	end

	if v4 then
		v4.SetTower(player, p)
	end

	firstPersonScreen.Position = UDim2.new(0.5, 0, 0.5, -GuiService:GetGuiInset().Y / 2)
	firstPersonScreen.Size = UDim2.new(1, 0, 1, GuiService:GetGuiInset().Y)
	firstPersonScreen.Visible = true
	GuiService.GuiNavigationEnabled = false
end

function FirstPersonUIHandler.RemoveTower()
	v = false
	FirstPersonUIUtilities.RemoveTower()
	CrosshairHandler.RemoveTower()
	AmmoDisplayHandler.RemoveTower()

	if v4 then
		v4.RemoveTower()
		v4 = nil
	end

	firstPersonScreen.Visible = false
	GuiService.GuiNavigationEnabled = true
end

function FirstPersonUIHandler.SwitchAttackHandler(p: number)
	v3 = v2.AttackConfigs[p]

	if not v3 then
		warn("FirstPersonUIHandler.SwitchAttackHandler - Invalid attack handler index: " .. tostring(p))
	end

	CrosshairHandler.SwitchAttackHandler(p)
	AmmoDisplayHandler.SwitchAttackHandler(p)

	if v4 then
		v4.SwitchAttackHandler(p)
	end
end

function FirstPersonUIHandler.HitEnemy(p: number?)
	CrosshairHandler.HitEnemy(p)
end

function FirstPersonUIHandler.GetCrosshairPosition()
	local position = CrosshairHandler.GetPosition()
	local guiInset = GuiService:GetGuiInset()
	return Vector2.new(position.X, position.Y + guiInset.Y)
end

function FirstPersonUIHandler.GetCurrentSpreadFactor()
	return CrosshairHandler.GetCurrentSpreadFactor()
end

function FirstPersonUIHandler.ShotFired()
	CrosshairHandler.ShotFired()
	AmmoDisplayHandler.ShotFired()

	if v4 then
		v4.ShotFired()
	end
end

function FirstPersonUIHandler.Run(p: number)
	if v4 then
		v4.Run(p)
	end
end

function FirstPersonUIHandler.OnRenderStepped(p: number, p2: number)
	CrosshairHandler.OnRenderStepped(p, p2)
	AmmoDisplayHandler.OnRenderStepped(p, p2)

	if v4 then
		v4.OnRenderStepped(p, p2)
	end
end

function FirstPersonUIHandler.SetZoomIndex(p: number)
	if v4 then
		v4.SetZoomIndex(p)
	end
end

function FirstPersonUIHandler.SetSpeedMultiplier(p: number)
	CrosshairHandler.SetSpeedMultiplier(p)
end

for _, moduleScript in pairs(Handlers:GetChildren()) do
	local name = moduleScript.Name
	local module = require(moduleScript)
	modulesByName[name] = module
end

local modulesByName2 = {}

for _, moduleScript in pairs(Modules:GetChildren()) do
	local name = moduleScript.Name
	local module = require(moduleScript)
	modulesByName2[name] = module
end

for _, descendant in pairs(frames:GetDescendants()) do
	local moduleName = descendant:GetAttribute("ModuleName")

	if not moduleName then
		continue
	end

	local v5 = modulesByName2[moduleName]

	if v5 then
		local v6 = descendant
		task.spawn(function()
			v5.New(v6)
		end)
	else
		warn("Module not found: " .. tostring(moduleName))
	end
end

firstPersonScreen.Visible = false
return FirstPersonUIHandler