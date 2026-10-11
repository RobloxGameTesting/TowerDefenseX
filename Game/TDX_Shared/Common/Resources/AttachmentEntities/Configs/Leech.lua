local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
return {
	Radius = 0.25,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	AttachToHead = true
}