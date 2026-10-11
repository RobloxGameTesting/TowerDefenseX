local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 525,
	Shield = 175,
	Speed = 3.4,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = {
		{
			Name = Enums.EnemyAbilities.BerryCarrotGrenadeThrow,
			DisableDifficulties = { Enums.Difficulties.Easter26Part1Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.BerryCarrotGrenadeThrowNightmare,
			EnableDifficulties = { Enums.Difficulties.Easter26Part1Nightmare }
		}
	},
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
	}
}