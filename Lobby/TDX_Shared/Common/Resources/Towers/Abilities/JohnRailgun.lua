local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, Damage = 450, DamageType = Enums.DamageTypes.Laser },
	Name = "JohnRailgun",
	DisplayName = "Railgun",
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 3,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://11374249533",
	Description = "Passive railgun attack.",
	ProjectileName = Enums.Projectiles.JohnRailgunProjectile
}