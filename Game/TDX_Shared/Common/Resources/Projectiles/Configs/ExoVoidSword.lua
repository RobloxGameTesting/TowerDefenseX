local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ExoVoidSword",
	ModelName = "ExoVoidSword",
	ExplosionEffectName = Enums.VisualEffects.ExoVoidSwordBlast,
	Hitscan = false,
	Velocity = 200,
	ProgressExponential = 0.8,
	MinimumTimeToHit = 0.15,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	TargetTorsoInsteadOfGround = true
}