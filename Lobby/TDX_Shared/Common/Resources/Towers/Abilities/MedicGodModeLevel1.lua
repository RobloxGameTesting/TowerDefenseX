local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MedicGodModeLevel1",
	DisplayName = "UBER LVL 1",
	Passive = false,
	StartingCooldown = 10,
	Cooldown = 30,
	CooldownPausedWhileActive = true,
	Animated = true,
	Delay = 0,
	ExecutionTime = 12,
	BlockUpgradesWhileActive = true,
	Icon = "rbxassetid://17684187238",
	Description = "God mode.",
	AnimationName = "Uber",
	CancelAnimationWhenAbilityDone = true,
	TargetSelf = true,
	TowerBuffNames = { Enums.TowerBuffs.MedicGodModeLevel1 },
	IsManualAimAtTower = true,
	ManualAimTargetMustBeHealable = true,
	StopIfManualAimTowerDead = true,
	StopIfManualAimTowerMoved = true,
	BeamEffectHandlingData = {
		{
			BeamParentInstancePath = { "UberGun", "Main" },
			OscillationXZ = 0.2,
			OscillationXZPeriod = 2,
			OscillationY = 0.12,
			OscillationYPeriod = 1.25
		}
	},
	HotbarData = { GroupName = "Uber", Level = 1 }
}