local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	InstantLossIfReachEnd = true,
	AirUnit = true,
	Health = 5776879,
	Speed = 3.4,
	BodyHeat = 10000000,
	BodyHeatRegenerationRate = 2000000,
	HoverHeight = 5,
	Radius = 1,
	KillAllOtherEnemiesOnDeath = true,
	KillAllOtherEnemiesOnDeathStaggerTime = 7,
	KillAllOtherEnemiesOnDeathIgnoreOwnSequence = true,
	KillBadgeId = 2662571606838759,
	IsBoss = true,
	BossMusicName = "NemesisBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.NemesisEnrage,
		Enums.EnemyAbilities.NemesisSpin,
		Enums.EnemyAbilities.NemesisScytheSlash,
		Enums.EnemyAbilities.NemesisSummon
	},
	AbilityBufferTime = 3,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	MinimumTimeBeforeSequenceEnds = 13.4,
	HasCustomCode = true,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 8,
	FootstepEffectInstanceNames = { "Root>FootstepSFX" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}