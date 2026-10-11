local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local damageData = {
	IgnoreResistance = false,
	StunData = {
		StunType = Enums.StunTypes.PsychoSlayerSlamStun,
		StunDuration = 1.5,
		CanStunBoss = true
	}
}
local projectileHitData = {
	IsSplash = true,
	SplashRadius = 2,
	DamageType = Enums.DamageTypes.Melee,
	Damage = 4000,
	DamageData = damageData
}
return {
	Name = "Slam Attack",
	DisplayName = "Slam Attack LVL 5 (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 1,
	Cooldown = 11,
	Animated = true,
	AnimationName = "Slam",
	Delay = 0,
	ExecutionTime = 1.3,
	ProjectileName = Enums.Projectiles.PsychoSlayerMockProjectile,
	ProjectileHitData = projectileHitData,
	CustomQueryData = { Range = 7, StealthDetection = false, QueryType = "HighestHealthPercentage" },
	CustomQueryFilterData = function(p)
		return p.HealthHandler:GetHealth() >= 300
	end,
	Icon = "",
	Description = "",
	EffectParentInstanceNames = { "Slam" },
	EffectsStartDelay = 0.617,
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Slam" }
}