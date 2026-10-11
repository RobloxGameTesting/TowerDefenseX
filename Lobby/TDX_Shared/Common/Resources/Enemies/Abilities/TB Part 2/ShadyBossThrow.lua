local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 400,
		BuffName = Enums.TowerBuffs.ShadyBossThrowStun
	},
	StartingCooldown = 1,
	Cooldown = 12,
	CooldownVariance = 5,
	Animated = true,
	AnimationName = "Throw",
	FaceTarget = true,
	Delay = 8 / 15,
	ExecutionTime = 0.8,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.ShadyBossKnife,
			Range = 40,
			MinimumRange = 8
		}
	}
}