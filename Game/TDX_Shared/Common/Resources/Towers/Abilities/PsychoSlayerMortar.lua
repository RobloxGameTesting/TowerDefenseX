local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 4,
	Damage = 9000,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance
}
return {
	Name = "Mortar",
	DisplayName = "Mortar (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 7,
	Cooldown = 40,
	Animated = true,
	AnimationName = "Mortar",
	Delay = 0.3,
	ExecutionTime = 2,
	ProjectileName = Enums.Projectiles.PsychoSlayerMortarShell,
	ProjectileHitData = projectileHitData,
	CustomQueryData = { Range = 150, MinimumRange = 25, QueryType = "Strongest" },
	Icon = "",
	Description = "Passive mortar attack.",
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Mortar" }
}