local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 300,
		DamagePercentage = 0.1
	},
	StartingCooldown = 6,
	Cooldown = 22,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.8,
	BurstSize = 10,
	BurstInterval = 1 / 9,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "AntiAirAttack",
	EffectParentInstanceNames = { "AntiAirAttack" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.ArtemisPlasmaBall,
			Range = 35,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true
		}
	}
}