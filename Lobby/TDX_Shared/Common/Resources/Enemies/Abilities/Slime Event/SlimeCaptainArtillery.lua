local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		BuffName = Enums.TowerBuffs.SlimeCaptainGooBallFirerateDebuff
	},
	StartingCooldown = 20,
	Cooldown = 35,
	Animated = true,
	AnimationName = "Artillery",
	Delay = 3,
	ExecutionTime = 5.367,
	FaceTarget = false,
	BurstSize = 18,
	BurstInterval = 0,
	CustomBurstDelayMap = {
		[2] = 0,
		[4] = 0.1,
		[6] = 0.1,
		[8] = 0.133,
		[10] = 0.233,
		[12] = 0.066,
		[14] = 0.133,
		[16] = 0.133
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Artillery" },
	EffectParentInstanceNames = {},
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			TargetGroundAroundEnemy = true,
			ProjectileName = Enums.Projectiles.CaptainSlimeGooBallHighArc,
			Range = 20,
			MinimumRange = 2,
			MinimumTargetsInRange = 3,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	}
}