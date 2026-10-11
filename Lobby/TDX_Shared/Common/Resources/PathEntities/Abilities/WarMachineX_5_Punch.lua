local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 5,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 2.2329999999999997,
	AnimationName = "Punch",
	FaceTarget = true,
	PathEntityToEnemyRangedData = {
		Range = 7,
		MinimumRange = 3,
		Damage = 25000,
		DamageType = Enums.DamageTypes.Melee,
		DamageData = {
			StunData = {
				StunType = Enums.StunTypes.SlammerSlam,
				StunDuration = 2.3,
				CanStunBoss = true,
				IgnoreStunResistance = true
			},
			KnockbackData = { KnockbackStuds = 13 }
		},
		BossOrMiniBossOnly = true
	},
	EffectParentInstanceNames = { "Punch" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Punch" }
}