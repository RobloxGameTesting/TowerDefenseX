local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 4100000,
	Shield = 500000,
	Speed = 1.5,
	BodyHeat = 130000,
	BodyHeatRegenerationRate = 1000,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	PreventDeathUntilAbilityExecuted = Enums.EnemyAbilities.AlphaPredatorRage,
	KillBadgeId = 1516606813975128,
	IsBoss = true,
	BossMusicName = "AlphaPredatorBossMusic",
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.AlphaPredatorRage },
		{ Name = Enums.EnemyAbilities.AlphaPredatorRage_Invulnerable },
		{ Name = Enums.EnemyAbilities.AlphaPredatorNukeThrow },
		{ Name = Enums.EnemyAbilities.AlphaPredatorChestHitEMP },
		{ Name = Enums.EnemyAbilities.AlphaPredatorChestHitEMP_Parallel },
		{ Name = Enums.EnemyAbilities.AlphaPredatorHammerSlam },
		{ Name = Enums.EnemyAbilities.AlphaPredatorHammerSlam_Gunshot },
		{ Name = Enums.EnemyAbilities.AlphaPredatorMissiles },
		{ Name = Enums.EnemyAbilities.AlphaPredatorLaserArc },
		{ Name = Enums.EnemyAbilities.AlphaPredatorLaserEye },
		{ Name = Enums.EnemyAbilities.AlphaPredatorFlamethrower },
		{ Name = Enums.EnemyAbilities.AlphaPredatorDash },
		{ Name = Enums.EnemyAbilities.AlphaPredatorDash_Land }
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 1.2,
	DeathAbilityNames = {},
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 175000, Shield = 100000 },
		[3] = { Health = 400000, Shield = 175000 },
		[4] = { Health = 450000, Shield = 220000 }
	}
}