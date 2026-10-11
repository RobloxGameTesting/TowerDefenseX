local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "HelicopterStealthReveal",
	DisplayName = "Passive Stealth Reveal",
	Passive = true,
	StartingCooldown = 1,
	Cooldown = 0.5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	HasRevealEffect = true,
	RevealTime = 1,
	Icon = "",
	Description = "Passive stealth reveal."
}