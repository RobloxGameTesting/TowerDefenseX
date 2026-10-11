local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 200, DamagePercentage = 0.3 },
	StartingCooldown = 10,
	Cooldown = 15,
	Animated = true,
	Delay = 0.1,
	ExecutionTime = 0.9670000000000001,
	AnimationName = "Fireball",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.HereticFireball,
			Range = 50,
			TargetMostExpensiveTower = true,
			HitVisualEffectVarianceXZ = 0.5,
			HitVisualEffectVarianceY = 0.25
		}
	},
	EffectParentInstanceNames = {}
}