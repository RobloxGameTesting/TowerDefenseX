local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local gunData = { UseTowerLevelStats = true, InitialReloadTime = 1 }
return {
	TurretData = {
		{
			TurretModelName = "TurretFront",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData,
			GunFireAngle = 30,
			RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
		},
		{
			TurretModelName = "TurretBack",
			GunCount = 1,
			StaggerTime = 0,
			GunData = gunData,
			GunFireAngle = 30,
			InitialReloadTimeOffset = 1.5
		}
	}
}