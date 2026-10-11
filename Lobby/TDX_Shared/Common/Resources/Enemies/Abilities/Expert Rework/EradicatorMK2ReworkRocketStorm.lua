local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		Damage = 425,
		DamagePercentage = 0.05
	},
	StartingCooldown = 15,
	Cooldown = 70,
	Animated = true,
	AnimationName = "RocketStorm",
	Delay = 1.533,
	ExecutionTime = 3.5999999999999996,
	FaceTarget = false,
	InstantPlayEffectParentInstanceNames = { "RocketStorm>SFX" },
	EffectParentInstanceNames = {},
	BurstSize = 22,
	BurstInterval = 0.04622727272727272,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			NoTargetGround = false,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkRocket,
			Range = 70,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}