local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 6000,
				DamageFalloffRanges = {
					{ Range = 3, Damage = 5000 },
					{ Range = 5, Damage = 4000 },
					{ Range = 7, Damage = 2500 },
					{ Range = 25, Damage = 1000 }
				}
			},
			Range = 10,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "DeathExplodePart" }
}