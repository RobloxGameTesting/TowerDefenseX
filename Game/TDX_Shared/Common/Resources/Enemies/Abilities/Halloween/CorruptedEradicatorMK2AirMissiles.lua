local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = true, SplashRadius = 2.5, Damage = 1000 },
	StartingCooldown = 10,
	Cooldown = 25,
	Animated = true,
	Delay = 1,
	ExecutionTime = 2.133,
	BurstSize = 4,
	BurstInterval = 1,
	CustomBurstDelayMap = { 0, 0.08, 0.05, 0.11 },
	AnimationName = "Missiles",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			NoTargetGround = true,
			ProjectileName = Enums.Projectiles.CorruptedEradicatorMK2Rocket,
			Range = 70,
			MinimumTargetsInRange = 2,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = { "Root>MissileSFX" }
}