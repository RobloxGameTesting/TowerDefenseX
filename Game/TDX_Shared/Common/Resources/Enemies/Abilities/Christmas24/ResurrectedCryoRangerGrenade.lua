local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1.5,
		Damage = 35,
		BuffName = Enums.TowerBuffs.ResurrectedCryoRangerFreeze
	},
	StartingCooldown = 3,
	Cooldown = 10,
	StartingCooldownVariance = 1,
	CooldownVariance = 1,
	Animated = true,
	Delay = 0.2,
	ExecutionTime = 0.917,
	AnimationName = "Grenade",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.ResurrectedCryoRangerGrenade, Range = 13 }
	},
	EffectParentInstanceNames = {}
}