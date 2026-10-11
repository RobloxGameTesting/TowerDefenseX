local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 150000,
	Shield = 400000,
	Speed = 3,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 40000,
	BodyHeatRegenerationRate = 950,
	OverrideDisplayName = "Smasher-9x",
	Radius = 1,
	HasCustomCode = true,
	IsMiniBoss = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	ShieldModelName = "ForceField",
	AbilityNames = { Enums.EnemyAbilities.Smasher9xRageTransition, Enums.EnemyAbilities.Smasher9xTremor },
	AbilityBufferTime = 3,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FootstepEffectInstanceNames = { "HumanoidRootPart>WalkFootstepSFX", "HumanoidRootPart>RunFootstepSFX" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 1 }
	}
}