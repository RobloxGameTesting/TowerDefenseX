local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "JuggernautOvercharge",
	DisplayName = "Overcharge",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 21,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	HealAmount = 2000,
	MainAttackOverrideData = { Damage = 100, Range = 24 },
	MainAttackOverrideDataDuration = 7,
	Icon = "rbxassetid://119657829603508",
	Description = "Heal and overcharge main attack.",
	EffectParentInstanceNames = { "Ability" }
}