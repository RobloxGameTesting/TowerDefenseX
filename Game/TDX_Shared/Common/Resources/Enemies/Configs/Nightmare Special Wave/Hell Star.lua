local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	HoverHeightVariance = 0.5,
	Health = 99999,
	Shield = 142000,
	Speed = 3.5,
	BodyHeat = 6666,
	BodyHeatRegenerationRate = 1666,
	Radius = 1,
	SpawnPathPercentage = 0.25,
	SpawnPathPercentageVariance = 0.125,
	SpawnAnimationTime = 1,
	SpawnInvulnerabilityTime = 1,
	SpawnEffectInstanceNames = { "SpawnFX" },
	AbilityNames = { Enums.EnemyAbilities.HellStarSwordZap },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FootstepEffectInstanceNames = { "Root>MoveSFX" },
	NoTweenOnSpawn = true
}