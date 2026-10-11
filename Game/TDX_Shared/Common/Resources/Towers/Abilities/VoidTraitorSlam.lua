local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidTraitorSlam",
	DisplayName = "Void Slam",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 16,
	Animated = true,
	Delay = 7 / 30,
	ExecutionTime = 2.6,
	AnimationName = "Slam",
	Icon = "rbxassetid://104041084852332",
	FullSizeIcon = true,
	Description = "Slam both swords into the ground, damaging nearby enemies.",
	HasRadiusEffect = true,
	EffectRadius = 10,
	RadiusEffectIgnoreAir = true,
	RadiusDamage = 12500,
	RadiusDamageType = Enums.DamageTypes.Melee,
	RadiusDamageMaximumTargets = 24,
	EffectsStartDelay = 7 / 30,
	EffectParentInstanceNames = { "SlamVFX", "RootPart>SlamSFX" }
}