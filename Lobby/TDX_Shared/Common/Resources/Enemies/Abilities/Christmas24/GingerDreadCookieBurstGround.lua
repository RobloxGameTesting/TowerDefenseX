local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2, Damage = 400 },
	StartingCooldown = 10,
	Cooldown = 35,
	Animated = true,
	Delay = 1.5,
	ExecutionTime = 4.2669999999999995,
	BurstSize = 6,
	BurstInterval = 1,
	CustomBurstDelayMap = { 0.3, 0.35, 0.35, 0.35, 0.35 },
	AnimationName = "CookieBurst",
	SecondaryAnimationForKeyframeEventsName = "Damaged_CookieBurst",
	FaceTarget = true,
	ForceFaceOverideTime = 0.25,
	ForceFaceOverideTimeInitial = 0.8,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			NoTargetGround = false,
			ProjectileName = Enums.Projectiles.CookieMediumArc,
			Range = 50,
			MinimumRange = 5,
			MinimumTargetsInRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {}
}