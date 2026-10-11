local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 4500,
	Shield = 7000,
	Speed = 3,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 900,
	Radius = 1,
	HasCustomCode = true,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1,
	OverrideDisplayName = "X-Nader",
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.XNaderShoot },
	DeathAbilityNames = { Enums.EnemyAbilities.XNaderDeathExplosion },
	DamageReductionTable = {}
}