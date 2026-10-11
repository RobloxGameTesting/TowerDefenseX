local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 22,
	Speed = 10,
	BodyHeat = 4,
	BodyHeatRegenerationRate = 1.5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 10,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	NoTorso = true,
	DamageReductionTable = {}
}