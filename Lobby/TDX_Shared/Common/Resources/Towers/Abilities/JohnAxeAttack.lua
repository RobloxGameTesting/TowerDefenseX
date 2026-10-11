local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "JohnAxeAttack",
	DisplayName = "Axe Attack",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 13 / 60,
	ExecutionTime = 37 / 12,
	Icon = "rbxassetid://15247049633",
	Description = "Damage enemies in a circle.",
	AnimationName = "AxeAttack",
	HasRadiusEffect = true,
	EffectRadius = 5,
	RadiusDamage = 2500,
	RadiusDamageType = Enums.DamageTypes.Melee,
	RadiusDamageMaximumTargets = 8,
	EffectParentInstanceNames = { "AxeAttachmentHelper", "AxeVFX" }
}