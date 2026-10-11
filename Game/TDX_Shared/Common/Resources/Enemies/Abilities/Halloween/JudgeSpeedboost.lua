local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 8,
	Cooldown = 20,
	StartingCooldownVariance = 2,
	CooldownVariance = 3,
	Animated = true,
	AnimationName = "Ring",
	Delay = 0.567,
	ExecutionTime = 1.933,
	EffectParentInstanceNames = { "Bell" },
	EffectsStartDelay = 0,
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 25,
		EnemyBuffNames = { Enums.EnemyBuffs.JudgeSpeedboost }
	}
}