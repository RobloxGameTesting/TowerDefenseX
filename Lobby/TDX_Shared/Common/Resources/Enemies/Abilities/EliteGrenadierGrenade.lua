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
				EnemyType = Enums.Enemies.RevivedTitan,
				Count = 1,
				MaxSpawnOffsetStuds = 6.5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.Shocker,
				Count = 1,
				MaxSpawnOffsetStuds = 6.5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.RevivedBoss1,
				Count = 2,
				MaxSpawnOffsetStuds = 6.5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 4,
	Cooldown = 43,
	Animated = true,
	Delay = 1.24,
	ExecutionTime = 1.55,
	AnimationName = "Throw",
	FaceTarget = true,
	ShownWhenBeingUsedModelNames = { "EliteGrenadierGrenade" },
	IntroSwitchDelay = 0.3,
	OutroSwitchDelay = 1.24,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.EliteGrenadierGrenade, Range = 22, TargetPath = true }
	}
}