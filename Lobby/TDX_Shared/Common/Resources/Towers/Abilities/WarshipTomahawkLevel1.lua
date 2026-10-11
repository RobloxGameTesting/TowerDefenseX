local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 6,
		Damage = 800,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "WarshipTomahawkLevel1",
	DisplayName = "Tomahawk Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 4,
	Cooldown = 10,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Tomahawk Missile.",
	ProjectileName = Enums.Projectiles.WarshipTomahawk
}