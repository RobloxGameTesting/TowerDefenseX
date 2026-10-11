local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "CombatMedicRevivePack",
	ModelName = "CombatMedicRevivePack",
	Hitscan = false,
	Velocity = 15,
	MinimumTimeToHit = 0.15,
	Arc = true,
	ArcAngle = 25,
	GoalCFrameRotation = CFrame.fromOrientation(-1.5707963267948966, -1.5707963267948966, 0),
	RotationsInAirPerSecondMinimum = 3,
	RotationsInAirPerSecondMaximum = 3,
	AnimationTriggerTime = 0.55,
	SpawnsAttachmentEntity = true
}