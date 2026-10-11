local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 475 },
	StartingCooldown = 10,
	Cooldown = 10,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 4,
	BurstInterval = 0.25,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.EradidogMissile,
			Range = 40,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}