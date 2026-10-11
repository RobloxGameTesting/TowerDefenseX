local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.MinigunHit,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.5,
	VarianceY = 0.3
}
local v = {
	ModelName = "Gun",
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		}
	},
	RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 35, MinRotationX = -30 },
	SoundGroupName = "Minigun",
	SoundGroupStopDelay = 0.3
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
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 165,
	ReloadTime = 0.1,
	Range = 100,
	MinimumRange = 0,
	IsBurst = false
}
local v5 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	QueryType = "First",
	DisabledUntilWaveReached = 20,
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 165,
	ReloadTime = 0.1,
	Range = 100,
	MinimumRange = 0,
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