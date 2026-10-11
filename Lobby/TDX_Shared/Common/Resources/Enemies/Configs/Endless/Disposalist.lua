local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 300,
	Speed = 1.3,
	AnimationCalibratedSpeed = 1.3,
	BodyHeat = 230,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.DisposalistGrenade },
	ForceFaceIntroTime = 0.35,
	ForceFaceOutroTime = 0.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}