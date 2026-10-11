local PVPEnemySpeedBoostClass = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common.Resources.Misc.RegularPowerUps.PVPEnemySpeedBoost.Types)

function PVPEnemySpeedBoostClass.PlayVFX(_) end

return PVPEnemySpeedBoostClass