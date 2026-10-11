local AmmoDisplayHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local FirstPersonAttackManager = require(script.Parent.Parent:WaitForChild("FirstPersonAttackManager"))
local FirstPersonUIUtilities = require(script.Parent:WaitForChild("FirstPersonUIUtilities"))
Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames")
local v = 1
local v2 = nil

function AmmoDisplayHandler.SetTower(_, _)
	v2 = FirstPersonUIUtilities.GetAmmoTextLabel()
end

function AmmoDisplayHandler.RemoveTower() end

function AmmoDisplayHandler.SwitchAttackHandler(p: number)
	v = p
end

function AmmoDisplayHandler.ShotFired() end

function AmmoDisplayHandler.OnRenderStepped(_: number, _: number)
	local attackHandlerData = FirstPersonAttackManager.GetAttackHandlerData(v)

	if attackHandlerData and v2 then
		if attackHandlerData.IsReloading then
			v2.Text = "RELOADING"
		else
			v2.Text = `{attackHandlerData.ShotsRemaining} / {attackHandlerData.MagSize}`
		end
	end
end

return AmmoDisplayHandler