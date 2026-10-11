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
	Delay = 2.3,
	ExecutionTime = 0,
	AnimationName = "Death",
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			DamageData = {
				Damage = 0,
				DamageFalloffRanges = {
					{ Range = 3, Damage = 100000 },
					{ Range = 9, Damage = 1000 },
					{ Range = 20, Damage = 700 },
					{ Range = 25, Damage = 400 },
					{ Range = 50, Damage = 200 }
				}
			},
			Range = 50,
			HitAllTargetsInRange = true
		}
	},
	EffectParentInstanceNames = { "DeathAnimationVFX" }
}