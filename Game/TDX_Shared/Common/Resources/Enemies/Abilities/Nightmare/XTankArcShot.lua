local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 0.5, Damage = 4000 },
	StartingCooldown = 3,
	Cooldown = 20,
	Animated = true,
	AnimationName = "ArcShot",
	Delay = 1,
	ExecutionTime = 2.4,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.XTankArcProjectile,
			Range = 40,
			MinimumRange = 15,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}