local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		Damage = 4000,
		DamageType = Enums.DamageTypes.Explosive
	},
	StartingCooldown = 3,
	Cooldown = 10,
	Animated = true,
	Delay = 0.583,
	ExecutionTime = 1,
	BurstSize = 4,
	BurstInterval = 0.08900000000000001,
	AnimationName = "Rockets",
	FaceTarget = false,
	PathEntityToEnemyRangedData = {
		ProjectileName = Enums.Projectiles.WarMachineP2Rocket,
		QueryType = "Random",
		Range = 30,
		MinimumRange = 3
	},
	EffectParentInstanceNames = {}
}