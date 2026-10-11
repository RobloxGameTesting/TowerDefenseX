local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.SlimeMob,
		Count = 3,
		MaxSpawnOffsetStuds = 2,
		OnlyBackwardsOffset = true
	}
}
return {
	Health = 1900,
	Speed = 2.6,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	OverrideDisplayName = "Slime Bloat",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GreenGloopLarge,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	}
}