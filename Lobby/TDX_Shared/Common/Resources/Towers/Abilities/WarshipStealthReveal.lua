local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "WarshipStealthReveal",
	DisplayName = "Global Stealth Reveal",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 25,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://15912941945",
	Description = "Reveal all enemies for 20 seconds.",
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	HasRevealEffect = true,
	RevealTime = 20
}