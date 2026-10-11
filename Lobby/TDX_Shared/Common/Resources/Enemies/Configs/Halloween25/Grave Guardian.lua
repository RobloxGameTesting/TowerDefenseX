local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 15000,
	Shield = 10000,
	Speed = 3.2,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 4150,
	BodyHeatRegenerationRate = 800,
	Radius = 1,
	HasCustomCode = true,
	FootstepEffectInstanceNames = { "RootPart>FootstepSFX" },
	AbilityNames = { Enums.EnemyAbilities.GraveGuardianTomahawkThrow, Enums.EnemyAbilities.GraveGuardianShieldCharge },
	AbilityBufferTime = 2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.GraveGuardianDeath,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.75 }
	}
}