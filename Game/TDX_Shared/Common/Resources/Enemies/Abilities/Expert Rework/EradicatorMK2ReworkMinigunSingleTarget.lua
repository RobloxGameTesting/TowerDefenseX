local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 45,
	Cooldown = 70,
	Animated = true,
	Delay = 2.167,
	ExecutionTime = 6.85,
	BurstSize = 35,
	BurstInterval = 0.1,
	BurstTargetEntityUntilNotAlive = true,
	BurstNoRetargetIfTargetNotAlive = true,
	AnimationName = "MinigunSingleTarget",
	FaceTarget = true,
	ForceFaceOverideTime = 0.1,
	ForceFaceOverideTimeInitial = 1.1,
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 2858 },
			Range = 25,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 50000,
			HitVisualEffectName = Enums.VisualEffects.MinigunHit,
			HitVisualEffectVarianceXZ = 0.15,
			HitVisualEffectVarianceY = 0.25
		}
	},
	InstantPlayEffectParentInstanceNames = { "MinigunSingleTarget>SFX" },
	EffectParentInstanceNames = {
		"MinigunSingleTarget>LeftLowerMachineGun",
		"MinigunSingleTarget>LeftUpperMachineGun",
		"MinigunSingleTarget>RightLowerMachineGun",
		"MinigunSingleTarget>RightUpperMachineGun"
	}
}