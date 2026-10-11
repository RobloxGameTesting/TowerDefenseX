local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Animated = true,
	StartingCooldown = 5,
	StartingCooldownVariance = 0,
	Cooldown = 15,
	CooldownVariance = 0,
	Delay = 0.5,
	ExecutionTime = 6,
	FaceTarget = true,
	AnimationName = "Laser",
	EffectParentInstanceNames = { "Beam>SFX" },
	EnemyToTowerRangedDataSequence = {
		{
			DamageData = { Damage = 0 },
			TowerBuffNames = { Enums.TowerBuffs.TrackerLaserDebuff },
			Range = 15
		}
	},
	AffectedEntityEffectData = {
		BeamEffectHandlingData = {
			{
				BeamParentInstanceName = "Beam>Beam",
				MakeNewBeam = true,
				BeamDuration = 6,
				OscillationXZ = 0.2,
				OscillationXZPeriod = 2,
				OscillationY = 0.12,
				OscillationYPeriod = 1.25
			}
		}
	}
}