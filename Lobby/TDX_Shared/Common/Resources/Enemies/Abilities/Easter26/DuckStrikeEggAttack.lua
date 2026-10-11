local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 10,
		BuffName = Enums.TowerBuffs.DuckStrikeDebuff,
		HitDamageFalloffRanges = {
			{ Range = 5, Damage = 200 },
			{ Range = 10, Damage = 50 }
		}
	},
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 49 / 60,
	ExecutionTime = 29 / 15,
	AnimationName = "EggAttack",
	EnemyToTowerRangedDataSequence = {
		{ ProjectileName = Enums.Projectiles.DuckStrikeEgg, Range = 0, TargetPath = true }
	}
}