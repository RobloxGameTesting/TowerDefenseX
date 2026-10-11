local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Speed Pad",
	StealthMaintainColor = true,
	Radius = 0.1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	ExplodeAfterLifetime = true,
	StealthDetection = true,
	CollideWithEnemyBuffNames = { Enums.EnemyBuffs.DeployerObjectSpeedBuff },
	ExplosionEffectNames = { Enums.VisualEffects.MineExplosion }
}