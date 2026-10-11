local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		SpawnEnemyData = {
			{
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.Brute,
				Count = 1,
				MaxSpawnOffsetStuds = 5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 3,
				StaggerMaxDelay = 0.2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 3,
	Cooldown = 20,
	StartingCooldownVariance = 2,
	CooldownVariance = 2,
	Animated = true,
	Delay = 1.25,
	ExecutionTime = 2.8329999999999997,
	BurstSize = 2,
	BurstInterval = 0.567,
	AnimationName = "Shoot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.SpecterProjectile, Range = 22, TargetPath = true }
	}
}