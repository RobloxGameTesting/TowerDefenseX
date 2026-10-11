local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Defensive,
	BuffName = Enums.TowerBuffs.PVPRangeBoostBuff,
	Duration = 30,
	Cooldown = 70,
	MaxUses = 9,
	TeamExclusive = true
}