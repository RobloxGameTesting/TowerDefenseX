local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Revived Plague Doctor+",
	Health = 350000,
	Shield = 100000,
	Speed = 2.5,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 300,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	ThawTime = 0.8,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.4,
	AnimationDefaultStopFadeTime = 0.4,
	IsBoss = true,
	BossMusicName = "RevivedPlagueDoctorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkBigSummon,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkHeal,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSummon,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSpray,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkStun,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSlash,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSmokeBlast,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSmokeHeal,
		Enums.EnemyAbilities.RevivedPlagueDoctorReworkSpawnBird
	},
	AbilityBufferTime = 2,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.RevivedPlagueDoctorDeath,
	HasChangeColorParts = true,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	ShieldModelName = "ForceField",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.15 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 50000 },
		[4] = { Health = 100000 }
	}
}