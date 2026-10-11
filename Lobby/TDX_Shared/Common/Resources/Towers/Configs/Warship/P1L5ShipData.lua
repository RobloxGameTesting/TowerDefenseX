local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local gunData = { UseTowerLevelStats = true, InitialReloadTime = 1 }
local gunData2 = {
	UseProjectile = true,
	ProjectileName = Enums.Projectiles.BattleshipMortar,
	DamageType = Enums.DamageTypes.Explosive,
	Damage = 225,
	IsSplash = true,
	SplashRadius = 4,
	ReloadTime = 5
}
return {
	TurretData = {
		{
			TurretModelName = "Turret1",
			GunCount = 3,
			StaggerTime = 2.5,
			GunData = gunData,
			GunFireAngle = 15
		},
		{
			TurretModelName = "Turret2",
			GunCount = 3,
			StaggerTime = 2.5,
			GunData = gunData,
			GunFireAngle = 15
		},
		{
			TurretModelName = "Turret3",
			GunCount = 4,
			StaggerTime = 2.5,
			GunData = gunData,
			GunFireAngle = 15
		},
		{
			TurretModelName = "Turret4",
			GunCount = 4,
			StaggerTime = 2.5,
			GunData = gunData,
			GunFireAngle = 15,
			RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
		},
		{
			TurretModelName = "Turret5",
			GunCount = 3,
			StaggerTime = 2.5,
			GunData = gunData,
			GunFireAngle = 15,
			RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
		},
		{
			TurretModelName = "Mortar1",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar2",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar3",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar4",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar5",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar6",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar7",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
		},
		{
			TurretModelName = "Mortar8",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData2,
			RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
		}
	}
}