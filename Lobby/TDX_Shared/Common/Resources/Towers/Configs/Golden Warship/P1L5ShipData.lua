local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.MinigunSmallBlast,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.35,
	VarianceY = 0.25
}
local gunData = {
	UseTowerLevelStats = true,
	InitialReloadTime = 1,
	HandleProjectileRegeneration = true
}
local gunData2 = {
	UseProjectile = true,
	ProjectileName = Enums.Projectiles.GoldenWarshipMortar,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 2500,
	IsSplash = true,
	SplashRadius = 6,
	ReloadTime = 2
}
local gunData3 = {
	UseProjectile = false,
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 1200,
	IsSplash = false,
	ReloadTime = 0.16
}
return {
	TurretData = {
		{
			TurretIndex = 1,
			TurretModelName = "Turret1",
			GunCount = 5,
			StaggerTime = 2,
			GunData = gunData
		},
		{
			TurretIndex = 2,
			TurretModelName = "Turret2",
			GunCount = 5,
			StaggerTime = 2,
			GunData = gunData
		},
		{
			TurretIndex = 3,
			TurretModelName = "Turret3",
			GunCount = 5,
			StaggerTime = 2,
			GunData = gunData
		},
		{
			TurretIndex = 4,
			TurretModelName = "Turret4",
			GunCount = 5,
			StaggerTime = 2,
			GunData = gunData
		},
		{
			TurretIndex = 5,
			TurretModelName = "Turret5",
			GunCount = 5,
			StaggerTime = 2,
			GunData = gunData
		},
		{
			TurretIndex = 6,
			TurretModelName = "Mortar1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 7,
			TurretModelName = "Mortar2",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 8,
			TurretModelName = "Mortar3",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 9,
			TurretModelName = "Mortar4",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 10,
			TurretModelName = "Mortar5",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 11,
			TurretModelName = "Mortar6",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 12,
			TurretModelName = "Mortar7",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 13,
			TurretModelName = "Mortar8",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 14,
			TurretModelName = "Mortar9",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 15,
			TurretModelName = "Mortar10",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2
		},
		{
			TurretIndex = 16,
			AdditionalTurretIndices = { 17, 18, 19, 20, 21 },
			TurretModelName = "MinigunTurretLeft1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData3,
			DoesNotCountToParentStaggerTime = true,
			ClientHitEffectData = clientHitEffectData,
			CustomQueryOptions = { CanTargetAir = true, IgnoreGround = false }
		},
		{
			TurretIndex = 22,
			AdditionalTurretIndices = { 23, 24, 25, 26, 27 },
			TurretModelName = "MinigunTurretRight1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData3,
			DoesNotCountToParentStaggerTime = true,
			ClientHitEffectData = clientHitEffectData,
			CustomQueryOptions = { CanTargetAir = true, IgnoreGround = false }
		}
	}
}