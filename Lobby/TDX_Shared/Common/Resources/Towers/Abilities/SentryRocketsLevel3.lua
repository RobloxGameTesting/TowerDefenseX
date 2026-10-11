local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		Damage = 170,
		DamageType = Enums.DamageTypes.Explosive
	},
	Name = "SentryRockets",
	DisplayName = "Rockets LVL 3 (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 1.1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Sentry Rockets",
	ProjectileName = Enums.Projectiles.SentryRocket,
	EffectParentInstanceNames = { "RocketEffects" }
}