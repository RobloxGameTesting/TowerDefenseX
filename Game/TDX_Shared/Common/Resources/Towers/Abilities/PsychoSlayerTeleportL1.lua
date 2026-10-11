local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "Teleport",
	DisplayName = "Teleport LVL 1",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0.5,
	IsManualRelocation = true,
	ManualAimCustomRange = 100,
	Icon = "rbxassetid://136262300888560",
	Description = "Teleport to new location."
}