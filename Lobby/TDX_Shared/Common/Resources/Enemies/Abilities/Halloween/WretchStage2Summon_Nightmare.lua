local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 70,
	Animated = true,
	Delay = 0.85,
	ExecutionTime = 1.483,
	AnimationName = "Stage2Summon",
	PrerequisiteAbilityName = Enums.EnemyAbilities.WretchTransition,
	EffectParentInstanceNames = { "RootPart>SummonSFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.CorruptedGoldenJuggernautB,
			Count = 6,
			StaggerMaxDelay = 0.7,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.1
		},
		{
			EnemyType = Enums.Enemies.CorruptedGoldenJuggernautA,
			Count = 3,
			StaggerMaxDelay = 0.7,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.1
		},
		{
			EnemyType = Enums.Enemies.CursedDevourer,
			Count = 5,
			StaggerMaxDelay = 0.7,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.1
		},
		{
			EnemyType = Enums.Enemies.MazeGuardian,
			Count = 2,
			StaggerMaxDelay = 0.5,
			OverridePathIndices = { 25 },
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.05
		}
	}
}