local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.MutatedOffspring, Count = 1, ExactPosition = true }
}
return {
	Health = 260,
	Speed = 3.8,
	BodyHeat = 65,
	BodyHeatRegenerationRate = 12,
	Radius = 1,
	HoverHeight = 1.512,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData
}