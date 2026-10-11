local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("Enums"))
return {
	{
		WeldPointerName = "RB1",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 1,
		TimeToStopRotation = 2,
		MaxRotationSpeedZ = -22
	},
	{
		WeldPointerName = "RB2",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 1.2,
		TimeToStopRotation = 2.2,
		MaxRotationSpeedZ = -22
	}
}