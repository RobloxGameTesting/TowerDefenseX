local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1.5,
		Damage = 400,
		BuffName = Enums.TowerBuffs.DestructorRailgunAntiAirFirerateDebuff,
		DamagePercentage = 0.1
	},
	StartingCooldown = 6,
	Cooldown = 30,
	Animated = true,
	AnimationName = "RailgunAntiAir",
	SecondaryAnimationForKeyframeEventsName = "RailgunAntiAirDamaged",
	Delay = 2.133,
	ExecutionTime = 4.2669999999999995,
	BurstSize = 4,
	BurstInterval = 1,
	CustomBurstDelayMap = { 0, 0.2669999999999999, 0 },
	BurstTargetEntityUntilNotAlive = true,
	EffectParentInstanceNames = { "RailgunAntiAir" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.DestructorRailgunShot,
			Range = 45,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = false,
			TargetMostExpensiveTower = true
		}
	}
}