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
	},
	{
		WeldPointerName = "RB3",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 1.1,
		TimeToStopRotation = 2.1,
		MaxRotationSpeedZ = -22
	},
	{
		WeldPointerName = "RB4",
		TimeToMaxRotationSpeed = 0.25,
		TimeToSpinAfterShot = 0.9,
		TimeToStopRotation = 1.9,
		MaxRotationSpeedZ = -22
	}
}