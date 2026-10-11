local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 9,
	Cooldown = 75,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 1.867,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonVFX", "Torso>SummonSFX" },
	EffectsStopDelay = 2.5,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SnowWendigo,
			Count = 3,
			StaggerMaxDelay = 0.3,
			FavorSpawningBehindParent = true,
			PathPercentageLowerBound = 0.05,
			PathPercentageUpperBound = 0.4
		},
		{
			EnemyType = Enums.Enemies.WraithRider,
			Count = 3,
			StaggerMaxDelay = 0.3,
			FavorSpawningBehindParent = true,
			PathPercentageLowerBound = 0.2,
			PathPercentageUpperBound = 0.3
		},
		{
			EnemyType = Enums.Enemies.TBBoss4,
			Count = 10,
			StaggerMaxDelay = 0.3,
			FavorSpawningBehindParent = true,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.5
		}
	}
}