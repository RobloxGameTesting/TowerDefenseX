local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local v = {
	OverrideTargetPosition = vector.create(105.698, 97.999, 218.924),
	AttackTriggeredOnPassedWaves = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19,
		20
	},
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.NorthforgeNuke,
	IsSplash = true,
	SplashRadius = 5,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 200,
	ReloadTime = 1,
	Range = 150,
	MinimumRange = 45,
	IsBurst = false
}
return {
	OverrideDisplayName = "GDA Missile Silo",
	Radius = 4,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true,
	HasHealth = true,
	Health = 50000,
	DeathEffectInstanceNames = { "DeathVFX", "DeathVFX2" },
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	HasAttack = true,
	AttackData = { v }
}