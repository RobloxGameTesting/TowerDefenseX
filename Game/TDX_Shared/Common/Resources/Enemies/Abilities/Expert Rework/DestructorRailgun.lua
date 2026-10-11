local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1.5,
		Damage = 500,
		DamagePercentage = 0.15
	},
	StartingCooldown = 6,
	Cooldown = 24,
	Animated = true,
	AnimationName = "Railgun",
	SecondaryAnimationForKeyframeEventsName = "RailgunDamaged",
	Delay = 2.133,
	ExecutionTime = 4.2669999999999995,
	BurstSize = 4,
	BurstInterval = 1,
	CustomBurstDelayMap = { 0, 0.2669999999999999, 0 },
	BurstTargetEntityUntilNotAlive = true,
	EffectParentInstanceNames = { "Railgun" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.DestructorRailgunShot,
			Range = 35,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = false,
			TargetMostExpensiveTower = true
		}
	}
}