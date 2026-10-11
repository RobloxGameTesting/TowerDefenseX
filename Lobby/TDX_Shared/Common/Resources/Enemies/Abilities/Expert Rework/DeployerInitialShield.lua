local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	MaximumUses = 1,
	GainDamageReductionData = { Amount = 0.9, Time = 8 }
}