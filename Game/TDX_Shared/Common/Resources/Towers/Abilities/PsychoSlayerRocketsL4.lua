local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 1.5,
	Damage = 325,
	DamageType = Enums.DamageTypes.Explosive
}
return {
	Name = "Rockets",
	DisplayName = "Rockets LVL 1 (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 1,
	Cooldown = 16,
	Animated = true,
	AnimationName = "Rockets",
	Delay = 0.533,
	ExecutionTime = 1.95,
	BurstSize = 6,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		0.06699999999999995,
		0.08300000000000007,
		0.11699999999999999,
		0.06699999999999995,
		0.08299999999999996
	},
	ProjectileName = Enums.Projectiles.PsychoSlayerRocket,
	ProjectileHitData = projectileHitData,
	CustomQueryData = { Range = 30, MinimumRange = 6, CanTargetAir = true },
	Icon = "",
	Description = "Passive rocket burst.",
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Rockets" }
}