local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4.5,
		Damage = 4000,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "GoldenWarshipHellfireMissiles",
	DisplayName = "Golden Hellfire Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 3,
	Cooldown = 1.05,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TurretIndex = 5,
	Icon = "",
	Description = "Golden Hellfire Missiles.",
	ProjectileName = Enums.Projectiles.GoldenWarshipHellfireMissile
}