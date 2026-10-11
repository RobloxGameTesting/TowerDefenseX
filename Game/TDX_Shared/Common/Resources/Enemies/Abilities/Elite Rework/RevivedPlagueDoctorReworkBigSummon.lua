local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 14,
	Cooldown = 12540,
	Animated = true,
	Delay = 0.6,
	ExecutionTime = 9.567,
	AnimationName = "BigSummon",
	EffectParentInstanceNames = { "BigSummonEffectPart" },
	EffectsStartDelay = 0,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.GoldenKnight,
			Count = 10,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.Knyght,
			Count = 100,
			HealthMultiplier = 3,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
			Count = 8,
			HealthMultiplier = 4,
			ShieldMultiplier = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.TankKnyght,
			Count = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.Berserker,
			Count = 10,
			HealthMultiplier = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedSlammer,
			Count = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedJuggernaut,
			Count = 7,
			HealthMultiplier = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
			Count = 7,
			HealthMultiplier = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
			Count = 10,
			HealthMultiplier = 3,
			ShieldMultiplier = 1,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.ResurrectedRanger1,
			Count = 20,
			HealthMultiplier = 2,
			ShieldMultiplier = 2,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.Javelin,
			Count = 15,
			HealthMultiplier = 1,
			ShieldMultiplier = 3,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.GiantSkeleton,
			Count = 5,
			HealthMultiplier = 1,
			ShieldMultiplier = 4,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.Slaw,
			HealthMultiplier = 6,
			ShieldMultiplier = 0.5,
			Count = 50,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		},
		{
			EnemyType = Enums.Enemies.PlagueBird,
			Count = 12,
			PathPercentageLowerBound = 0,
			PathPercentageUpperBound = 0.5,
			StaggerMaxDelay = 8.333
		}
	}
}