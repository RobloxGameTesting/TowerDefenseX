local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.ChariotTurret, Count = 1, Delay = 0, PathStudsOffset = -1.8 }
}
return {
	Health = 2200,
	Shield = 1200,
	Speed = 2.9,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 800,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.ChariotDropTurret },
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {}
}