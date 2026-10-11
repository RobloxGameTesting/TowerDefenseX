local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "ManualAimRetarget",
	DisplayName = "Manual Aim Retarget",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 2,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "ManualAimRetarget",
	IconIsViewport = true,
	Description = "Set new target for tower.",
	IsManualAimRetarget = true,
	EffectParentInstanceNames = { "Root" }
}