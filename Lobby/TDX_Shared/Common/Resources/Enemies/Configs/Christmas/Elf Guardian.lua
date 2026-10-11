local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 18000,
	Speed = 2.3,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 1500,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	HoverHeight = 2.3,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ElfGuardianSpinAttack },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5
}