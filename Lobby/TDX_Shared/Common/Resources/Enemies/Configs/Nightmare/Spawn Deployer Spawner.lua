local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Spawner",
	OverrideCharacterModelName = "DeployerObjectSpawn",
	Health = 10000,
	Shield = 120000,
	Speed = 0,
	BodyHeat = 10000000,
	BodyHeatRegenerationRate = 75,
	Radius = 1,
	HoverHeight = 0,
	StunResistance = true,
	SuperStunResistance = true,
	NoHead = true,
	NoTorso = true,
	SpawnAnimationTime = 1.15,
	SpawnInvulnerabilityTime = 1.15,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.SpawnDeployerDeath,
	FakeEnemy = false,
	AbilityNames = {
		{
			Name = Enums.EnemyAbilities.SpawnDeployerSpawnerSpawn,
			DisableDifficulties = { Enums.Difficulties.UltraNightmare }
		},
		{
			Name = Enums.EnemyAbilities.SpawnDeployerSpawnerSpawnUltra,
			EnableDifficulties = { Enums.Difficulties.UltraNightmare }
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.UltraNightmare] = {
			OverrideDisplayName = "Ultra Spawner",
			Health = 5000,
			Shield = 1000
		}
	}
}