local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TowerBuffNames = { Enums.TowerBuffs.ExoVoidSwordInfernoDebuff },
	Range = 50,
	ArcSpreadAngle = 150,
	MinimumTargetsInRange = 2,
	EradicatorFlamethrowerData = {
		StartTime = 1.05,
		StopTime = 6.5,
		ArcTiming = {
			{ Time = 1.05, Angle = 0 },
			{ Time = 2, Angle = 0 },
			{ Time = 3.15, Angle = -90 },
			{ Time = 3.85, Angle = -180 },
			{ Time = 4.5, Angle = -270 },
			{ Time = 5.5, Angle = 0 }
		},
		BufferAngle = 30
	}
}
return {
	StartingCooldown = 50,
	Cooldown = 30,
	Animated = true,
	AnimationName = "SwordInferno",
	Delay = 1.05,
	ExecutionTime = 7.583,
	FaceTarget = true,
	AutoHandleEffects = true,
	ParallelAbilityNames = {
		Enums.EnemyAbilities.ExoVoidSwordInferno_InitialSlam,
		Enums.EnemyAbilities.ExoVoidSwordInferno_Heal
	},
	EnemyToTowerRangedDataSequence = { v }
}