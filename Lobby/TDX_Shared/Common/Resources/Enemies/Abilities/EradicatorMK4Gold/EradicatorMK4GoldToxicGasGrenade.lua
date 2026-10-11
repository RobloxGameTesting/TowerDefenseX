local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 10,
		BuffName = Enums.TowerBuffs.EradicatorMK4GoldToxicGasDebuff,
		SpawnEnemyData = {
			{
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 5,
				StaggerMaxDelay = 0.2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 5,
				StaggerMaxDelay = 0.2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.Goliath,
				Count = 1,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 10,
	Cooldown = 150,
	Animated = true,
	Delay = 2.5,
	ExecutionTime = 3.666,
	BurstSize = 2,
	BurstInterval = 0.2,
	AnimationName = "ChestGrenadesToxic",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.EradicatorMK4GrenadeGreen,
			Range = 22,
			TargetPath = true
		}
	},
	EffectParentInstanceNames = { "ChestGrenadeEffectsPart" }
}