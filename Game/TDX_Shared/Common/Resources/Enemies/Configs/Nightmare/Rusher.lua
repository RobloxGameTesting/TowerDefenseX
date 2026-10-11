local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 3500,
	Speed = 8.2,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	HasCustomCode = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1,
	FakeEnemy = false,
	DeathAbilityNames = { Enums.EnemyAbilities.RusherDeathExplosion },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
	}
}