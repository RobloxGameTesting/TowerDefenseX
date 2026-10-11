local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, BuffName = Enums.TowerBuffs.SlimeBruteProjectileDebuff },
	StartingCooldown = 5,
	Cooldown = 5,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.SlimeBruteProjectile,
			Range = 15,
			TargetRandomTower = true
		}
	}
}