local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 50,
		DamageType = Enums.DamageTypes.Ice,
		MaximumTargetsHit = 3,
		DamageData = {
			IgnoreResistance = false,
			IceDamageData = {
				BodyHeatReduction = 80,
				PermanentSpeedMultiplierIfFrozen = 1,
				DamageMultiplierIfFrozen = 1,
				ThawTimeIfFrozen = _G.DEFAULT_THAW_TIME,
				IgnoreIceResistance = false,
				CanFreezeBoss = false
			}
		}
	},
	Name = "CryoHelicopterMissiles",
	DisplayName = "Cryo Missiles (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	CanUseWhileDisabled = true,
	StartingCooldown = 1,
	Cooldown = 2,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "",
	Description = "Helicopter Missiles.",
	ProjectileName = Enums.Projectiles.CryoHelicopterMissile,
	EffectParentInstanceNames = { "MissileEffects" }
}