local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Overseer Prime",
	HasCustomCode = true,
	Health = 150000,
	CollisionResistance = 0.3,
	Speed = 2.4,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.3,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	StealthDetection = false,
	RangeVariance = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 8,
	AbilityNames = {
		Enums.PathEntityAbilities.OverseerSummon,
		Enums.PathEntityAbilities.OverseerLaser,
		Enums.PathEntityAbilities.OverseerFireball,
		Enums.PathEntityAbilities.OverseerSlash
	},
	AbilityBufferTime = 1,
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true
}