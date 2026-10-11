local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	AnimationName = "Summon",
	Delay = 0.4,
	ExecutionTime = 1.1800000000000002,
	EffectParentInstanceNames = { "Root>SummonVFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.ResurrectedRailgunner,
			Count = 3,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
			Count = 14,
			HealthMultiplier = 4,
			ShieldMultiplier = 1,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedSlammer,
			Count = 1,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
			Count = 5,
			HealthMultiplier = 4,
			ShieldMultiplier = 2,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}