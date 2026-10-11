local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local gunData = { UseTowerLevelStats = true, InitialReloadTime = 1 }
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
		}
	}
}