local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Radioactive Sludge",
	StealthMaintainColor = true,
	Radius = 0.5,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	NoTweenOnSpawn = true,
	CollideWithEnemyBuffNames = { Enums.EnemyBuffs.HazmatZombieReworkSpeedBuff },
	ExplosionEffectNames = { Enums.VisualEffects.MineExplosion },
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2
}