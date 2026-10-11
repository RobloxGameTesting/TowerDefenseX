local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 800,
		DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance
	},
	Name = "HelicopterMissiles",
	DisplayName = "Hellfire Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Helicopter Missiles.",
	ProjectileName = Enums.Projectiles.HelicopterMissile,
	EffectParentInstanceNames = { "MissileEffects" }
}