local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Snow Storm",
	DisplayName = "Snow Storm",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 25,
	CanRunInParallel = true,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	ContinuousForTime = 15,
	ContinuousReloadTime = 0.2,
	Icon = "rbxassetid://117101754945196",
	Description = "Snow storm.",
	HasRadiusEffect = true,
	EffectRadius = 8,
	RadiusEffectIgnoreAir = true,
	RadiusDamageType = Enums.DamageTypes.Ice,
	BodyHeatReduction = 25,
	EffectParentInstanceNames = { "SnowStorm" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 15
}