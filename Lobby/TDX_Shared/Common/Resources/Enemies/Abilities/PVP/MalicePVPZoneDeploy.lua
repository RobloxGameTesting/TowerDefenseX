local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false },
	StartingCooldown = 0,
	Cooldown = 10000,
	MaximumUses = 1,
	Animated = false,
	ExecutionTime = 0,
	CanRunInParallel = true,
	Delay = 0,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.MaliceSpeedZone,
			Range = 0,
			TargetPath = true,
			DeployStaticEntityData = {
				ObjectName = Enums.StaticEntities.MalicePVPSpeedZone,
				KillIfEnemyOriginKilled = true
			}
		}
	}
}