local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "PsychoSlayerMockProjectile",
	ModelName = "PsychoSlayerMockProjectile",
	Hitscan = false,
	Velocity = 1e999,
	MinimumTimeToHit = 0.41133333333333333
}