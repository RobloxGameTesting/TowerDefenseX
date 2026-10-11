local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MachineGunnerOvercharge" .. tostring(2),
	DisplayName = "Overcharge LVL " .. tostring(2),
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	TowerBuffNames = {
		Enums.TowerBuffs["MachineGunnerDamageBuff" .. tostring(2)],
		Enums.TowerBuffs["MachineGunnerRangeBuff" .. tostring(2)],
		Enums.TowerBuffs["MachineGunnerFirerateBuff" .. tostring(2)]
	},
	TowerBuffOverrideTime = 14,
	Icon = "rbxassetid://111595324352292",
	Description = "Temporarily boost damage, firerate, and range.",
	EffectParentInstanceNames = { "Character>HumanoidRootPart>Overcharge" },
	DisplayStatAdditions = {
		{ Text = `ACTIVE FOR {14} SECONDS`, ImageId = nil, ImageScale = nil }
	},
	HotbarData = { GroupName = "Overcharge", Level = 2 }
}