local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 170000,
	Speed = 2.1,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	HoverHeight = 2.458,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.4,
	AnimationDefaultStopFadeTime = 0.4,
	IsBoss = true,
	BossMusicName = "RevivedPlagueDoctorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.RevivedPlagueDoctorSummon,
		Enums.EnemyAbilities.RevivedPlagueDoctorSpray,
		Enums.EnemyAbilities.RevivedPlagueDoctorStun,
		Enums.EnemyAbilities.RevivedPlagueDoctorSpawnBird,
		Enums.EnemyAbilities.RevivedPlagueDoctorHeal,
		Enums.EnemyAbilities.RevivedPlagueDoctorSlash,
		Enums.EnemyAbilities.RevivedPlagueDoctorSmokeBlast,
		Enums.EnemyAbilities.RevivedPlagueDoctorSmokeHeal
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
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}