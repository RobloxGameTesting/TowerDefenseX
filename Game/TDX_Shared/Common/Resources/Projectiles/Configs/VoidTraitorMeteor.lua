local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
return {
	Name = "VoidTraitorMeteor",
	NoPhysicalProjectile = true,
	Hitscan = false,
	StraightDown = true,
	Velocity = 250,
	MinimumTimeToHit = 2
}