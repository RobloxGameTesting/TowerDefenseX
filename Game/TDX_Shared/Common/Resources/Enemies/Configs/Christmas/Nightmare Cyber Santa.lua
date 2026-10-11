local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 400000,
	Speed = 2.1,
	AnimationCalibratedSpeed = 2.8,
	BodyHeat = 60000,
	BodyHeatRegenerationRate = 9001,
	OverrideDisplayName = "Nightmare Exo Santa",
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "NightmareCyberSantaBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.NightmareCyberSantaSpamAttack,
		Enums.EnemyAbilities.NightmareCyberSantaBurstAttack,
		Enums.EnemyAbilities.NightmareCyberSantaSummon,
		Enums.EnemyAbilities.NightmareCyberSantaGiftThrow
	},
	AbilityBufferTime = 5,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 4,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 4,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}