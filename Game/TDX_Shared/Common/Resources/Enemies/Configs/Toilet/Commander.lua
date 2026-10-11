local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
return {
	Health = 4000,
	Speed = 20,
	NoCash = true,
	BodyHeat = 200,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false
}