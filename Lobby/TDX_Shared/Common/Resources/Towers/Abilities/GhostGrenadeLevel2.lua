local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 6, TowerStealthDuration = 25 },
	ProjectileHitDataAffectTowers = true,
	Name = "GhostGrenade",
	DisplayName = "Ghost Grenade LVL 2",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 40,
	Animated = true,
	Delay = 0.15,
	ExecutionTime = 1,
	Icon = "rbxassetid://18731245777",
	Description = "Throw a grenade at current target.",
	AnimationName = "Grenade",
	ProjectileName = Enums.Projectiles.GhostGrenade,
	IsManualAimAtGround = true,
	ManualAimRespectMinMaxHeight = true,
	HotbarData = { Level = 2 }
}