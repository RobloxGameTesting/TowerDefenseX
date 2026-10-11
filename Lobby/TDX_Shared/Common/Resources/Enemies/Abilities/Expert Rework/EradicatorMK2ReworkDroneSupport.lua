local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 40,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 2.0330000000000004,
	AnimationName = "DroneSupport",
	InstantPlayEffectParentInstanceNames = { "DroneSupport>SFX" },
	EffectParentInstanceNames = {},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.HealingDrone,
			Count = 2,
			MaxSpawnOffsetStuds = 12,
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
			Count = 3,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningBehindParent = true,
			MinimumStudsFromEnd = 5,
			MinimumStudsFromEndVariance = 1
		}
	}
}