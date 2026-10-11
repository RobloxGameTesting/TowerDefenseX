local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 1,
	Damage = 1,
	BuffName = Enums.TowerBuffs.SlimeBruteProjectileDebuff
}
return {
	StartingCooldown = 5,
	StartingCooldownVariance = 1,
	Cooldown = 15,
	CooldownVariance = 3,
	Animated = true,
	Delay = 1.35,
	ExecutionTime = 3.333333333333333,
	AnimationName = "Ball Throw",
	FaceTarget = true,
	EffectParentInstanceNames = { "Root>Ability" },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.SlimeGolemBall,
			CanTargetAir = false,
			Range = 15,
			MinimumRange = 4,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	ProjectileHitData = projectileHitData
}