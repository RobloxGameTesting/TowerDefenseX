local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 7500,
	Shield = 3000,
	Speed = 5,
	BodyHeat = 13453254,
	BodyHeatRegenerationRate = 13245,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.DuckStrikeEggAttack },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 }
	}
}