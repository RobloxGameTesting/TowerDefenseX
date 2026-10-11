local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 30000,
	Speed = 3.4,
	AnimationCalibratedSpeed = 3.4,
	BodyHeat = 12500,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.TrackerLaser },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {}
}