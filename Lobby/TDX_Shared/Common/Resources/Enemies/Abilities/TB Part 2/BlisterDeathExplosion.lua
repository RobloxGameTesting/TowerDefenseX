local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 1500,
				DamageFalloffRanges = {
					{ Range = 4, Damage = 1500 },
					{ Range = 8, Damage = 1000 },
					{ Range = 16, Damage = 700 }
				}
			},
			TowerBuffNames = { Enums.TowerBuffs.BlisterDeathFirerateDebuff },
			Range = 16,
			HitAllTargetsInRange = true
		}
	}
}