local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	EnemyTypeChanceMap = {
		[Enums.Enemies.Malice] = 3,
		[Enums.Enemies.SludgeBoss] = 3,
		[Enums.Enemies.Neuron] = 3,
		[Enums.Enemies.VoidBerserker] = 2
	},
	Count = 1,
	ExactPosition = true,
	NoCash = true
}
return {
	Health = 100,
	Shield = 10000,
	Speed = 7.4,
	AlwaysStealthed = true,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 250,
	Radius = 0.86,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 5.4,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = { v }
}