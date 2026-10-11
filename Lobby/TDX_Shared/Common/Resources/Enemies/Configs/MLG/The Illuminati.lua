local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 6000000,
	Speed = 1.1,
	BodyHeat = 133337,
	BodyHeatRegenerationRate = 9001,
	FrozenDebounceTime = 20,
	FrozenMaximumTime = 0.1,
	ThawTime = 2,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	KillBadgeId = 1167076085806468,
	StealthDetection = true,
	IsBoss = true,
	BossMusicName = "TheIlluminatiBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.TheIlluminatiRage,
		Enums.EnemyAbilities.TheIlluminatiSlam,
		Enums.EnemyAbilities.TheIlluminatiLaserBeam,
		Enums.EnemyAbilities.TheIlluminatiEMP
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.6,
	ForceFaceOutroTime = 0.7,
	DeathAbilityNames = {},
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 3,
	FadeOutRemoveDelay = 12,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.02 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 50000, Shield = 175000 },
		[4] = { Health = 150000, Shield = 350000 }
	}
}