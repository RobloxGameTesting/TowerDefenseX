local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 5, Damage = 1000 },
	StartingCooldown = 30,
	Cooldown = 60,
	Animated = true,
	Delay = 0.85,
	ExecutionTime = 3,
	BurstSize = 5,
	BurstInterval = 1,
	CustomBurstDelayMap = { 0.383, 0.45, 0.334, 0.383 },
	AnimationName = "Grenade Launcher",
	FaceTarget = true,
	ForceFaceOverideTime = 0.3,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.CorruptedEradicatorMK2Grenade,
			Range = 40,
			MinimumRange = 10,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}