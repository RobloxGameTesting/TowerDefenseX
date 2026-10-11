local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.X2Trooper] = 20,
		[Enums.Enemies.Ironclad] = 30,
		[Enums.Enemies.ToiletJohnBoss] = 10,
		[Enums.Enemies.MLGGeneralCelgar] = 5
	},
	Count = 1,
	ExactPosition = true
}
return {
	OverrideDisplayName = "Super Mystery Boss",
	Health = 50000,
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