local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 600 },
	StartingCooldown = 4,
	StartingCooldownVariance = 1,
	Cooldown = 10,
	CooldownVariance = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	ContinueMovingWhileUsing = true,
	BurstSize = 3,
	BurstInterval = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.EmperorDroneAttackProjectile,
			Range = 40,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}