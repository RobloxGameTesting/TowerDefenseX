local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 7,
	Cooldown = 140,
	Animated = true,
	Delay = 2,
	ExecutionTime = 5.633,
	AnimationName = "CloakSummon",
	EffectParentInstanceNames = { "CloakSummon" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>CloakSummon" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.HereticNightmare,
			Count = 1,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.2,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.RavagedPredator,
			Count = 3,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.3,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.WallPusher,
			Count = 2,
			AdditionalShieldMultiplier = 1,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.4,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.Jumper,
			Count = 12,
			AdditionalShieldMultiplier = 2,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.6,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.PapaDuck,
			Count = 5,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.7,
			ForceSpawnOnDefaultPathIndices = true
		},
		{
			EnemyType = Enums.Enemies.PsychomobSlow,
			Count = 20,
			AdditionalShieldMultiplier = 2,
			AdditionalHealthMultiplier = 1,
			StaggerMaxDelay = 3,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.7,
			ForceSpawnOnDefaultPathIndices = true
		}
	}
}