local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 15000,
	Shield = 10000,
	Speed = 5,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 200,
	Radius = 1.59,
	AnimationTimeScale = 1,
	NoAdjustMovementAnimationSpeed = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	HasCustomCode = true,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 3,
	DeathAbilityNames = { Enums.EnemyAbilities.BlisterDeathExplosion }
}