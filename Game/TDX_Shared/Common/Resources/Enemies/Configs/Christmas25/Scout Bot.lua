local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 835,
	NoCash = true,
	Speed = 8.5,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 15,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		}
	}
}