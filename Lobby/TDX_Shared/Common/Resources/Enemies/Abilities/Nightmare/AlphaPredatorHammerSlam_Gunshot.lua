local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 2.5,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 5, Damage = 100000 },
					{ Range = 8, Damage = 45000 },
					{ Range = 9, Damage = 15000 },
					{ Range = 13, Damage = 5400 },
					{ Range = 17, Damage = 4500 },
					{ Range = 20, Damage = 3000 },
					{ Range = 30, Damage = 1500 },
					{ Range = 37, Damage = 800 }
				}
			},
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		RequeryBeforeExecution = true,
		MinimumTargets = 0,
		AffectPathEntitiesOnly = true,
		MaximumRange = 40,
		DamageData = {
			Damage = 0,
			DamageFalloffRanges = {
				{ Range = 7, Damage = 200000 },
				{ Range = 11, Damage = 100000 },
				{ Range = 17, Damage = 50000 },
				{ Range = 20, Damage = 15000 },
				{ Range = 30, Damage = 9000 },
				{ Range = 40, Damage = 7000 }
			}
		}
	}
}