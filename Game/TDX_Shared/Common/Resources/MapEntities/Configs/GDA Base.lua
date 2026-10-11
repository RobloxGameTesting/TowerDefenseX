local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.GDABaseRailgunBlast,
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
	ModelName = "Turret3",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v5 = {
	ModelName = "Turret4",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v6 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	SpawnPositionOffset = createVector(0, 0, 11),
	QueryType = "Strongest",
	DisabledUntilBossWithTypeSpawned = Enums.Enemies.CorruptedApexPredator,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, 1),
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 3000,
	ReloadTime = 10,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
local v7 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	SpawnPositionOffset = createVector(-11, 0, 0),
	QueryType = "Strongest",
	DisabledUntilBossWithTypeSpawned = Enums.Enemies.CorruptedApexPredator,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(-1, 0, 0),
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 3000,
	ReloadTime = 10,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
local v8 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	SpawnPositionOffset = createVector(0, 0, -11),
	QueryType = "Strongest",
	DisabledUntilBossWithTypeSpawned = Enums.Enemies.CorruptedApexPredator,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, -1),
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 3000,
	ReloadTime = 10,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
local v9 = {
	ClientHitEffectData = clientHitEffectData,
	CanTargetAir = true,
	SpawnPositionOffset = createVector(11, 0, 0),
	QueryType = "Strongest",
	DisabledUntilBossWithTypeSpawned = Enums.Enemies.CorruptedApexPredator,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(1, 0, 0),
	DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
	Damage = 3000,
	ReloadTime = 10,
	Range = 150,
	MinimumRange = 8,
	IsBurst = false
}
return {
	OverrideDisplayName = "GDA Base",
	Radius = 10,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HasHealth = true,
	Health = 40000,
	DeathEffectInstanceNames = { "DeathVFX", "DeathVFX2" },
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	HasAttack = true,
	AttackData = { v6, v7, v8, v9 },
	TurretConfigs = { v2, v3, v4, v5 },
	NearbyTowerBuffRadius = 40,
	NearbyTowerBuffData = { RangeBuff = 0.2, UseRange3 = true }
}