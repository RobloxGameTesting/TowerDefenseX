local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 420000,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.8,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 6000,
	OverrideDisplayName = "Exo Santa",
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "CyberSantaBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.CyberSantaSpamAttack,
		Enums.EnemyAbilities.CyberSantaBurstAttack,
		Enums.EnemyAbilities.CyberSantaSummon
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