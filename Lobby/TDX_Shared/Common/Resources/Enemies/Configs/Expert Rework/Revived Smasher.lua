local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 11000,
	Speed = 3.1,
	BodyHeat = 2400,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.RevivedSmasherSlam, Enums.EnemyAbilities.RevivedSmasherSlamPathEntities },
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.PVP_1V1] = {
			[Enums.EnemyAbilities.RevivedSmasherSlam] = { DamageMultiplier = 1 },
			[Enums.EnemyAbilities.RevivedSmasherSlamPathEntities] = { DamageMultiplier = 5 }
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.5 }
	}
}