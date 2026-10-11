local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 0,
	Animated = false,
	CanRunInParallel = true,
	Delay = 4.9,
	ExecutionTime = 0,
	AnimationName = "Death",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 10, Damage = 100000 },
					{ Range = 15, Damage = 3000 },
					{ Range = 20, Damage = 2500 },
					{ Range = 22, Damage = 1300 },
					{ Range = 25, Damage = 700 },
					{ Range = 50, Damage = 500 }
				}
			},
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "DeathAnimationVFX" }
}