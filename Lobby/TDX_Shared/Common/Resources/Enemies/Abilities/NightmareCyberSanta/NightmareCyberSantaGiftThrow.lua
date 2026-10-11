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
				EnemyType = Enums.Enemies.GiftBox,
				Count = 3,
				MaxSpawnOffsetStuds = 6.5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			},
			{
				EnemyType = Enums.Enemies.Wendigo,
				Count = 2,
				MaxSpawnOffsetStuds = 6.5,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 3,
	Cooldown = 25,
	Animated = true,
	Delay = 67 / 60,
	ExecutionTime = 2,
	AnimationName = "Gift Throw",
	FaceTarget = true,
	ShownWhenBeingUsedModelNames = { "NightmareCyberSantaGift" },
	IntroSwitchDelay = 19 / 60,
	OutroSwitchDelay = 67 / 60,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.NightmareCyberSantaGift,
			Range = 40,
			TargetPath = true
		}
	}
}