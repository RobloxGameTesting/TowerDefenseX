local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2000000,
	Speed = 2,
	BodyHeat = 60000,
	BodyHeatRegenerationRate = 1000,
	HasCustomCode = true,
	Radius = 1,
	AnimationCalibratedSpeed = 2.7,
	IsBoss = true,
	IgnoreAdditionalSpeedMultiplier = true,
	AbilityNames = {
		Enums.EnemyAbilities.UmbrixCrystalCopy,
		Enums.EnemyAbilities.UmbrixCrystalBeam,
		Enums.EnemyAbilities.UmbrixCrystalConversion,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave1,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave2,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave3,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave4,
		Enums.EnemyAbilities.UmbrixCrystalConversion_Wave5
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 1.2,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 5,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.4 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 175000, Shield = 100000 },
		[3] = { Health = 400000, Shield = 175000 },
		[4] = { Health = 450000, Shield = 220000 }
	}
}