local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 1000 },
	StartingCooldown = 20,
	Cooldown = 120,
	Animated = true,
	Delay = 2.067,
	ExecutionTime = 4,
	BurstSize = 4,
	BurstInterval = 0,
	CustomBurstDelayMap = { 0.383, 0.2669999999999999, 0.18299999999999983 },
	AnimationName = "MissileBurst",
	EnemyToMapEntityRangedData = {
		ProjectileName = Enums.Projectiles.ApexPredatorMissile,
		Range = 150,
		MinimumRange = 60
	},
	EffectParentInstanceNames = {}
}