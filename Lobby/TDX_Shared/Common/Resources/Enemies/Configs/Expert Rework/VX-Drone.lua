local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 100000,
	Shield = 50000,
	Speed = 3,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 700,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsMiniBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.VXDroneRage,
		Enums.EnemyAbilities.VXDroneLaserBeam,
		Enums.EnemyAbilities.VXDroneMortar
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.VXDroneDeathExplosion },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Shield = 3000 },
		[3] = { Shield = 9000 },
		[4] = { Shield = 30000 }
	}
}