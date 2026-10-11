local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	CanRunInParallel = true,
	Delay = 3.033,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 3, Damage = 100000 },
					{ Range = 6.7, Damage = 1000 },
					{ Range = 15, Damage = 500 },
					{ Range = 18, Damage = 300 },
					{ Range = 22, Damage = 175 }
				}
			},
			Range = 22,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = {}
}