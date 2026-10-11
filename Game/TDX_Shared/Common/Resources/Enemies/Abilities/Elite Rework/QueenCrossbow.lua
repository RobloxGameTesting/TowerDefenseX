local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 300,
		BuffName = Enums.TowerBuffs.QueenCrossbowStun
	},
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 1,
	ExecutionTime = 3.8,
	AnimationName = "Crossbow",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			NoTargetGround = false,
			ProjectileName = Enums.Projectiles.QueenCrossbowArrow,
			Range = 45,
			TargetMostExpensiveTower = true,
			TargetPathEntitiesIfNoTowers = true
		}
	}
}