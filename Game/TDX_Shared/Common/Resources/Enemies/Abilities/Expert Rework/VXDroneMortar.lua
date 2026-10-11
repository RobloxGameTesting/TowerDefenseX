local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 6, Damage = 800, DamagePercentage = 0.2 },
	StartingCooldown = 6,
	Cooldown = 20,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.4669999999999996,
	AnimationName = "Mortar",
	EffectParentInstanceNames = { "Mortar" },
	FaceTarget = true,
	ForceFaceOverideTime = 0.75,
	ForceFaceOverideTimeInitial = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.VXDroneMortar,
			Range = 40,
			MinimumRange = 15,
			ConsiderTargetsWithNoAttack = true,
			TargetMostExpensiveTower = true
		}
	}
}