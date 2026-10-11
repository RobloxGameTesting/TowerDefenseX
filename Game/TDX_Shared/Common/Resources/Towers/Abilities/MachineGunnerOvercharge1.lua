local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MachineGunnerOvercharge" .. tostring(1),
	DisplayName = "Overcharge LVL " .. tostring(1),
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	TowerBuffNames = {
		Enums.TowerBuffs["MachineGunnerDamageBuff" .. tostring(1)],
		Enums.TowerBuffs["MachineGunnerRangeBuff" .. tostring(1)],
		Enums.TowerBuffs["MachineGunnerFirerateBuff" .. tostring(1)]
	},
	TowerBuffOverrideTime = 12,
	Icon = "rbxassetid://111595324352292",
	Description = "Temporarily boost damage, firerate, and range.",
	EffectParentInstanceNames = { "Character>HumanoidRootPart>Overcharge" },
	DisplayStatAdditions = {
		{ Text = `ACTIVE FOR {12} SECONDS`, ImageId = nil, ImageScale = nil }
	},
	HotbarData = { GroupName = "Overcharge", Level = 1 }
}