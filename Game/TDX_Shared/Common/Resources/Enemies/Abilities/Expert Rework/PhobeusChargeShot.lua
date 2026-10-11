local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 500,
		BuffName = Enums.TowerBuffs.PhobeusChargeShotBurn,
		DamagePercentage = 0.4
	},
	StartingCooldown = 6,
	Cooldown = 30,
	Animated = true,
	AnimationName = "ChargeShot",
	Delay = 1.35,
	ExecutionTime = 3.133,
	BurstSize = 2,
	BurstInterval = 0.05,
	BurstTargetEntityUntilNotAlive = true,
	InstantPlayEffectParentInstanceNames = { "ChargeShot>SFX" },
	EffectParentInstanceNames = { "ChargeShot>VFX1", "ChargeShot>VFX2" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 0.6,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.PhobeusChargeBall,
			Range = 25,
			MinimumRange = 5,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true
		}
	}
}