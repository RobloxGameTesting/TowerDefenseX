local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 7,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 6250 },
			{ Range = 80, Damage = 28500 }
		}
	},
	StartingCooldown = 11,
	Cooldown = 20,
	Animated = true,
	AnimationName = "CruiseMissileAA",
	Delay = 1.8,
	ExecutionTime = 2.867,
	FaceTarget = true,
	BurstSize = 3,
	BurstInterval = 0,
	ModelBurstSize = 3,
	InstantPlayEffectParentInstanceNames = { "CruiseMissileTriple>SFX" },
	EffectParentInstanceNames = {},
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = false,
			ProjectileName = Enums.Projectiles.EradicatorMK2ReworkCruiseMissileNaval,
			Range = 2000,
			MinimumRange = 100,
			TargetHighestRangeTower = true,
			TargetMinimumValue = 100000,
			TowerTypeIncludeMap = {
				[Enums.Towers.Warship] = true,
				[Enums.Towers.GoldenWarship] = true
			}
		}
	}
}