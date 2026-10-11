local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 1500,
	Shield = 500,
	Speed = 3.4,
	BodyHeat = 1,
	BodyHeatRegenerationRate = 1,
	Radius = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.FlyingPumpkinSpawnSelfProjectile },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	NoHead = true,
	NoTorso = true,
	DamageReductionTable = {}
}