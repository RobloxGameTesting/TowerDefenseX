local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 200000,
	Shield = 100000,
	InstantLossIfReachEnd = true,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 80345600,
	BodyHeatRegenerationRate = 10032540,
	Radius = 1,
	AnimationTimeScale = 1,
	NoHead = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 0.1,
	FadeOutRemoveDelay = 1,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.67 }
	},
	DeathAbilityNames = { Enums.EnemyAbilities.TrollBotDeathExplosion },
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		}
	}
}