local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
return {
	Health = 80000,
	NoCash = true,
	Speed = 3.5,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 5,
	BodyHeatRegenerationRate = 2.5,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false
}