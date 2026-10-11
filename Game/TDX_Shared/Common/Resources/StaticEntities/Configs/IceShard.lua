local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("DamageTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local hitData = {
	IsSplash = true,
	SplashRadius = 6,
	Damage = 500,
	DamageType = Enums.DamageTypes.Ice,
	DamageData = {
		IceDamageData = {
			BodyHeatReduction = 1000,
			IgnoreIceResistance = true,
			CanFreezeBoss = true
		}
	}
}
return {
	OverrideDisplayName = "Ice Shard",
	NoDisplayPathLevelString = true,
	Radius = 1,
	HoverHeight = 0,
	HoverHeightVariance = 0,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	CollisionHealth = 1250,
	CollisionEffectName = Enums.VisualEffects.IceBreakerIceShardHit,
	HitData = hitData,
	StealthDetection = true,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 0,
	FadeOutRemoveDelay = 2,
	ExplosionEffectNames = { Enums.VisualEffects.IceBreakerIceShardDeath }
}