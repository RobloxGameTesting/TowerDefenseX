local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2,
		Damage = 50,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "ScoutHelicopterRockets",
	DisplayName = "Rocket Pods (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 4.5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Scout Helicopter Rockets",
	ProjectileName = Enums.Projectiles.ScoutHelicopterRocket,
	EffectParentInstanceNames = { "RocketEffects" }
}