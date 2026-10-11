local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Fireball",
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 8,
		Damage = 12000,
		DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance
	},
	StartingCooldown = 3,
	Cooldown = 9,
	Animated = true,
	Delay = 0.95,
	ExecutionTime = 2.8,
	FaceTarget = true,
	AnimationName = "Fireball",
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Fireball" },
	PathEntityToEnemyRangedData = {
		CanTargetAir = false,
		ProjectileName = Enums.Projectiles.OverseerFireball,
		QueryType = "First",
		Range = 125,
		MinimumRange = 12
	}
}