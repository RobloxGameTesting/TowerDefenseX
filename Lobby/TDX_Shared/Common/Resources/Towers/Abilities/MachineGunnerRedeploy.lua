local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
return {
	Name = "MachineGunnerRedeploy",
	DisplayName = "Redeploy",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = true,
	AnimationName = "Redeploy",
	Delay = 3,
	ExecutionTime = 5,
	IsManualRotation = true,
	BlockUpgradesWhileActive = true,
	Icon = "rbxassetid://94320336693441",
	Description = "Change the direction the tower is facing.",
	EffectParentInstanceNames = { "Character>HumanoidRootPart>Redeploy" }
}