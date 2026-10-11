local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideCharacterModelName = "Zombie Drop Pod",
	OverrideDisplayName = "Zombie Drop Pod",
	Health = 10,
	Speed = 0,
	BodyHeat = 10000000,
	BodyHeatRegenerationRate = 20,
	Radius = 1,
	StunResistance = true,
	SuperStunResistance = true,
	NoHead = true,
	NoTorso = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.M1AbramsDeath,
	FadeOutOnDeath = true,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.ZombieDropPodSpawn2 },
	SpawnEffectInstanceNames = { "SpawnEffects" },
	SpawnPathPercentage = 0.3,
	SpawnPathPercentageVariance = 0.15,
	SpawnAnimationTime = 3,
	SpawnInvulnerabilityTime = 99999
}