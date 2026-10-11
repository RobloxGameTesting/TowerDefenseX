local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "JohnRageMode",
	DisplayName = "Rage Mode",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 42,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://15247139168",
	FullSizeIcon = true,
	Description = "Damage boost for nearby towers.",
	HasRadiusEffect = true,
	EffectRadius = 9,
	TowerBuffNames = { Enums.TowerBuffs.JohnRageBuff },
	EffectParentInstanceNames = { "RageModeVoice" }
}