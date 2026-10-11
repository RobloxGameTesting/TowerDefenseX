local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 35,
	Animated = true,
	AnimationName = "GroundSlamAndSummon",
	Delay = 2.15,
	ExecutionTime = 3.8,
	EffectParentInstanceNames = { "GroundSlamAndSummon" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Summon" },
	EnemyToTowerRangedDataSequence = {
		{
			CanAffectAir = true,
			TowerBuffNames = { Enums.TowerBuffs.NightmareSlimeKingGroundSlamStun },
			Range = 9,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 50000 },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SlimeSoldier,
			Count = 100,
			HealthMultiplier = 10,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.3,
			PathPercentageUpperBound = 0.9,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.SlimeBrute,
			Count = 3,
			StaggerMaxDelay = 1,
			EvenStagger = true,
			PathPercentageLowerBound = 0.3,
			PathPercentageUpperBound = 0.6,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.SlimeSummon,
			Count = 7,
			StaggerMaxDelay = 1,
			HealthMultiplier = 2,
			EvenStagger = true,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.5,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.TBSlimeBoss,
			Count = 7,
			StaggerMaxDelay = 1,
			HealthMultiplier = 3,
			EvenStagger = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.8,
			PathPercentageEvenStagger = true
		}
	}
}