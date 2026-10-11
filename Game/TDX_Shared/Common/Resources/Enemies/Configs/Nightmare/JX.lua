local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "J-X",
	OverrideCharacterModelName = "J-X",
	Health = 35000,
	Shield = 20000,
	Speed = 6.5,
	AnimationCalibratedSpeed = 7.6,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 700,
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.JXSlash },
	FootstepEffectInstanceNames = { "HumanoidRootPart>FootstepSFX" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
	}
}