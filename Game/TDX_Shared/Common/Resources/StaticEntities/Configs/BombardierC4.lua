local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Bombardier's C4",
	Radius = 0.1,
	AnimationTimeScale = 1,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	NoHead = true,
	NoTorso = true,
	IsBombardierC4 = true,
	ExplosionEffectNames = { Enums.VisualEffects.BombardierC4Explosion }
}