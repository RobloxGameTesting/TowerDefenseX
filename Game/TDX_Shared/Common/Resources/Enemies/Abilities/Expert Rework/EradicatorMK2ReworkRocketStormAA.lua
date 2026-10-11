local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		Damage = 250,
		DamagePercentage = 0.15
	},
	StartingCooldown = 25,
	Cooldown = 85,
	Animated = true,
	AnimationName = "RocketStormAA",
	Delay = 1.517,
	ExecutionTime = 4.967,
	FaceTarget = false,
	InstantPlayEffectParentInstanceNames = { "RocketStormAA>SFX" },
	EffectParentInstanceNames = {},
	BurstSize = 22,
	BurstInterval = 0.07572727272727273,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkRocket,
			Range = 70,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}