local PVPEnemyShieldRegenClass = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common.Resources.Misc.RegularPowerUps.PVPEnemyShieldRegen.Types)

function PVPEnemyShieldRegenClass.PlayVFX(_) end

return PVPEnemyShieldRegenClass