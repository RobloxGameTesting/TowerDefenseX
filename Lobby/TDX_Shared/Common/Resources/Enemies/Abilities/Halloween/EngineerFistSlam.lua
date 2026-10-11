local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 20,
	Cooldown = 45,
	Animated = true,
	Delay = 1.15,
	ExecutionTime = 2.3,
	AnimationName = "Smash Floor",
	EnemyToTowerRangedDataSequence = {
		{
			MinimumTargetsInRange = 3,
			DamageData = { Damage = 500 },
			Range = 18,
			HitAllTargetsInRange = true
		}
	},
	EnemyToTowerRadiusEffectData = {
		DoNotUseForTriggering = true,
		AffectPathEntitiesOnly = true,
		MaximumRange = 18,
		DamageData = { InstantKill = true }
	},
	EffectParentInstanceNames = { "SlamEffectPart" }
}