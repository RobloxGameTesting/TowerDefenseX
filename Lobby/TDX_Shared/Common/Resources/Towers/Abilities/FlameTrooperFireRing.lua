local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Fire Ring",
	DisplayName = "Fire Ring",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 20,
	Animated = true,
	Delay = 47 / 60,
	ExecutionTime = 1.4666666666666668,
	AnimationName = "Fire Ring",
	Icon = "rbxassetid://85285174142261",
	Description = "Fire ring.",
	HasRadiusEffect = true,
	EffectRadius = 10,
	RadiusDamage = 500,
	RadiusDamageType = Enums.DamageTypes.Fire,
	ApplyBurnStats = { DamagePerSecond = 100, StickDuration = 8 },
	EffectParentInstanceNames = { "FireRing" }
}