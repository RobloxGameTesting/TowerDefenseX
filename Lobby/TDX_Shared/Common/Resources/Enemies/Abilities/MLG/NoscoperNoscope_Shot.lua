local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		BuffName = Enums.TowerBuffs.NoscoperNoscopeStun,
		BuffName2 = Enums.TowerBuffs.NoscoperNoscopeRangeDebuff
	},
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0.8,
	ExecutionTime = 0,
	DoNotTryToUse = true,
	FaceTarget = true,
	FaceTargetDelay = 0.2,
	ForceFaceOverideTime = 0.4,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			TargetPathIfNoTargets = true,
			TargetPathIfNoTargetsRangeVariance = 5,
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.NTW20Bullet,
			Range = 35,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}