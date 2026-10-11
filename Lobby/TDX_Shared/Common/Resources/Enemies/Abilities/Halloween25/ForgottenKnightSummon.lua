local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 55,
	Animated = true,
	Delay = 1.4,
	ExecutionTime = 3.017,
	ContinueMovingWhileUsing = true,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "Summon" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Summon" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.RedSkeleton,
			Count = 15,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.7,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.TormentedSoul,
			Count = 70,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.85,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.GraveGuardian,
			Count = 2,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.15,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.CoffinHead,
			Count = 1,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.3,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.FlyingPumpkin,
			Count = 9,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.7,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.SkeletonAirbarrel,
			Count = 5,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.7,
			OverridePathIndices = { 1 }
		},
		{
			EnemyType = Enums.Enemies.GiantBat,
			Count = 7,
			StaggerMaxDelay = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			OverridePathIndices = { 1 }
		}
	}
}