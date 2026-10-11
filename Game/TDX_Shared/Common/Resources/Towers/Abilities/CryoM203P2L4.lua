local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.75,
		DamageType = Enums.DamageTypes.Ice,
		Damage = 40,
		DamageData = {
			IgnoreResistance = false,
			IceDamageData = {
				BodyHeatReduction = 60,
				PermanentSpeedMultiplierIfFrozen = 1,
				DamageMultiplierIfFrozen = 1,
				ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
				IgnoreIceResistance = false,
				CanFreezeBoss = false
			}
		}
	},
	Name = "CryoM203P2L4",
	DisplayName = "Cryo M203 LVL 1",
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.15,
	Icon = "rbxassetid://11374249533",
	Description = "-",
	AnimationName = "CryoM203",
	ProjectileName = Enums.Projectiles.CryoM203
}