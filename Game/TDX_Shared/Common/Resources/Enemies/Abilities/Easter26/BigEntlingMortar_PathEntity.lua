local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 7.5,
		Damage = 350,
		BuffName = Enums.TowerBuffs.BigEntlingDebuff
	},
	StartingCooldown = 5,
	Cooldown = 35,
	Animated = true,
	Delay = 61 / 60,
	ExecutionTime = 2.35,
	AnimationName = "EggMortar",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.BigEntlingProjectile,
			Range = 40,
			TargetPathEntitiesOnly = true
		}
	}
}