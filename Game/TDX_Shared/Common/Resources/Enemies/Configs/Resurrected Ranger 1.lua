local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 300,
	Speed = 5,
	BodyHeat = 30,
	BodyHeatRegenerationRate = 5,
	OverrideDisplayName = "Resurrected Ranger",
	Radius = 1,
	HoverHeight = 1.2,
	AnimationTimeScale = 1.5,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}