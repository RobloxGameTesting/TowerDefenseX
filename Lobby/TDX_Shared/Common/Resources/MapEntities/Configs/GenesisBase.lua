local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.AutoCannonImpact,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 1,
	VarianceY = 0.5,
	Delay = 0.05
}
local v = {
	ModelName = "Gun",
	Animated = true,
	RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 35, MinRotationX = -20 }
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
	DisabledUntilWaveReached = 43,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 500,
	ReloadTime = 2,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
local v5 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	QueryType = "First",
	DisabledUntilWaveReached = 43,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 500,
	ReloadTime = 2.1,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
return {
	OverrideDisplayName = "GDA Turret",
	Radius = 4,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true,
	HasHealth = true,
	Health = 5500,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.TBPart2Hard] = { Health = 4000 },
		[Enums.Difficulties.TBPart2Nightmare] = { Health = 3000 },
		[Enums.Difficulties.TBPart2Voidmare] = { Health = 655 }
	},
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