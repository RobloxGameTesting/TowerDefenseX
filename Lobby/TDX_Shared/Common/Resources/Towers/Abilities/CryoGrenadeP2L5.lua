local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		DamageType = Enums.DamageTypes.Ice,
		Damage = 75,
		DamageData = {
			IgnoreResistance = false,
			IceDamageData = {
				BodyHeatReduction = 125,
				PermanentSpeedMultiplierIfFrozen = 1,
				DamageMultiplierIfFrozen = 1,
				ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
				IgnoreIceResistance = false,
				CanFreezeBoss = false
			}
		}
	},
	Name = "CryoGrenadeP2L5",
	DisplayName = "Cryo Grenade LVL 3",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 12,
	Animated = true,
	Delay = 0.05,
	ExecutionTime = 2 / 3,
	Icon = "rbxassetid://15728082666",
	Description = "Throw a grenade at current target.",
	AnimationName = "CryoGrenade",
	ProjectileName = Enums.Projectiles.CryoGrenade,
	HotbarData = { GroupName = "CryoGrenade", Level = 3 }
}