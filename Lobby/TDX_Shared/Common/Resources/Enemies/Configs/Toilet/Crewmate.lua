local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 225,
	Speed = 6,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 2.5,
	OverrideDisplayName = "Crewmate",
	Radius = 1,
	HoverHeight = 1.525,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}