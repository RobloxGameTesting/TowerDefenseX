local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		BurnEffectStats = {
			Name = Enums.BurnEffects.M203,
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 8,
			Radius = 4.5,
			Duration = 5,
			StickDuration = 5
		}
	},
	Name = "M203",
	DisplayName = "M203 Incendiary",
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.15,
	Icon = "",
	Description = "M203 incendiary.",
	AnimationName = "M203",
	ProjectileName = Enums.Projectiles.M203
}