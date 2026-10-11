local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3,
		Damage = 200,
		BuffName = Enums.TowerBuffs.RevivedBirdStunDebuff,
		BuffOnlyPrimaryTarget = true
	},
	StartingCooldown = 10,
	Cooldown = 9,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.RevivedPlagueDoctorBird,
			Range = 15,
			TargetMostExpensiveTower = true
		}
	}
}