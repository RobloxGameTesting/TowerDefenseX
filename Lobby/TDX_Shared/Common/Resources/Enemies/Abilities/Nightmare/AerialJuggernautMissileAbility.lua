local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	CanRunInParallel = true,
	ProjectileHitData = { IsSplash = true, SplashRadius = 1.2, Damage = 500 },
	StartingCooldown = 3,
	Cooldown = 5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 4,
	BurstInterval = 0.1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.AerialJuggernautMissile,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}