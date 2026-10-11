local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 100
	},
	Name = "GrenadeLevel2",
	DisplayName = "Grenade LVL 2",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	Animated = true,
	Delay = 0.15,
	ExecutionTime = 1,
	Icon = "rbxassetid://11374249533",
	Description = "Throw a grenade at current target.",
	AnimationName = "Grenade",
	ProjectileName = Enums.Projectiles.Grenade,
	HotbarData = { GroupName = "Grenade", Level = 2 }
}