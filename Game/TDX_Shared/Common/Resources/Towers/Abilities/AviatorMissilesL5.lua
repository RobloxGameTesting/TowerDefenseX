local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 750,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "AviatorMissiles",
	DisplayName = "Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 1.25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	CustomQueryData = { Range = 30, QueryType = "Strongest", QueryAtTowerPosition = true },
	Icon = "",
	Description = "Aviator Missiles.",
	ProjectileName = Enums.Projectiles.AviatorMissile,
	EffectParentInstanceNames = { "MissileEffects" }
}