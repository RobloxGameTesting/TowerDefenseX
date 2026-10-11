local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
return {
	Name = "GestaltSpear",
	ModelName = "GestaltSpear",
	Hitscan = false,
	Velocity = 80,
	MinimumTimeToHit = 0.15,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	TargetTorsoInsteadOfGround = true
}