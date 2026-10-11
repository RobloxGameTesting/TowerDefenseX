local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 45000,
	Speed = 2,
	BodyHeat = 2800,
	BodyHeatRegenerationRate = 75,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	ThawTime = 0.4,
	Radius = 1,
	HoverHeight = 2.458,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "PlagueDoctorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.PlagueDoctorSummon,
		Enums.EnemyAbilities.PlagueDoctorSpray,
		Enums.EnemyAbilities.PlagueDoctorStun,
		Enums.EnemyAbilities.PlagueDoctorSpawnBird,
		Enums.EnemyAbilities.PlagueDoctorSmokeBlast,
		Enums.EnemyAbilities.PlagueDoctorSmokeHeal
	},
	AbilityBufferTime = 1,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.BossBlood,
	HasChangeColorParts = true,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.13 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	}
}