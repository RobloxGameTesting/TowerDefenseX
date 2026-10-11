local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 305,
	Speed = 2.2,
	BodyHeat = 25,
	BodyHeatRegenerationRate = 5,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	AbilityNames = { Enums.EnemyAbilities.PSmasherSlam },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.PVP_1V1] = { BodyHeat = 3000, BodyHeatRegenerationRate = 95 }
	},
	DamageReductionTable = {}
}