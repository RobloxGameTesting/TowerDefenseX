local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Defensive,
	BuffName = Enums.TowerBuffs.PVPGlobalDamageModeBuff,
	Duration = 15,
	Cooldown = 90,
	MaxUses = 3,
	TeamExclusive = true
}