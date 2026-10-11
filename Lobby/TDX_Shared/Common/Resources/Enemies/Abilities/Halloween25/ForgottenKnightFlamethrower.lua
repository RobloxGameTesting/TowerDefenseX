local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 1,
	Animated = true,
	Delay = 2,
	ExecutionTime = 7.217,
	MaximumUses = 0,
	AnimationName = "Flamethrower",
	FaceTarget = true,
	ForceFaceOverideTime = 0.5,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.ForgottenKnightFlamethrowerBurn,
				Enums.TowerBuffs.ForgottenKnightFlamethrowerFirerateDebuff
			},
			Range = 120,
			MinimumRange = 5,
			ArcSpreadAngle = 90,
			MinimumTargetsInRange = 1,
			CanTargetAir = true,
			EradicatorFlamethrowerData = {
				StartTime = 2,
				StopTime = 6.4,
				ArcTiming = {
					{ Time = 2, Angle = 15 },
					{ Time = 2.75, Angle = 15 },
					{ Time = 3, Angle = 0 },
					{ Time = 4, Angle = -90 },
					{ Time = 4.85, Angle = -180 },
					{ Time = 5.633, Angle = -270 },
					{ Time = 6.4, Angle = -330 }
				},
				BufferAngle = 25,
				AdditionalRangeForHit = 10
			}
		}
	},
	EffectParentInstanceNames = { "Flamethrower" },
	EffectsStartDelay = 0,
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Flamethrower" }
}