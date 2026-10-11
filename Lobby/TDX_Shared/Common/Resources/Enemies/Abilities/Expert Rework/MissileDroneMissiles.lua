local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 150 },
	StartingCooldown = 4,
	StartingCooldownVariance = 1,
	Cooldown = 15,
	CooldownVariance = 3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	BurstSize = 16,
	BurstInterval = 0.1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.MissileDroneMissile,
			Range = 40,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}