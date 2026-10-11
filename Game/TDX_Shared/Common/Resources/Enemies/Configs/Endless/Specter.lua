local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2000,
	Shield = 5000,
	Speed = 2,
	AnimationCalibratedSpeed = 1.3,
	BodyHeat = 1175,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.SpecterGrenade },
	ForceFaceIntroTime = 0.35,
	ForceFaceOutroTime = 0.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}