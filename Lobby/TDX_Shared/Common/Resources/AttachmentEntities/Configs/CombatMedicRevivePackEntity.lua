local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Radius = 0.25,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
	AttachToGround = true,
	NoAnimations = true,
	SpawnEffectInstanceNames = { "Head", "Torso" },
	DeathEffect = Enums.DeathEffects.ReviveEffect,
	OverrideProjectileCFrame = true
}