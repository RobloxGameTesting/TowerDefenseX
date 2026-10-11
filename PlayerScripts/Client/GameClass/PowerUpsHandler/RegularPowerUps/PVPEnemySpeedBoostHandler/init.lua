local PVPEnemySpeedBoostHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local PVPEnemySpeedBoostClass = require(script:WaitForChild("PVPEnemySpeedBoostClass"))
require(common.Resources.Misc.RegularPowerUps.PVPEnemySpeedBoost.Types)
local event = NetworkingHandler.GetEvent("PVPEnemySpeedBoostInitReplication")

function PVPEnemySpeedBoostHandler.Run(_: number) end

function PVPEnemySpeedBoostHandler.SetSpeedMultiplier(_: number) end

function PVPEnemySpeedBoostHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v in ipairs(list) do
			PVPEnemySpeedBoostClass.PlayVFX(v)
		end
	end)
end

return PVPEnemySpeedBoostHandler