local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		Damage = 18000,
		DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance
	},
	StartingCooldown = 5,
	Cooldown = 9,
	CooldownVariance = 2,
	Animated = true,
	Delay = 0.517,
	ExecutionTime = 1.333,
	BurstSize = 2,
	BurstInterval = 0.31599999999999995,
	BurstTargetEntityUntilNotAlive = true,
	BurstNoRetargetIfTargetNotAlive = true,
	AnimationName = "Railgun",
	FaceTarget = true,
	ForceFaceOverideTimeInitial = 0.25,
	PathEntityToEnemyRangedData = {
		ProjectileName = Enums.Projectiles.WarMachineRailgunProjectile,
		QueryType = "Strongest",
		Range = 100,
		MinimumRange = 12
	},
	EffectParentInstanceNames = { "Railgun" }
}