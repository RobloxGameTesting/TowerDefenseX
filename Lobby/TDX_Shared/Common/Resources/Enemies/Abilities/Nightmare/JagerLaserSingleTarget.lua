local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 12,
	Cooldown = 35,
	Animated = true,
	Delay = 0.833,
	ExecutionTime = 5.467,
	AnimationName = "LaserSingleTarget",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.JagerSingleTargetLaserDamage },
			Range = 18,
			MinimumRange = 2,
			TargetMostExpensiveTower = true,
			TargetMinimumValue = 60000,
			BeamEffectHandlingData = {
				{
					BeamParentInstanceName = "LaserBeams>1",
					BeamDuration = 3,
					OscillationXZ = 0.4,
					OscillationXZPeriod = 2,
					OscillationY = 0.35,
					OscillationYPeriod = 2.2
				},
				{
					BeamParentInstanceName = "LaserBeams>2",
					BeamDuration = 3,
					OscillationXZ = 0.4,
					OscillationXZPeriod = 1.5,
					OscillationY = 0.3,
					OscillationYPeriod = 1.8
				},
				{
					BeamParentInstanceName = "LaserBeams>3",
					BeamDuration = 3,
					OscillationXZ = 0.35,
					OscillationXZPeriod = 2.5,
					OscillationY = 0.15,
					OscillationYPeriod = 1.9
				},
				{
					BeamParentInstanceName = "LaserBeams>4",
					BeamDuration = 3,
					OscillationXZ = 0.4,
					OscillationXZPeriod = 1.9,
					OscillationY = 0.2,
					OscillationYPeriod = 1.4
				}
			}
		}
	},
	EffectParentInstanceNames = { "LaserSingleTargetContinuous" },
	EffectsStartDelay = 0.833,
	EffectsStopDelay = 3.833,
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>LaserSingleTarget" }
}