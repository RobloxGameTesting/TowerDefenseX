local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 20000,
	Speed = 3.5,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 8000,
	BodyHeatRegenerationRate = 3000,
	Radius = 1,
	AnimationTimeScale = 1,
	UnstasisTime = 1,
	UnstasisMovementStartDelay = 1.95,
	UnstasisAnimationName = "Fall",
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart2] = { Health = 70000 }
	}
}