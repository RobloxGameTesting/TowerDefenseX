local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	AlwaysLerpRotation = true,
	OverrideLerpAlphaFactor = 0.008,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			Animated = true,
			AlwaysLerpRotation = true,
			OverrideLerpAlphaFactor = 0.02,
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 35, MinRotationX = -5 }
		}
	}
}
local v2 = {
	OverrideTargetPosition = vector.create(-10.298, 132.955, 148.775),
	AttackTriggeredOnPassedWaves = { 1, 2, 3, 4, 5, 6 },
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.Night3ArtilleryShell,
	IsSplash = true,
	SplashRadius = 5,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 200,
	ReloadTime = 3,
	Range = 150,
	MinimumRange = 45,
	IsBurst = false
}
return {
	OverrideDisplayName = "GDA Artillery",
	Radius = 5,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HasHealth = true,
	Health = 20000,
	DeathEffectInstanceNames = { "DeathVFX", "DeathVFX2" },
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	HasAttack = true,
	AttackData = { v2 },
	TurretConfigs = { v }
}