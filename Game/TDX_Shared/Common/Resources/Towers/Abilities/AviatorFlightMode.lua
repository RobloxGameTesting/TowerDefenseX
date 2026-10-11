local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	Name = "AviatorFlightMode",
	DisplayName = "Switch flight pattern",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://117295911352234",
	FullSizeIcon = true,
	Description = "Switch the plane's flight pattern between a circle and a figure-8 around the platform",
	ToggleAviatorFlightMode = true
}