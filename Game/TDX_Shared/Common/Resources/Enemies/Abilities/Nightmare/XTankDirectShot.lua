local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.5, Damage = 3000 },
	StartingCooldown = 3,
	Cooldown = 10,
	Animated = true,
	AnimationName = "Shoot",
	Delay = 29 / 30,
	ExecutionTime = 2.4,
	FaceTurretToTarget = true,
	TurretIndex = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.XTankDirectProjectile,
			Range = 20,
			MinimumRange = 5,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}