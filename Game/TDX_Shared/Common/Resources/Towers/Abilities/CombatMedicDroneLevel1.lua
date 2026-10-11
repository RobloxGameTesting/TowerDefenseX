local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Medic Drone",
	DisplayName = "Medic Drone Level 1",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 90,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://114714722430891",
	FullSizeIcon = true,
	Description = "Call in a Medic Drone.",
	SpawnStaticEntityData = {
		{ StaticEntityType = Enums.StaticEntities.MedicDroneLevel1, KillIfTowerOriginKilled = true }
	},
	IsManualAimAtGround = true,
	ManualAimInfiniteRange = true,
	ManualAimRespectMinMaxHeight = true,
	EffectParentInstanceNames = { "DroneSFX" },
	HotbarData = { Level = 1 }
}