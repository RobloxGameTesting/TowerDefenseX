local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		DamageType = Enums.DamageTypes.Toxic,
		Damage = 150,
		MaximumTargetsHit = 3,
		DamageData = {
			IgnoreResistance = false,
			ExtraDamageData = {
				ExtraDamageHash = "ToxicBlast2",
				Duration = 9,
				DamageMultiplier = 0.15,
				BossDamageMultiplier = 0
			}
		}
	},
	Name = "Toxic Blast",
	DisplayName = "Toxic Blast LVL 2",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 14,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.35,
	Icon = "rbxassetid://16142820021",
	Description = "Toxic Blast.",
	AnimationName = "ToxicBlast",
	ProjectileName = Enums.Projectiles.ToxicGrenadePurple,
	IsManualAimAtPath = true,
	HotbarData = { Level = 2 }
}