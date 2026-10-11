local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 2.15,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Root>Heal" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 8,
		HealData = { HealAmount = 1075 }
	},
	AffectedEntityEffectData = {
		EffectName = Enums.VisualEffects.HealPurple,
		RenderDebugPart = true
	}
}