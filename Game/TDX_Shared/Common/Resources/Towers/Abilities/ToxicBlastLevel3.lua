local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		DamageType = Enums.DamageTypes.Toxic,
		Damage = 250,
		MaximumTargetsHit = 3,
		DamageData = {
			IgnoreResistance = false,
			ExtraDamageData = {
				ExtraDamageHash = "ToxicBlast3",
				Duration = 12,
				DamageMultiplier = 0.2,
				BossDamageMultiplier = 0.1
			}
		}
	},
	Name = "Toxic Blast",
	DisplayName = "Toxic Blast LVL 3",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 13,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.35,
	Icon = "rbxassetid://16142820021",
	Description = "Toxic Blast.",
	AnimationName = "ToxicBlast",
	ProjectileName = Enums.Projectiles.ToxicGrenadePurple,
	IsManualAimAtPath = true,
	HotbarData = { Level = 3 }
}