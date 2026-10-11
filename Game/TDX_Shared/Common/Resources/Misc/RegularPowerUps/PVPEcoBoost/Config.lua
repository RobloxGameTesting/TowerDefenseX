local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Defensive,
	BuffName = Enums.TowerBuffs.PVPEcoBoostBuff,
	Duration = 21,
	Cooldown = 150,
	MaxUses = 5,
	MinWave = 10,
	TeamExclusive = true
}