local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 500 },
	StartingCooldown = 5,
	Cooldown = 13,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 6,
	BurstInterval = 0.8,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.ToiletJohnBossRocket,
			Range = 100,
			MinimumRange = 20,
			MinimumTargetsInRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}