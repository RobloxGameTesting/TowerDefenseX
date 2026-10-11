local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local deathSpawnData = {
	{
		EnemyType = Enums.Enemies.SlimeGolemMini,
		Count = 3,
		MaxSpawnOffsetStuds = 2,
		OnlyBackwardsOffset = true
	}
}
return {
	Health = 12000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 10,
	BodyHeatRegenerationRate = 2,
	OverrideDisplayName = "Slime Golem",
	Radius = 1,
	SpawnAnimationTime = 3,
	SpawnInvulnerabilityTime = 1,
	AbilityNames = { Enums.EnemyAbilities.SlimeGolemBallThrow },
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GreenGloopLarge,
	FakeEnemy = false,
	DeathSpawnData = deathSpawnData,
	FadeOutOnDeath = true,
	FadeOutDelay = 3,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
	}
}