local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 3000 },
	StartingCooldown = 3,
	Cooldown = 70,
	Animated = true,
	AnimationName = "CruiseMissileAA",
	Delay = 1.8,
	ExecutionTime = 2.867,
	FaceTarget = true,
	BurstSize = 3,
	BurstInterval = 0,
	ModelBurstSize = 3,
	InstantPlayEffectParentInstanceNames = { "CruiseMissileTriple>SFX" },
	EffectParentInstanceNames = {},
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkCruiseMissileAir,
			Range = 70,
			MinimumRange = 12,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 10000
		}
	}
}