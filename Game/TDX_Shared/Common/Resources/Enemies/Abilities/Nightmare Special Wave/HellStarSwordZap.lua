local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 2,
	Cooldown = 5,
	CooldownVariance = 1,
	Delay = 0.783,
	ExecutionTime = 401 / 300,
	FaceTarget = true,
	AnimationName = "Sword Zap",
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 4000 },
			TowerBuffNames = {},
			Range = 10
		}
	},
	InstantPlayEffectParentInstanceNames = { "SwordFX" },
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Beam>Beam",
				MakeNewBeam = true,
				BeamDuration = 0.25,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}