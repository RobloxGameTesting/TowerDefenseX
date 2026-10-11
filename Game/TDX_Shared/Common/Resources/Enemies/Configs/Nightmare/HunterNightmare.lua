local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Hunter",
	OverrideCharacterModelName = Enums.Enemies.Hunter,
	Health = 80000,
	Shield = 120000,
	StealthDetection = true,
	Speed = 2.2,
	AnimationCalibratedSpeed = 1.35,
	BodyHeat = 45000,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	HoverHeight = 2.458,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.375,
	SpawnPathPercentageVariance = 0.15,
	SpawnAnimationTime = 73 / 30,
	SpawnInvulnerabilityTime = 0.35,
	AbilityNames = {
		Enums.EnemyAbilities.HunterNightmareRoll,
		Enums.EnemyAbilities.HunterNightmareBarrage,
		Enums.EnemyAbilities.HunterNightmareAttack,
		Enums.EnemyAbilities.HunterNightmareAntiAir
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	NoTweenOnSpawn = true,
	SpawnEffectInstanceNames = { "HunterSpawnEffects" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 }
	}
}