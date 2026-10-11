local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0.75,
	Cooldown = 1,
	StartingCooldownVariance = 0.5,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Root>Heal" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 10,
		HealData = { HealAmount = 50 }
	}
}