local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 120000,
	CollisionResistance = 0.07,
	Speed = 1350 / 255,
	AnimationCalibratedSpeed = 2025 / 255,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.25,
	AnimationDefaultStopFadeTime = 0.25,
	StunImmunity = true,
	SuperStunImmunity = true,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.PhantomOverseerDeath,
	GunModelName = "Weapon",
	HasAttack = false,
	StopToAttack = false,
	StealthDetection = false,
	RangeVariance = false
}