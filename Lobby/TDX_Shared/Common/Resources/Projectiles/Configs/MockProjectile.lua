local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "MockProjectile",
	ModelName = "MockProjectile",
	Hitscan = false,
	Velocity = 99999,
	MinimumTimeToHit = 0
}