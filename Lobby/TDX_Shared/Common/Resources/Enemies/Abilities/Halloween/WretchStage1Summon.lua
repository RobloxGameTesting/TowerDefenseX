local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 50,
	Animated = true,
	Delay = 1.1,
	ExecutionTime = 1.717,
	AnimationName = "Stage1Summon",
	EffectParentInstanceNames = { "RootPart>SummonSFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VileSeraph,
			Count = 7,
			StaggerMaxDelay = 0.9,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.12
		},
		{
			EnemyType = Enums.Enemies.MazeGuardian,
			Count = 1,
			StaggerMaxDelay = 0.5,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.05
		}
	}
}