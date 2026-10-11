local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 0.5, Damage = 85 },
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 2.3,
	BurstSize = 3,
	BurstInterval = 0,
	CustomBurstDelayMap = { 0.184, 0.15 },
	AnimationName = "Rockets",
	FaceTarget = true,
	FaceTargetOnInitialTargetOnly = true,
	ForceFaceOverideTime = 0.7,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradBRocket,
			Range = 70,
			MinimumTargetsInRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}