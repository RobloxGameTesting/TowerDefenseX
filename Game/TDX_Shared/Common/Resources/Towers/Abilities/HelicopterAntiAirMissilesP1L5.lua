local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 6000,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "HelicopterAntiAirMissiles",
	DisplayName = "Anti-Air Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 3,
	Cooldown = 3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CustomQueryData = { CanTargetAir = true, IgnoreGround = true },
	Icon = "",
	Description = "Helicopter Anti-Air Missiles.",
	ProjectileName = Enums.Projectiles.HelicopterAntiAirMissile,
	EffectParentInstanceNames = { "AntiAirMissileEffects" }
}