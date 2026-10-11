local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 900 },
			{ Range = 40, Damage = 1500 },
			{ Range = 65, Damage = 3750 },
			{ Range = 125, Damage = 15000 },
			{ Range = 175, Damage = 23000 }
		},
		BuffName = Enums.TowerBuffs.ApexPredatorMissileStunDebuff,
		BuffName2 = Enums.TowerBuffs.ApexPredatorChristmas24Freeze
	},
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 2.067,
	ExecutionTime = 4,
	BurstSize = 4,
	BurstInterval = 0,
	CustomBurstDelayMap = { 0.383, 0.2669999999999999, 0.18299999999999983 },
	AnimationName = "MissileBurst",
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.ApexPredatorMissile,
			Range = 250,
			MinimumRange = 50,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}