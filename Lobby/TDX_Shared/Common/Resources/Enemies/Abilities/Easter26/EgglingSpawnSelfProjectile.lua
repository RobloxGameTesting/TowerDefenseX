local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { Damage = 5, IsSplash = false, BuffName = Enums.TowerBuffs.Eggling2Debuff },
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.Eggling2Projectile,
			Range = 35,
			TargetRandomTower = true,
			ConsiderTargetsWithNoAttack = true
		}
	}
}