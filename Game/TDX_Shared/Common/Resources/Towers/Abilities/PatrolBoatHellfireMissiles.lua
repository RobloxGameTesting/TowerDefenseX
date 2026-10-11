local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2,
		Damage = 400,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "PatrolBoatHellfireMissiles",
	DisplayName = "Hellfire Missiles",
	Passive = true,
	StartingCooldown = 2.5,
	Cooldown = 2.5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Hellfire missiles.",
	ProjectileName = Enums.Projectiles.PatrolBoatRocket
}