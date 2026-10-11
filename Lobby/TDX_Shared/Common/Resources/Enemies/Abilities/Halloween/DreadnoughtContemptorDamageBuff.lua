local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0.75,
	Cooldown = 2,
	StartingCooldownVariance = 0.5,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "RootPart>DamageBuff" },
	EnemyToEnemyRadiusEffectData = {
		MaximumRange = 16,
		NoAffectSelf = true,
		EnemyBuffNames = { Enums.EnemyBuffs.DreadnoughtContemptorBossDamageBuff }
	}
}