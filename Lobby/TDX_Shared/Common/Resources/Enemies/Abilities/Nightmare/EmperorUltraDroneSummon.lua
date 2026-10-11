local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 150,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 3.1830000000000003,
	AnimationName = "DroneSummon",
	MaxPathPercentageCanUse = 0.6,
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>DroneSummon" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.EmperorDroneHealing,
			Count = 2,
			MaxSpawnOffsetStuds = 16,
			FavorSpawningBehindParent = true,
			MinimumStudsFromEnd = 5,
			MinimumStudsFromEndVariance = 1,
			TrackParentEnemyData = {
				EndTravelDistance = 7,
				StartTravelDistance = 13,
				TravelDistanceVariance = 3
			}
		},
		{
			EnemyType = Enums.Enemies.EmperorDroneAttack,
			Count = 4,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			MinimumStudsFromEnd = 5,
			MinimumStudsFromEndVariance = 1
		},
		{
			EnemyType = Enums.Enemies.RedEradicatorMK2,
			Count = 1,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.1,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.RedEradicator,
			Count = 1,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.2,
			PathPercentageEvenStagger = true
		},
		{
			EnemyType = Enums.Enemies.RedEradicatorMK2,
			Count = 1,
			PathPercentageLowerBound = 0.3,
			PathPercentageUpperBound = 0.3,
			PathPercentageEvenStagger = true
		}
	}
}