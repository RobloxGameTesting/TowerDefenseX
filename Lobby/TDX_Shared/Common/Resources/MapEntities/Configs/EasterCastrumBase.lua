local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local v = {
	ModelName = "Turret1",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
local v2 = {
	ModelName = "Turret2",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
local v3 = {
	ModelName = "Turret3",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
local v4 = {
	ModelName = "Turret4",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
local v5 = {
	CanTargetAir = true,
	QueryType = "Random",
	DisabledUntilWaveReached = 0,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, -1),
	ForceTurretIndex = 1,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 50,
	ReloadTime = 3.2,
	Range = 120,
	MinimumRange = 8,
	IsBurst = false,
	IsSplash = true,
	SplashRadius = 2.5,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.EasterCastrumBaseProjectile1
}
local v6 = {
	CanTargetAir = false,
	QueryType = "Random",
	DisabledUntilWaveReached = 0,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, -1),
	ForceTurretIndex = 2,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 50,
	ReloadTime = 3.5300000000000002,
	Range = 120,
	MinimumRange = 8,
	IsBurst = false,
	IsSplash = true,
	SplashRadius = 2.5,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.EasterCastrumBaseProjectile2
}
local v7 = {
	CanTargetAir = true,
	QueryType = "Random",
	DisabledUntilWaveReached = 0,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, 1),
	ForceTurretIndex = 3,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 50,
	ReloadTime = 3.2,
	Range = 120,
	MinimumRange = 8,
	IsBurst = false,
	IsSplash = true,
	SplashRadius = 2.5,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.EasterCastrumBaseProjectile3
}
local v8 = {
	CanTargetAir = false,
	QueryType = "Random",
	DisabledUntilWaveReached = 0,
	MaximumROM = 210,
	MaximumROMForwardsVector = createVector(0, 0, 1),
	ForceTurretIndex = 4,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 50,
	ReloadTime = 3.5300000000000002,
	Range = 120,
	MinimumRange = 8,
	IsBurst = false,
	IsSplash = true,
	SplashRadius = 2.5,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.EasterCastrumBaseProjectile4
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
	AttackData = { v5, v6, v7, v8 },
	TurretConfigs = { v, v2, v3, v4 },
	TurretNoTrackTarget = true
}