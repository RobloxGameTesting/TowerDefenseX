local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	HasCustomCode = true,
	Health = 25000,
	Shield = 90000,
	Speed = 1.5,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 900,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	ShieldModelName = "ForceField",
	AbilityNames = { Enums.EnemyAbilities.DeployerInitialShield, Enums.EnemyAbilities.DeployerThrowSpawn },
	DamageReductionTable = {},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.UltraNightmare] = {
			Health = 35000,
			Shield = 125000,
			BodyHeat = 600,
			BodyHeatRegenerationRate = 543345
		}
	}
}