local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.ArtilleryImpactLarge,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 1,
	VarianceY = 0.5,
	Delay = 0.05
}
local v = {
	ModelName = "Gun",
	Animated = true,
	RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 35, MinRotationX = -30 }
}
local v2 = {
	ModelName = "Turret1",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v3 = {
	ModelName = "Turret2",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v4 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	QueryType = "First",
	DisabledUntilWaveReached = 20,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 2500,
	ReloadTime = 3.5,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
local v5 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	QueryType = "Strongest",
	DisabledUntilWaveReached = 20,
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 2500,
	ReloadTime = 3.83,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
return {
	NoHoverTooltip = true,
	Radius = 4,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true,
	HasHealth = true,
	Health = 5500,
	DeathEffectInstanceNames = {},
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	HasAttack = true,
	AttackData = { v4, v5 },
	TurretConfigs = { v2, v3 },
	TurretNoTrackTarget = true
}