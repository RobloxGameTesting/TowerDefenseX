local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SuperEncore",
	DisplayName = "Super Encore",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 40,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://15508070504",
	Description = "Firerate boost for nearby towers.",
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	TowerBuffNames = { Enums.TowerBuffs.SuperEncoreBuff },
	EffectParentInstanceNames = {}
}