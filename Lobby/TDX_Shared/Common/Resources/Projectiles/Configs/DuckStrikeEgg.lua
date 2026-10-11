local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DuckStrikeEgg",
	ModelName = "DuckStrikeEgg",
	ExplosionEffectName = Enums.VisualEffects.DuckStrikeExplosion,
	Hitscan = false,
	Velocity = 40,
	MinimumTimeToHit = 0.1
}