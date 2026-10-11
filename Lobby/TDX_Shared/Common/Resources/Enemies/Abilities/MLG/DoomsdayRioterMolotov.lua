local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		SplashRadius = 6,
		IsSplash = true,
		BuffName = Enums.TowerBuffs.DoomsdayRioterMolotovDebuff
	},
	StartingCooldown = 1,
	Cooldown = 5,
	Animated = true,
	AnimationName = "Throw",
	Delay = 37 / 60,
	ExecutionTime = 1.35,
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.DoomsdayRioterMolotov,
			Range = 13,
			TargetRandomTower = true
		}
	}
}