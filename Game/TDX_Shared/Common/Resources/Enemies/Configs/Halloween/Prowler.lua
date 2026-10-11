local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 350,
	Speed = 1.6,
	AnimationCalibratedSpeed = 1.3,
	BodyHeat = 230,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	HoverHeight = 1.283,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ProwlerDamaged },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}