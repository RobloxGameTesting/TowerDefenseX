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
				EnemyType = Enums.Enemies.MiniSkibids,
				Count = 12,
				MaxSpawnOffsetStuds = 3,
				FavorSpawningBehindParent = false,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 1,
	Cooldown = 20,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.ToiletGrenadierGrenade, Range = 13, TargetPath = true }
	}
}