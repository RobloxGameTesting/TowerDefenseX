local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DoNotTryToUse = true,
	CanRunInParallel = true,
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1.5,
		Damage = 50,
		BuffName = Enums.TowerBuffs.BunnyTank900LaserSpinRocketsDebuff
	},
	StartingCooldown = 1e999,
	Cooldown = 1e999,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 20,
	BurstInterval = 0.25,
	ModelBurstSize = 4,
	EffectsOnlyOnInitialBurst = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.BunnyTank900PassiveRocket,
			Range = 40,
			MinimumRange = 1,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>SingleRocket" }
}