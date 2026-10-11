local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 700,
		DamagePercentage = 0.1
	},
	StartingCooldown = 6,
	Cooldown = 27,
	Animated = true,
	Delay = 0.917,
	ExecutionTime = 1.8830000000000002,
	BurstSize = 5,
	BurstInterval = 0.07500000000000001,
	BurstTargetEntityUntilNotAlive = true,
	AnimationName = "PlasmaBurst",
	EffectParentInstanceNames = { "PlasmaBurst" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.ArtemisPlasmaBall,
			Range = 25,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true
		}
	}
}