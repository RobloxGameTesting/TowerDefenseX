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
				EnemyType = Enums.Enemies.Assailant,
				Count = 2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 4,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 4,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 1.25,
	AnimationName = "ThrowAtGround",
	FaceTarget = true,
	ShownWhenBeingUsedModelNames = { "BombardierC4Ground" },
	IntroSwitchDelay = 0,
	OutroSwitchDelay = 0.5,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.BombardierC4Ground, Range = 13, TargetPath = true }
	}
}