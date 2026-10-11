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
	Delay = 3.55,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 5, Damage = 9000 },
					{ Range = 7, Damage = 1200 },
					{ Range = 10, Damage = 600 },
					{ Range = 12, Damage = 300 },
					{ Range = 14, Damage = 100 }
				}
			},
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = {}
}