local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 45,
	Animated = true,
	Delay = 3.033,
	ExecutionTime = 5.582999999999999,
	AutoHandleEffects = true,
	AnimationName = "AxeSlam",
	EnemyToTowerRangedDataSequence = {
		{
			MinimumTargetsInRange = 3,
			DamageData = { Damage = 1900 },
			Range = 80,
			HitAllTargetsInRange = true,
			TowerBuffNames = {
				Enums.TowerBuffs.VoidDevastatorAxeSlamStun,
				Enums.TowerBuffs.VoidDevastatorAxeSlamFirerateDebuff
			}
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 80,
		DamageData = { InstantKill = true }
	}
}