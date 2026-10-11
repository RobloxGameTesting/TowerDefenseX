local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100,
	Speed = 6,
	AnimationCalibratedSpeed = 6,
	BodyHeat = 70,
	BodyHeatRegenerationRate = 20,
	Radius = 1,
	HoverHeight = 1.288,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.PsychoKnife },
	ForceFaceIntroTime = 0.35,
	ForceFaceOutroTime = 0.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}