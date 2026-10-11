local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Root>Heal" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 10,
		BossOrMiniBossOnly = true,
		MinimumTargetPrerequisites = { BossOrMiniBossOnly = true },
		HealData = { HealAmount = 300 }
	},
	AffectedEntityEffectData = { EffectName = Enums.VisualEffects.GearsVFX }
}