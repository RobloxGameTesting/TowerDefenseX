local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 80,
		DamageData = { IgnoreResistance = false },
		BurnEffectStats = {
			Name = Enums.BurnEffects.M203,
			DisplayName = "Burn",
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 3,
			Radius = 4,
			Duration = 3,
			StickDuration = 25,
			EnemyBuffNames = { Enums.EnemyBuffs.GrenadierResistanceDebuffL1 }
		}
	},
	Name = "Grenadier Napalm Grenade",
	DisplayName = "Stiel Grenade",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 12,
	Animated = true,
	Delay = 0,
	ExecutionTime = 2,
	Icon = "rbxassetid://118831108667716",
	Description = "Deal napalm damage and reduce enemy damage resistances",
	AnimationName = "Attack",
	ProjectileName = Enums.Projectiles.GrenadierGrenadeBase,
	IsManualAimAtGround = true
}