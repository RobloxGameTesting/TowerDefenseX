local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Mega Knight",
	Health = 8500,
	Shield = 1500,
	Speed = 4.6,
	BodyHeat = 2000,
	BodyHeatRegenerationRate = 75,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	AbilityNames = { Enums.EnemyAbilities.WreckerJump },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 }
	}
}