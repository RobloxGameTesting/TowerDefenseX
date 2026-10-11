local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ScoutRecon",
	DisplayName = "Recon",
	Passive = true,
	StartingCooldown = 1,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Grants nearby towers stealth detection.",
	IsManualAimAtTower = true,
	NoFaceTargetTower = true,
	CustomQueryData = { ConsiderTargetsWithNoAttack = true },
	HasRadiusEffect = true,
	UseTowerRangeForRadius = true,
	TowerBuffNames = { Enums.TowerBuffs.ScoutStealthDetection }
}