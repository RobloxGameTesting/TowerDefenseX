local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 75000,
	Shield = 60000,
	Speed = 2.2,
	AnimationCalibratedSpeed = 1.35,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 1250,
	Radius = 1,
	HoverHeight = 2.458,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.HunterAttack },
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.95 }
	}
}