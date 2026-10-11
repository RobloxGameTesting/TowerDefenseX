local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 7,
	Cooldown = 35,
	Animated = true,
	Delay = 1.7,
	ExecutionTime = 842 / 60,
	AnimationName = "GunSweep",
	FaceTarget = true,
	AutoHandleEffects = true,
	EffectsStartDelay = 1.7,
	EffectsStopDelay = 833 / 60,
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = {
				Enums.TowerBuffs.VoidJuggernaut1GunSweepDoT,
				Enums.TowerBuffs.VoidJuggernaut1GunSweepDamageDebuff
			},
			Range = 30,
			ArcSpreadAngle = 90,
			MinimumTargetsInRange = 3,
			EradicatorFlamethrowerData = {
				StartTime = 1.7,
				StopTime = 833 / 60,
				ArcTiming = {
					{ Time = 1.7, Angle = 68 },
					{
						Time = 131 / 60,
						Angle = 68
					},
					{ Time = 4.6, Angle = 0 },
					{ Time = 6.9, Angle = 68 },
					{
						Time = 551 / 60,
						Angle = 0
					},
					{ Time = 11.5, Angle = 68 },
					{
						Time = 833 / 60,
						Angle = 0
					}
				},
				BufferAngle = 16,
				AdditionalRangeForHit = 4
			}
		}
	}
}