local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local damageData = {
	IgnoreResistance = false,
	StunData = {
		StunType = Enums.StunTypes.SlammerSlam,
		StunDuration = 1.5,
		CanStunBoss = true,
		IgnoreStunResistance = true
	}
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		DamageType = Enums.DamageTypes.Melee,
		Damage = 800,
		DamageData = damageData,
		BurnEffectStats = {
			Name = Enums.BurnEffects.M203,
			DisplayName = "Burn",
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 50,
			Radius = 4,
			Duration = 0.3,
			StickDuration = 10
		}
	},
	Name = "Grand Slam",
	DisplayName = "Grand Slam",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 6,
	Animated = true,
	Delay = 0,
	ExecutionTime = 1.3,
	Icon = "rbxassetid://17684279601",
	Description = "Can stun bosses.",
	AnimationName = "GrandSlam",
	ProjectileName = Enums.Projectiles.GrandSlamMockProjectile,
	EffectParentInstanceNames = { "GrandSlamVFX", "Root" }
}