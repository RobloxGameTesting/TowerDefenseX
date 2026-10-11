local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.MutatedOffspringRework, Count = 1, ExactPosition = true }
}
return {
	OverrideDisplayName = "Mutated Zombie",
	Health = 325,
	Shield = 150,
	Speed = 7,
	BodyHeat = 85,
	BodyHeatRegenerationRate = 12,
	Radius = 1,
	HoverHeight = 1.512,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 7,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData
}