local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Bubble Companion",
	Health = 100,
	Speed = 3,
	Radius = 1,
	AnimationTimeScale = 1,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HasAttack = false
}