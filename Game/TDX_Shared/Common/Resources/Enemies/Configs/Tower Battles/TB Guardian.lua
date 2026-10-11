local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Guardian",
	Health = 100000,
	Speed = 1.4,
	AnimationCalibratedSpeed = 1.4,
	BodyHeat = 12000,
	BodyHeatRegenerationRate = 5500,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.TBGuardianAxeSlam },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}