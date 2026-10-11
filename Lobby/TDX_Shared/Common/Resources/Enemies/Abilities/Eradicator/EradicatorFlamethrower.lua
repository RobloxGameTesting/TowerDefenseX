local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.EradicatorFlamethrowerBurn },
	Range = 18,
	ArcSpreadAngle = 100,
	EradicatorFlamethrowerData = {
		StartTime = 2.167,
		StopTime = 4.333,
		ArcTiming = {
			{ Time = 2.167, Angle = -27 },
			{ Time = 2.483, Angle = -27 },
			{ Time = 2.667, Angle = -50 },
			{ Time = 3.2, Angle = 50 },
			{ Time = 3.433, Angle = 50 },
			{ Time = 4.083, Angle = -50 },
			{ Time = 4.2, Angle = -50 },
			{ Time = 4.333, Angle = -24 }
		}
	}
}
return {
	StartingCooldown = 5,
	Cooldown = 40,
	Animated = true,
	Delay = 2.167,
	ExecutionTime = 7.183,
	AnimationName = "Flame Breath",
	EffectParentInstanceNames = { "FlameVFX" },
	FaceTarget = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.EradicatorRage,
	EnemyToTowerRangedDataSequence = { v }
}