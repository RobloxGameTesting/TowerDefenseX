local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.AASmallBlast,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.35,
	VarianceY = 0.25
}
local gunData = { UseTowerLevelStats = true, InitialReloadTime = 1 }
local gunData2 = {
	UseProjectile = false,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 1500,
	IsSplash = true,
	SplashRadius = 3,
	ReloadTime = 0.2
}
return {
	TurretData = {
		{
			TurretIndex = 1,
			TurretModelName = "Turret1",
			GunCount = 3,
			StaggerTime = 1,
			GunData = gunData
		},
		{
			TurretIndex = 2,
			TurretModelName = "Turret2",
			GunCount = 3,
			StaggerTime = 1,
			GunData = gunData,
			InitialReloadTimeOffset = 0.5
		},
		{
			TurretIndex = 3,
			TurretModelName = "AATurretLeft1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			DoesNotCountToParentStaggerTime = true,
			ClientHitEffectData = clientHitEffectData,
			CustomQueryOptions = { CanTargetAir = true, IgnoreGround = true }
		},
		{
			TurretIndex = 4,
			TurretModelName = "AATurretRight1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			DoesNotCountToParentStaggerTime = true,
			ClientHitEffectData = clientHitEffectData,
			CustomQueryOptions = { CanTargetAir = true, IgnoreGround = true }
		}
	}
}