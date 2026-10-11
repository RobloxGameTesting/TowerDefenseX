local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 3000 },
	StartingCooldown = 25,
	Cooldown = 100,
	Animated = true,
	Delay = 0.85,
	ExecutionTime = 3.4170000000000003,
	BurstSize = 3,
	BurstInterval = 0.85,
	AnimationName = "LaserShot",
	FaceTarget = true,
	EnemyToMapEntityRangedData = {
		ProjectileName = Enums.Projectiles.BigLaserProjectile,
		Range = 80,
		MinimumRange = 20
	},
	EffectParentInstanceNames = {}
}