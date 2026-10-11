local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "KritzLevel2",
	DisplayName = "KRITZ LVL 2",
	Passive = false,
	StartingCooldown = 25,
	Cooldown = 25,
	CooldownPausedWhileActive = true,
	Animated = true,
	Delay = 0,
	ExecutionTime = 14,
	BlockUpgradesWhileActive = true,
	Icon = "rbxassetid://17684187670",
	Description = "Damage/range multiplier.",
	AnimationName = "Uber",
	CancelAnimationWhenAbilityDone = true,
	TowerBuffNames = { Enums.TowerBuffs.MedicKritzLevel2Damage, Enums.TowerBuffs.MedicKritzLevel2Range },
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
	HotbarData = { GroupName = "Kritz", Level = 2 }
}