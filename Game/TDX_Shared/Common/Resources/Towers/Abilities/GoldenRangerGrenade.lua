local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local damageData = {
	IgnoreResistance = false,
	StunData = {
		StunType = Enums.StunTypes.GoldenRangerShock,
		StunDuration = 1,
		CanStunBoss = true,
		IgnoreStunResistance = true
	}
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 350,
		DamageData = damageData,
		BurnEffectStats = {
			Name = Enums.BurnEffects.RedBurn,
			DisplayName = "Burn",
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 50,
			Radius = 4,
			Duration = 0.3,
			StickDuration = 5
		}
	},
	Name = "Golden Ranger Grenade",
	DisplayName = "Golden Ranger Grenade",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 7,
	Animated = true,
	Delay = 0.1,
	ExecutionTime = 1.1,
	Icon = "rbxassetid://17154787140",
	Description = "Stun, burn, and explode.",
	AnimationName = "Grenade",
	ProjectileName = Enums.Projectiles.GoldenRangerGrenade
}