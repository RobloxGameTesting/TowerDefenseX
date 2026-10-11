local PVPEnemyShieldRegenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local PVPEnemyShieldRegenClass = require(script:WaitForChild("PVPEnemyShieldRegenClass"))
require(common.Resources.Misc.RegularPowerUps.PVPEnemyShieldRegen.Types)
local event = NetworkingHandler.GetEvent("PVPEnemyShieldRegenInitReplication")

function PVPEnemyShieldRegenHandler.Run(_: number) end

function PVPEnemyShieldRegenHandler.SetSpeedMultiplier(_: number) end

function PVPEnemyShieldRegenHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v in ipairs(list) do
			PVPEnemyShieldRegenClass.PlayVFX(v)
		end
	end)
end

return PVPEnemyShieldRegenHandler