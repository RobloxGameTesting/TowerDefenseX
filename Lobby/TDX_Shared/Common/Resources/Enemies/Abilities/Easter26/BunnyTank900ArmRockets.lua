local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2,
		Damage = 50,
		BuffName = Enums.TowerBuffs.BunnyTank900ArmRocketsDebuff
	},
	StartingCooldown = 10,
	Cooldown = 30,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 2.8,
	BurstSize = 8,
	BurstInterval = 0.03,
	EffectsOnlyOnInitialBurst = true,
	AnimationName = "Rocket Shoot",
	FaceTarget = true,
	FaceTargetOnInitialTargetOnly = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.BunnyTank900Rocket,
			Range = 40,
			MinimumRange = 10,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true,
			TryGetUniqueTargetForEachBurst = true,
			MinimumTargetsInRange = 3
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>ArmRockets" }
}