local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Coffin Spawner",
	Health = 10000,
	Speed = 0,
	BodyHeat = 10000000,
	BodyHeatRegenerationRate = 75,
	Radius = 1,
	HoverHeight = 0,
	StunResistance = true,
	SuperStunResistance = true,
	NoHead = true,
	NoTorso = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.CoffinHeadSpawnerSpawn },
	SpawnInvulnerabilityTime = 99999
}