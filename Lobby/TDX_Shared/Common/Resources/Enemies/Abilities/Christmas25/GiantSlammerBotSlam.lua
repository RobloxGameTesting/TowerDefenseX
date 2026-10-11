local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	FaceTarget = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 0,
	Delay = 23 / 30,
	ExecutionTime = 1.8169999999999997,
	AnimationName = "Slam1",
	AnimationName2 = "Slam2",
	EffectParentInstanceNames = { "SlamEffects" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = {
				Damage = 5000,
				DamageFalloffRanges = {
					{ Range = 0, Damage = 10000 },
					{ Range = 4, Damage = 2500 },
					{ Range = 8.5, Damage = 750 }
				}
			},
			TowerBuffNames = { Enums.TowerBuffs.GiantSlammerBotStun },
			TargetPathEntitiesOnly = true,
			HitAllTargetsInRange = true,
			Range = 8.5
		}
	}
}