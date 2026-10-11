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
				EnemyType = Enums.Enemies.HeavyZombiePlus,
				Count = 2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.ZombiePlus,
				Count = 1,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.FastZombiePlus,
				Count = 2,
				MaxSpawnOffsetStuds = 3.6,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 1,
	Cooldown = 14,
	Animated = true,
	Delay = 1.01,
	ExecutionTime = 1.25,
	AnimationName = "Throw",
	FaceTarget = true,
	ShownWhenBeingUsedModelNames = { "GrenadierGrenade" },
	IntroSwitchDelay = 0.3,
	OutroSwitchDelay = 1.01,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.GrenadierGrenade, Range = 13, TargetPath = true }
	}
}