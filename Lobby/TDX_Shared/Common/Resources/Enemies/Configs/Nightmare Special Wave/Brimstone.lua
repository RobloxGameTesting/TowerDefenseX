local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 240000,
	Speed = 2.7,
	AnimationCalibratedSpeed = 4.050000000000001,
	BodyHeat = 66666,
	BodyHeatRegenerationRate = 9666,
	ThawTime = 0.2,
	HasCustomCode = true,
	Radius = 1,
	AbilityNames = { Enums.EnemyAbilities.BrimstoneTransition },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FootstepEffectInstanceNames = { "Root>WalkFootstepSFX", "Root>RunFootstepSFX" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	}
}