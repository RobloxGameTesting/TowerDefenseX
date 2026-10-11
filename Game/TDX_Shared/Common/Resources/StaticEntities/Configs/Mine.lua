local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Radius = 0.1,
	AnimationTimeScale = 1,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	ExplodeOnContactWithEnemy = true,
	VariableModel = true,
	ExplosionEffectNames = { Enums.VisualEffects.MineExplosion },
	VariableExplosionEffects = true,
	ExplosionDelay = 0.05
}