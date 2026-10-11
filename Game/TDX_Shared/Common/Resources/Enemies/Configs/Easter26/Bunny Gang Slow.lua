local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 15000,
	Speed = 2.4,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 25,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.4,
	AbilityNames = { Enums.EnemyAbilities.BunnyGangSlowCharge },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}