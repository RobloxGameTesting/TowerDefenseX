local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CybercubusBall",
	ModelName = "CybercubusBall",
	ExplosionEffectName = Enums.VisualEffects.CybercubusExplosion,
	Hitscan = false,
	Velocity = 50,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 30,
	RotationOffset = CFrame.Angles(0, 0, 0),
	RegenerationDelay = 1,
	RegenerationTime = 1
}