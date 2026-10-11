local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 25000,
	Speed = 6.4,
	AnimationCalibratedSpeed = 6.4,
	BodyHeat = 29000,
	BodyHeatRegenerationRate = 3000,
	FrozenDebounceTime = 10,
	FrozenMaximumTime = 6,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	FadeOutOnDeath = true,
	FadeOutDelay = 4,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	DeathExplodePartsScale = 2,
	AbilityNames = { Enums.EnemyAbilities.ShieldBusterDetonate },
	FakeEnemy = false,
	DamageReductionTable = {},
	DifficultyToStatOverrideMap = {}
}