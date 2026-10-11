local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ShotgunnerHealingField",
	DisplayName = "Health Pack",
	Passive = false,
	CanUseWhileStunned = true,
	StartingCooldown = 3,
	Cooldown = 8,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://17307873671",
	Description = "Heal nearby towers.",
	HasRadiusEffect = true,
	EffectRadius = 8,
	HealPercentage = 0.45,
	TowerBuffNames = { Enums.TowerBuffs.ShotgunnerHeal_VisualOnly },
	EffectParentInstanceNames = { "Root" }
}