local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		DamageType = Enums.DamageTypes.Ice,
		Damage = 100,
		DamageData = {
			IgnoreResistance = false,
			IceDamageData = {
				BodyHeatReduction = 90,
				PermanentSpeedMultiplierIfFrozen = 1,
				DamageMultiplierIfFrozen = 1,
				ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
				IgnoreIceResistance = false,
				CanFreezeBoss = false
			}
		}
	},
	Name = "CryoM203P2L5",
	DisplayName = "Cryo M203 LVL 2",
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 9,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.15,
	Icon = "rbxassetid://11374249533",
	Description = "-",
	AnimationName = "CryoM203",
	ProjectileName = Enums.Projectiles.CryoM203
}