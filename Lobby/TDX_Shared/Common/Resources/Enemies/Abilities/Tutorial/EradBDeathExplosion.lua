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
	Delay = 1.03,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 10, Damage = 2000 },
					{ Range = 15, Damage = 1800 },
					{ Range = 20, Damage = 1300 },
					{ Range = 22, Damage = 1000 },
					{ Range = 25, Damage = 500 },
					{ Range = 40, Damage = 100 }
				}
			},
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = {}
}