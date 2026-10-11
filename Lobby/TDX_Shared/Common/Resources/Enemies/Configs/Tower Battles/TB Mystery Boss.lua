local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.Eradicator] = 30,
		[Enums.Enemies.RevivedPlagueDoctor] = 35,
		[Enums.Enemies.EradicatorMK2] = 25,
		[Enums.Enemies.TBApexPredator] = 1
	},
	Count = 1,
	ExactPosition = true,
	NoCash = true
}
return {
	OverrideDisplayName = "Mystery Boss",
	Health = 5000,
	Speed = 8,
	AnimationCalibratedSpeed = 1.5,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 15000,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.TBMysteryBossDeath,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	FakeEnemy = false,
	DeathSpawnData = { v }
}