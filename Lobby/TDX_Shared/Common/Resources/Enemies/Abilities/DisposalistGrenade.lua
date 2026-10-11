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
				EnemyType = Enums.Enemies.Contained,
				Count = 2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.LightContained,
				Count = 6,
				StaggerMaxDelay = 0.2,
				MaxSpawnOffsetStuds = 3,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.HeavyContained,
				Count = 2,
				MaxSpawnOffsetStuds = 3,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 3,
	Cooldown = 15,
	StartingCooldownVariance = 2,
	CooldownVariance = 2,
	Animated = true,
	Delay = 0.817,
	ExecutionTime = 1.8,
	AnimationName = "Shoot",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.DisposalistProjectile, Range = 14, TargetPath = true }
	}
}