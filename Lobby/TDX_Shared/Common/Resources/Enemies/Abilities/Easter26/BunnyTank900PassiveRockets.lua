local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	CanRunInParallel = true,
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 1.5,
		Damage = 70,
		BuffName = Enums.TowerBuffs.BunnyTank900PassiveRocketsDebuff
	},
	StartingCooldown = 8,
	Cooldown = 20,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	BurstSize = 4,
	BurstInterval = 0.1,
	EffectsOnlyOnInitialBurst = true,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			ProjectileName = Enums.Projectiles.BunnyTank900PassiveRocket,
			Range = 40,
			MinimumRange = 10,
			MinimumTargetsInRange = 1,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>SingleRocket" }
}