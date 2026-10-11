local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.BackAbomination, Count = 1, ExactPosition = true }
}
return {
	Health = 1500,
	Speed = 3,
	BodyHeat = 250,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData
}