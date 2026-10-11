local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 17,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.HealingDrone,
			Count = 3,
			MaxSpawnOffsetStuds = 20,
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
			EnemyType = Enums.Enemies.MissileDrone,
			Count = 7,
			MaxSpawnOffsetStuds = 16,
			FavorSpawningBehindParent = true,
			MinimumStudsFromEnd = 5,
			MinimumStudsFromEndVariance = 1
		}
	}
}