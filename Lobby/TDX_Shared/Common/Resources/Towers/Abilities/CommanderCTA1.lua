local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CallToArms",
	DisplayName = "Call To Arms LVL 1",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 45,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.8,
	Icon = "rbxassetid://18462088687",
	FullSizeIcon = true,
	Description = "Damage buff.",
	AnimationName = "CTA",
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	EnableTowerAttackDuration = 10,
	TowerBuffNames = { Enums.TowerBuffs.CommanderCTA1 },
	EffectParentInstanceNames = { "CTA_VFX", "CTA" },
	HotbarData = { Level = 1 }
}