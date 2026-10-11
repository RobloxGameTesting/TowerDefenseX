local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 50000,
	Shield = 10000,
	Speed = 2.2,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 400,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	KillBadgeId = 1864276158172623,
	IsMiniBoss = true,
	AbilityNames = {
		Enums.EnemyAbilities.ArtemisRage,
		Enums.EnemyAbilities.ArtemisRageBeams,
		Enums.EnemyAbilities.ArtemisPlasmaBeam,
		Enums.EnemyAbilities.ArtemisPlasmaBurst,
		Enums.EnemyAbilities.ArtemisShock,
		Enums.EnemyAbilities.ArtemisAntiAirAttack
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.ArtemisDeathExplosion },
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 3000, Shield = 2500 },
		[4] = { Health = 5000, Shield = 9000 }
	}
}