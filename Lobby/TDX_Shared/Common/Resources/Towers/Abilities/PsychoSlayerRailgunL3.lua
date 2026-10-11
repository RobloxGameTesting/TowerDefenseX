local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local projectileHitData = { IsSplash = false, Damage = 800, DamageType = Enums.DamageTypes.Laser }
return {
	Name = "Railgun Attack",
	DisplayName = "Railgun Attack LVL 1 (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 2,
	Cooldown = 12,
	Animated = true,
	AnimationName = "Railguns",
	Delay = 0.55,
	ExecutionTime = 2.15,
	BurstSize = 3,
	BurstInterval = 0,
	ModelBurstSize = 2,
	CustomBurstDelayMap = { 0.19999999999999996, 0.21699999999999997 },
	ProjectileName = Enums.Projectiles.PsychoSlayerRailgunProjectile,
	ProjectileHitData = projectileHitData,
	Icon = "",
	Description = "Passive railgun attack.",
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Railguns" }
}