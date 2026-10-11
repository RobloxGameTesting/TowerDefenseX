local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 7,
		Damage = 1750,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "WarshipTomahawkLevel2",
	DisplayName = "Tomahawk Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 4,
	Cooldown = 8,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Tomahawk Missile.",
	ProjectileName = Enums.Projectiles.WarshipTomahawk
}