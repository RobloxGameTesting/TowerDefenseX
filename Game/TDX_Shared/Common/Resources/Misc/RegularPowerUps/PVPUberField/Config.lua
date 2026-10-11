local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
return {
	IsPVP = true,
	Category = Enums.PowerUpCategories.Defensive,
	BuffName = Enums.TowerBuffs.PVPUberFieldBuff,
	Duration = 15,
	Cooldown = 80,
	Radius = 18,
	MaxUses = 3
}