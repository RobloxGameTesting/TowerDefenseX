local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1,
		Damage = 12000,
		DamagePercentage = 0.25
	},
	StartingCooldown = 2.5,
	Cooldown = 30,
	Animated = true,
	AnimationName = "CruiseMissile",
	Delay = 1.833,
	ExecutionTime = 3.2329999999999997,
	FaceTarget = true,
	InstantPlayEffectParentInstanceNames = { "CruiseMissileSingle>SFX" },
	EffectParentInstanceNames = {},
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkCruiseMissileGround,
			Range = 70,
			MinimumRange = 12,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 10000
		}
	}
}