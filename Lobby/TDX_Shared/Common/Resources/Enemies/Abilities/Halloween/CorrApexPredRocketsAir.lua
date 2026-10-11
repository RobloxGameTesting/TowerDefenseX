local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 150 },
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 1.2,
	ExecutionTime = 3.4669999999999996,
	BurstSize = 48,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		[1] = 0,
		[9] = 0.1,
		[17] = 0.1,
		[25] = 0.1,
		[33] = 0.1,
		[41] = 0.1
	},
	AnimationName = "Rockets",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.CorrApexPredRocket,
			Range = 70,
			MinimumTargetsInRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = { "RootPart>MissileSFX" }
}