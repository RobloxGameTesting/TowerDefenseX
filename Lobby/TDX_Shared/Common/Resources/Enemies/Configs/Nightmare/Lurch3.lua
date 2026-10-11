local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1000,
	Shield = 1250,
	Speed = 1.7,
	AnimationCalibratedSpeed = 1,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 250,
	OverrideDisplayName = "Lurch 3",
	Radius = 1,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.Lurch3Transition },
	DamageReductionTable = {}
}