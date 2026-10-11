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
		Damage = 300,
		BurnEffectStats = {
			Name = Enums.BurnEffects.RedBurn,
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 40,
			Radius = 4.5,
			Duration = 5,
			StickDuration = 3,
			EnemyBuffNames = { Enums.EnemyBuffs.GoldenM203Slow }
		}
	},
	Name = "GoldenM203",
	DisplayName = "G M203 Incendiary",
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.15,
	Icon = "",
	Description = "G M203 incendiary.",
	AnimationName = "M203",
	ProjectileName = Enums.Projectiles.GoldenM203,
	CustomQueryFilterData = function(object)
		return not object:GetIsAirUnit()
	end
}