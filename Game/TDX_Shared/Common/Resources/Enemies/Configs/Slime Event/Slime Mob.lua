local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{ EnemyType = Enums.Enemies.MiniSlime, Count = 8, MaxSpawnOffsetStuds = 3 }
}
return {
	Health = 450,
	Speed = 2.3,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	OverrideDisplayName = "Slime Mob",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DeathExplodePartsScale = 0.6,
	DeathEffectsData = {
		{ InstancePath = "DeathExplodePart" }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 }
	}
}