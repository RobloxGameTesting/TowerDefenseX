local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "PatrolBoatFlamethrowerProjectile",
	NoPhysicalProjectile = true,
	Hitscan = false,
	Velocity = 40
}