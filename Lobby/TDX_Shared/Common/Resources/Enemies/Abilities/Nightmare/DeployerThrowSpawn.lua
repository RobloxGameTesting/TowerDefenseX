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
				EnemyType = Enums.Enemies.SpawnDeployerSpawner,
				Count = 1,
				MaxSpawnOffsetStuds = 0,
				TransferStealth = true,
				NoCash = true
			}
		}
	},
	StartingCooldown = 8,
	StartingCooldownVariance = 3,
	Cooldown = 999,
	Animated = true,
	Delay = 0.933,
	ExecutionTime = 1.567,
	AnimationName = "Deploy",
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "HumanoidRootPart>Deploy" },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.DeployerObjectSpawn,
			MinimumRange = 1.5,
			Range = 2.5,
			TargetPath = true
		}
	}
}