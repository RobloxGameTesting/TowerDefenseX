local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "GrandSlamMockProjectile",
	ModelName = "GrandSlamMockProjectile",
	Hitscan = false,
	Velocity = 99999,
	MinimumTimeToHit = 0,
	AnimationTriggerTime = 0.367
}