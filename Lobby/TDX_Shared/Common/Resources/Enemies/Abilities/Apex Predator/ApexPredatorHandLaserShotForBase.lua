local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 2000 },
	StartingCooldown = 45,
	Cooldown = 100,
	Animated = true,
	Delay = 1.233,
	ExecutionTime = 1.6,
	AnimationName = "LaserHandShot",
	FaceTarget = true,
	EnemyToMapEntityRangedData = {
		ProjectileName = Enums.Projectiles.SuperBigLaserProjectile,
		Range = 55,
		MinimumRange = 15
	},
	EffectParentInstanceNames = { "LaserHandShotEffectsPart" }
}