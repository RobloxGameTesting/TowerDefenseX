local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
return {
	Health = 0,
	Speed = 25,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = true,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 0.7,
	NoTweenOnSpawn = true
}