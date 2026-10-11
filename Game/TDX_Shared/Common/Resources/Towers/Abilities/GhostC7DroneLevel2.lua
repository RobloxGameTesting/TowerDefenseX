local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "C7 Drone",
	DisplayName = "C7 Drone (FASTER COOLDOWN)",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 50,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://18731247200",
	FullSizeIcon = true,
	Description = "Call in a C7 Drone.",
	SpawnStaticEntityData = {
		{ StaticEntityType = Enums.StaticEntities.C7Drone, KillIfTowerOriginKilled = true }
	},
	IsManualAimAtGround = true,
	ManualAimInfiniteRange = true,
	ManualAimRespectMinMaxHeight = true,
	EffectParentInstanceNames = { "DroneSFX" },
	HotbarData = { Level = 2 }
}