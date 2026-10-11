local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 5,
		Damage = 50,
		BuffName = Enums.TowerBuffs.IronBastionStunDebuff,
		BuffName2 = Enums.TowerBuffs.IronBastionFirerateDebuff
	},
	StartingCooldown = 3,
	Cooldown = 8,
	Animated = true,
	Delay = 1.65,
	ExecutionTime = 4.8,
	AnimationName = "Throw",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.IronBastionHammer,
			Range = 25,
			MinimumRange = 10,
			TargetRandomTower = true
		}
	}
}