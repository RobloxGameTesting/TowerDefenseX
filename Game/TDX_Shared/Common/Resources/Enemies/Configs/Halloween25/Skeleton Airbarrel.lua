local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.MiniSkeleton,
		Count = 15,
		MaxSpawnOffsetStuds = 4,
		Delay = 47 / 60,
		NoSpawnTween = true
	}
}
return {
	AirUnit = true,
	Health = 1000,
	Speed = 3.7,
	BodyHeat = 350,
	BodyHeatRegenerationRate = 80,
	Radius = 1,
	HasCustomCode = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	DeathSpawnData = deathSpawnData,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 0.1,
	FadeOutRemoveDelay = 5,
	FakeEnemy = false,
	NoHead = true,
	NoTorso = true,
	DamageReductionTable = {}
}