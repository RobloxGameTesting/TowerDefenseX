local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 300,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 30,
	BodyHeatRegenerationRate = 7,
	Radius = 1,
	AirUnit = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantBatDeath,
	AbilityNames = { Enums.EnemyAbilities.BatCultistEchoBlast },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.Halloween2025Nightmare] = {
			[Enums.EnemyAbilities.BatCultistEchoBlast] = { DamageMultiplier = 2 }
		}
	},
	FakeEnemy = false,
	DamageReductionTable = {}
}