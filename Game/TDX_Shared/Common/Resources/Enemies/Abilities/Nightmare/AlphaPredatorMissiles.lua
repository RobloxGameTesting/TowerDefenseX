local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		DamageFalloffRanges = {
			{ Range = 0, Damage = 4000 },
			{ Range = 20, Damage = 3250 },
			{ Range = 40, Damage = 2500 },
			{ Range = 60, Damage = 1500 },
			{ Range = 175, Damage = 23000 }
		},
		BuffName = Enums.TowerBuffs.AlphaPredatorMissileStunDebuff
	},
	StartingCooldown = 15,
	Cooldown = 30,
	Animated = true,
	Delay = 1.333,
	ExecutionTime = 2.8,
	BurstSize = 8,
	BurstInterval = 0.09528571428571429,
	AnimationName = "Missiles",
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.AlphaPredatorMissile,
			Range = 50,
			MinimumRange = 20,
			ConsiderTargetsWithNoAttack = true,
			TargetRandomTower = true
		}
	},
	EffectParentInstanceNames = {},
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Missiles" }
}