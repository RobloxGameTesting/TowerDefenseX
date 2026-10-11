local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	AnimationName = "Speedboost",
	Delay = 1.45,
	ExecutionTime = 2.8,
	EffectParentInstanceNames = { "Book>BookMain>SpeedboostSFX", "Book>BookMain>SpeedboostVFX" },
	EffectsStartDelay = 1.433,
	EffectsStopDelay = 1.8,
	EnemyToEnemyRadiusEffectData = {
		EnemyBuffNames = { Enums.EnemyBuffs.HereticSpeedboost }
	}
}